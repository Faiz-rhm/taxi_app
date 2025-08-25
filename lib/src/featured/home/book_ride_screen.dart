import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../helper/constants/app_colors.dart';
import '../profile/payment_methods_screen.dart';
import '../../core/widgets/cancel_booking_bottom_sheet.dart';
import 'dart:math';
import 'ride_accepted_screen.dart';

class BookRideScreen extends StatefulWidget {
  final LatLng pickupLocation;
  final LatLng? destinationLocation;

  const BookRideScreen({
    super.key,
    required this.pickupLocation,
    this.destinationLocation,
  });

  @override
  State<BookRideScreen> createState() => _BookRideScreenState();
}

class _BookRideScreenState extends State<BookRideScreen> {
  String _selectedRideType = 'Mini';
  String _selectedPaymentMethod = 'Cash';
  String _selectedBookingType = 'Book for self';
  bool _hasPromo = false;
  GoogleMapController? _mapController;

  // Schedule ride variables
  DateTime? _scheduledDate;
  TimeOfDay? _scheduledTime;
  bool _isScheduled = false;

  // Ride booking states
  bool _isSearchingRide = false;
  bool _isRideFound = false;
  bool _isDriverAssigned = false;
  bool _isRideNotFound = false;

  // Driver information
  Map<String, dynamic>? _driverInfo;

  // Custom marker icons
  BitmapDescriptor? _pickupIcon;
  BitmapDescriptor? _destinationIcon;
  bool _isLoadingMarkers = true;

  // Sample ride options
  final List<Map<String, dynamic>> _rideOptions = [
    {
      'type': 'Mini',
      'icon': Icons.directions_car,
      'waitTime': '5 Min',
      'price': '\$1.0/mile',
      'capacity': '3 Seats Capacity',
      'isSelected': true,
    },
    {
      'type': 'Sedan',
      'icon': Icons.directions_car,
      'waitTime': '9 Min',
      'price': '₹1.25/mile',
      'capacity': '4 Seats Capacity',
      'isSelected': false,
    },
    {
      'type': 'SUV',
      'icon': Icons.directions_car,
      'waitTime': '12 Min',
      'price': '₹1.5/mile',
      'capacity': '6 Seats Capacity',
      'isSelected': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _updateRideSelection();
    _createCustomMarkers();
  }

  Future<void> _createCustomMarkers() async {
    setState(() {
      _isLoadingMarkers = true;
    });

    try {
      _pickupIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)),
        'assets/images/pine.png',
      );
      _destinationIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)),
        'assets/images/pine1.png',
      );
    } catch (e) {
      // Fallback to default markers if custom icons fail to load
      _pickupIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      _destinationIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      print('Failed to load custom marker icons: $e');
    }

    setState(() {
      _isLoadingMarkers = false;
    });
  }

  // Method to refresh markers if needed
  Future<void> _refreshMarkers() async {
    if (_pickupIcon == null || _destinationIcon == null) {
      await _createCustomMarkers();
    }
  }

  // Handle marker tap events
  void _onMarkerTapped(String markerId) {
    switch (markerId) {
      case 'start':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pickup Location'),
            duration: Duration(seconds: 2),
          ),
        );
        break;
      case 'end':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Destination'),
            duration: Duration(seconds: 2),
          ),
        );
        break;
    }
  }

  // Method to get marker color based on type
  Color _getMarkerColor(String markerId) {
    switch (markerId) {
      case 'start':
        return Colors.green;
      case 'end':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Method to get marker icon based on type
  IconData _getMarkerIcon(String markerId) {
    switch (markerId) {
      case 'start':
        return Icons.location_on;
      case 'end':
        return Icons.flag;
      default:
        return Icons.location_on;
    }
  }

  // Method to show detailed marker information
  void _showMarkerDetails(String markerId) {
    String title = '';
    String description = '';
    IconData icon = Icons.location_on;
    Color color = Colors.blue;

    switch (markerId) {
      case 'start':
        title = 'Pickup Location';
        description = 'This is where your ride will start from. Make sure you\'re at this location when the driver arrives.';
        icon = Icons.location_on;
        color = Colors.green;
        break;
      case 'end':
        title = 'Destination';
        description = 'This is your final destination. The driver will take you here safely.';
        icon = Icons.flag;
        color = Colors.red;
        break;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Text(title),
            ],
          ),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _fitMapBounds();
  }

  void _fitMapBounds() {
    if (_mapController != null) {
      // Calculate the end point to include in bounds
      double latOffset = 0.002;
      double lngOffset = 0.002;

      LatLng endPoint = LatLng(
        widget.pickupLocation.latitude - (latOffset * 1.2),
        widget.pickupLocation.longitude + (lngOffset * 1.0),
      );

      // Create bounds that include both start and end markers
      double minLat = widget.pickupLocation.latitude < endPoint.latitude
          ? widget.pickupLocation.latitude
          : endPoint.latitude;
      double maxLat = widget.pickupLocation.latitude > endPoint.latitude
          ? widget.pickupLocation.latitude
          : endPoint.latitude;
      double minLng = widget.pickupLocation.longitude < endPoint.longitude
          ? widget.pickupLocation.longitude
          : endPoint.longitude;
      double maxLng = widget.pickupLocation.longitude > endPoint.longitude
          ? widget.pickupLocation.longitude
          : endPoint.longitude;

      // Add some padding around the bounds
      double latPadding = (maxLat - minLat) * 0.15;
      double lngPadding = (maxLng - minLng) * 0.15;

      _mapController!.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(minLat - latPadding, minLng - lngPadding),
            northeast: LatLng(maxLat + latPadding, maxLng + lngPadding),
          ),
          50.0, // padding in pixels
        ),
      );
    }
  }

  void _updateRideSelection() {
    for (int i = 0; i < _rideOptions.length; i++) {
      _rideOptions[i]['isSelected'] = _rideOptions[i]['type'] == _selectedRideType;
    }
  }

  void _selectRideType(String type) {
    setState(() {
      _selectedRideType = type;
      _updateRideSelection();
    });
  }

  void _showPaymentOptions() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentMethodsScreen(
          selectedPaymentMethod: _selectedPaymentMethod,
        ),
      ),
    );

    if (result != null && result is String) {
      setState(() {
        _selectedPaymentMethod = result;
      });
    }
  }

  void _showBookingOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildBookingOptionsSheet(),
    );
  }

  Widget _buildBookingOptionsSheet() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                  "Someone else taking this ride?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Choose a contact so that they also get driver number, vehicle details and ride OTP vis SMS.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
          ],
        ),
      ),

          // Options
          _buildRiderOption(
            icon: Icons.person,
            title: "My Self",
            isSelected: _selectedBookingType == "Book for self",
      onTap: () {
        setState(() {
                _selectedBookingType = "Book for self";
        });
        Navigator.pop(context);
      },
          ),

          // Separator
          Divider(
            color: Colors.grey[300],
            height: 1,
            indent: 20,
            endIndent: 20,
          ),

          _buildRiderOption(
            icon: Icons.person,
            title: "John Doe",
            subtitle: "(239) 555-0108",
            isSelected: _selectedBookingType == "Book for John Doe",
            onTap: () {
              setState(() {
                _selectedBookingType = "Book for John Doe";
              });
              Navigator.pop(context);
            },
            showAvatar: true,
            avatarText: "J",
          ),

          _buildRiderOption(
            icon: Icons.people,
            title: "Choose another contacts",
            isSelected: false,
            onTap: _chooseAnotherContact,
            showArrow: true,
          ),

          // Separator
          Divider(
            color: Colors.grey[300],
            height: 1,
            indent: 20,
            endIndent: 20,
          ),

          // Schedule Ride Option
          _buildRiderOption(
            icon: Icons.schedule,
            title: "Schedule ride",
            isSelected: _selectedBookingType == "Schedule ride",
            onTap: () {
              Navigator.pop(context);
              _showScheduleRide();
            },
          ),

          const SizedBox(height: 20),

          // Confirm Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Confirm",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // Bottom safe area
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildRiderOption({
    required IconData icon,
    required String title,
    String? subtitle,
    required bool isSelected,
    required VoidCallback onTap,
    bool showAvatar = false,
    String? avatarText,
    bool showArrow = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
          children: [
              // Radio button or empty space
              if (!showArrow)
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : Colors.grey[300]!,
                      width: 2,
                    ),
                    color: isSelected ? AppColors.primary : Colors.white,
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14,
                        )
                      : null,
                )
              else
                const SizedBox(width: 20),

              const SizedBox(width: 16),

              // Icon or Avatar
              if (showAvatar && avatarText != null)
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      avatarText,
                      style: const TextStyle(
                        color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
                  ),
                )
              else
                Icon(
                  icon,
                  color: AppColors.primary,
                  size: 24,
                ),

              const SizedBox(width: 16),

              // Title and Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryText,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
          ],
        ),
      ),

              // Arrow for "Choose another contacts"
              if (showArrow)
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[400],
                  size: 16,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPromoOptions() async {
    final result = await Navigator.pushNamed(context, '/promo');
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _hasPromo = true;
      });

      if (result['couponCode'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Coupon "${result['couponCode']}" applied successfully!'),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    }
  }



  void _chooseAnotherContact() {
    // TODO: Navigate to contacts selection screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Contacts selection coming soon!'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _bookRide() {
    // Start searching for ride
    setState(() {
      _isSearchingRide = true;
      _isRideFound = false;
      _isDriverAssigned = false;
      _isRideNotFound = false;
      _driverInfo = null;
    });

    // Simulate searching for ride (3 seconds)
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // Simulate 70% chance of finding a ride
        final random = Random();
        final rideFound = random.nextDouble() > 0.3;

        if (rideFound) {
          setState(() {
            _isSearchingRide = false;
            _isRideFound = true;
          });

          // Simulate driver assignment (2 seconds)
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
              setState(() {
                _isDriverAssigned = true;
                _driverInfo = {
                  'name': 'Jenny Wilson',
                  'vehicle': 'Sedan (4 Seater)',
                  'price': '\$1.25/ per mile',
                  'plateNumber': 'GR 678-UVWX',
                  'eta': '5 min Away',
                  'rating': 4.8,
                  'avatar': 'assets/images/user6.jpg',
                };
              });
            }
          });
        } else {
          // Ride not found
          setState(() {
            _isSearchingRide = false;
            _isRideNotFound = true;
          });
        }
      }
    });
  }

  void _showScheduleRide() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildScheduleRideSheet(),
    );
  }

  Widget _buildScheduleRideSheet() {
    return StatefulBuilder(
      builder: (context, setModalState) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
        children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Schedule Ride",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedBookingType = "Book for self";
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        "RIDE NOW",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Separator
              Divider(
                color: Colors.grey[300],
                height: 1,
                indent: 20,
                endIndent: 20,
              ),

              // Date and Time Picker
          Expanded(
                child: _buildDateTimePicker(setModalState),
              ),

              // Confirm Button
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle schedule confirmation
                      setState(() {
                        // Set default time if none selected
                        _scheduledTime ??= const TimeOfDay(hour: 12, minute: 0);

                        // Set default date if none selected
                        _scheduledDate ??= DateTime.now().add(const Duration(days: 1));

                        _isScheduled = true;
                        _selectedBookingType = "Schedule ride";
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Ride scheduled for ${_formatScheduledDateTime()}'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Confirm",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              // Bottom safe area
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDateTimePicker(StateSetter? setModalState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
          const SizedBox(height: 20),

          // Date Picker
          _buildDatePicker(setModalState),

          const SizedBox(height: 30),

          // Time Picker
          _buildTimePicker(setModalState),
        ],
      ),
    );
  }

  Widget _buildDatePicker(StateSetter? setModalState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Date",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText,
          ),
        ),
                  const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (context, index) {
              final date = DateTime.now().add(Duration(days: index));
              final isSelected = _scheduledDate != null &&
                  _scheduledDate!.day == date.day &&
                  _scheduledDate!.month == date.month;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _scheduledDate = date;
                  });
                  // Update modal state for immediate UI feedback
                  if (setModalState != null) {
                    setModalState(() {});
                  }
                },
                child: Container(
                  width: 80,
                  margin: EdgeInsets.only(right: index < 6 ? 12 : 0),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _getDayName(date.weekday),
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[600],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${date.day}",
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppColors.primaryText,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _getMonthName(date.month),
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[600],
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTimePicker(StateSetter? setModalState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Time",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText,
          ),
        ),
                  const SizedBox(height: 16),
        Row(
          children: [
            // Hour Picker
            Expanded(
              child: _buildTimeColumn(
                title: "Hour",
                values: List.generate(24, (index) => index.toString().padLeft(2, '0')),
                selectedValue: _scheduledTime?.hour.toString().padLeft(2, '0') ?? "00",
                onValueChanged: (value) {
                  setState(() {
                    final currentTime = _scheduledTime ?? const TimeOfDay(hour: 0, minute: 0);
                    _scheduledTime = TimeOfDay(
                      hour: int.parse(value),
                      minute: currentTime.minute,
                    );
                  });
                  // Update modal state for immediate UI feedback
                  if (setModalState != null) {
                    setModalState(() {});
                  }
                },
              ),
            ),

            const SizedBox(width: 20),

            // Minute Picker
            Expanded(
              child: _buildTimeColumn(
                title: "Minute",
                values: List.generate(60, (index) => index.toString().padLeft(2, '0')),
                selectedValue: _scheduledTime?.minute.toString().padLeft(2, '0') ?? "00",
                onValueChanged: (value) {
                  setState(() {
                    final currentTime = _scheduledTime ?? const TimeOfDay(hour: 0, minute: 0);
                    _scheduledTime = TimeOfDay(
                      hour: currentTime.hour,
                      minute: int.parse(value),
                    );
                  });
                  // Update modal state for immediate UI feedback
                  if (setModalState != null) {
                    setModalState(() {});
                  }
                },
              ),
            ),

            const SizedBox(width: 20),

            // AM/PM Picker (12-hour format)
            Expanded(
              child: _buildTimeColumn(
                title: "Period",
                values: ["AM", "PM"],
                selectedValue: _scheduledTime != null && _scheduledTime!.hour >= 12 ? "PM" : "AM",
                onValueChanged: (value) {
                  setState(() {
                    final currentTime = _scheduledTime ?? const TimeOfDay(hour: 0, minute: 0);
                    int newHour = currentTime.hour;

                    if (value == "PM" && currentTime.hour < 12) {
                      newHour = currentTime.hour + 12;
                    } else if (value == "AM" && currentTime.hour >= 12) {
                      newHour = currentTime.hour - 12;
                    }

                    _scheduledTime = TimeOfDay(
                      hour: newHour,
                      minute: currentTime.minute,
                    );
                  });
                  // Update modal state for immediate UI feedback
                  if (setModalState != null) {
                    setModalState(() {});
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeColumn({
    required String title,
    required List<String> values,
    required String selectedValue,
    required Function(String) onValueChanged,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListWheelScrollView(
            itemExtent: 40,
            diameterRatio: 1.5,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              onValueChanged(values[index]);
            },
            children: values.map((value) {
              final isSelected = value == selectedValue;
              return Center(
                child: Text(
                  value,
                  style: TextStyle(
                    color: isSelected ? AppColors.primary : Colors.grey[600],
                    fontSize: isSelected ? 18 : 16,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1: return "Mon";
      case 2: return "Tue";
      case 3: return "Wed";
      case 4: return "Thu";
      case 5: return "Fri";
      case 6: return "Sat";
      case 7: return "Sun";
      default: return "Mon";
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1: return "Jan";
      case 2: return "Feb";
      case 3: return "Mar";
      case 4: return "Apr";
      case 5: return "May";
      case 6: return "Jun";
      case 7: return "Jul";
      case 8: return "Aug";
      case 9: return "Sep";
      case 10: return "Oct";
      case 11: return "Nov";
      case 12: return "Dec";
      default: return "Jan";
    }
  }

  String _formatScheduledDateTime() {
    if (_scheduledDate != null && _scheduledTime != null) {
      return "${_getDayName(_scheduledDate!.weekday)} ${_scheduledDate!.day} ${_getMonthName(_scheduledDate!.month)} at ${_scheduledTime!.format(context)}";
    }
    return "Tomorrow at 12:00 PM";
  }

  String _getScheduledTimeText() {
    if (_scheduledTime != null) {
      return "${_scheduledTime!.hour.toString().padLeft(2, '0')}:${_scheduledTime!.minute.toString().padLeft(2, '0')} ${_scheduledTime!.period.toString().substring(0, 2)}";
    }
    return "Now";
  }

  void _requestRide() {
    // Simulate ride request being sent
    setState(() {
      _isDriverAssigned = false;
    });

    // Simulate driver accepting the ride (3 seconds)
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // Navigate to the ride accepted screen
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RideAcceptedScreen(
              driverInfo: _driverInfo ?? {},
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full Screen Google Map
          _buildFullScreenMap(),

          // Header with back button and title
          _buildHeader(),

          // Map controls (zoom, refresh markers)
          _buildMapControls(),

          // Content based on ride state
          if (_isSearchingRide)
            _buildSearchingRideOverlay()
          else if (_isRideFound && _isDriverAssigned)
            _buildDriverInfoOverlay()
          else if (_isRideFound)
            _buildRideFoundOverlay()
          else if (_isRideNotFound)
            _buildRideNotFoundOverlay()
          else
            // DraggableScrollableSheet overlay
            _buildDraggableSheet(),

          // Bottom Button based on state
          if (_isSearchingRide)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildSearchingButton(),
            )
          else if (_isRideFound && !_isDriverAssigned)
            SizedBox()
          else if (_isDriverAssigned)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(), // No bottom button needed, Request Ride is in the overlay
            )
          else if (_isRideNotFound)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildTryAgainButton(),
            )
          else
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBookButton(),
            ),
        ],
      ),
    );
  }

  Widget _buildFullScreenMap() {
    // Create a polyline near the user's location (pickup location)
    List<LatLng> routePoints = [];

    // Add pickup location as starting point
    routePoints.add(widget.pickupLocation);

    // Create a more realistic route that follows road patterns
    // This simulates a route that would be taken from the pickup location
    double latOffset = 0.002; // Larger offset for more visible route
    double lngOffset = 0.002;

    // Add waypoints to create a route that follows road patterns
    // Start going diagonally down and right (crossing streets)
    routePoints.add(LatLng(
      widget.pickupLocation.latitude - (latOffset * 0.3),
      widget.pickupLocation.longitude + (lngOffset * 0.4),
    ));

    // Continue down and right
    routePoints.add(LatLng(
      widget.pickupLocation.latitude - (latOffset * 0.6),
      widget.pickupLocation.longitude + (lngOffset * 0.7),
    ));

    // Make a sharp turn to the right (parallel to road)
    routePoints.add(LatLng(
      widget.pickupLocation.latitude - (latOffset * 0.6),
      widget.pickupLocation.longitude + (lngOffset * 1.0),
    ));

    // Continue right for a short segment
    routePoints.add(LatLng(
      widget.pickupLocation.latitude - (latOffset * 0.5),
      widget.pickupLocation.longitude + (lngOffset * 1.2),
    ));

    // Make another sharp turn down and left
    routePoints.add(LatLng(
      widget.pickupLocation.latitude - (latOffset * 0.8),
      widget.pickupLocation.longitude + (lngOffset * 0.8),
    ));

    // Continue diagonally down and right to endpoint
    routePoints.add(LatLng(
      widget.pickupLocation.latitude - (latOffset * 1.2),
      widget.pickupLocation.longitude + (lngOffset * 1.0),
    ));

    // Calculate the end point for the marker
    LatLng endPoint = LatLng(
      widget.pickupLocation.latitude - (latOffset * 1.2),
      widget.pickupLocation.longitude + (lngOffset * 1.0),
    );

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: widget.pickupLocation,
        zoom: 16.0, // Closer zoom to show local area
      ),
      markers: {
        // Start marker (pickup location) with custom pine icon
        Marker(
          markerId: const MarkerId('start'),
          position: widget.pickupLocation,
          icon: _pickupIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: InfoWindow(
            title: 'Pickup Location',
            snippet: 'Tap for details',
            onTap: () => _showMarkerDetails('start'),
          ),
          onTap: () => _onMarkerTapped('start'),
        ),
        // End marker (destination) with custom pine1 icon
        Marker(
          markerId: const MarkerId('end'),
          position: endPoint,
          icon: _destinationIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(
            title: 'Destination',
            snippet: 'Tap for details',
            onTap: () => _showMarkerDetails('end'),
          ),
          onTap: () => _onMarkerTapped('end'),
        ),
      },
      polylines: {
        Polyline(
          polylineId: const PolylineId('local_route'),
          points: routePoints,
          color: const Color(0xFF424242), // Dark grey color matching the image
          width: 4,
          geodesic: false, // Use straight lines for road-like appearance
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          jointType: JointType.round,
        ),
      },
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      compassEnabled: false,
      mapType: MapType.normal,
      liteModeEnabled: false,
      trafficEnabled: false,
      buildingsEnabled: false,
      indoorViewEnabled: false,
      onMapCreated: _onMapCreated,
    );
  }

  // Add a floating action button to refresh markers
  Widget _buildMapControls() {
    return Positioned(
      right: 16,
      bottom: 200, // Position above the bottom buttons
      child: Column(
        children: [
          // Refresh markers button
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: _isLoadingMarkers ? null : _refreshMarkers,
              icon: _isLoadingMarkers
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    )
                  : const Icon(
                      Icons.refresh,
                      color: Colors.blue,
                      size: 24,
                    ),
              tooltip: _isLoadingMarkers ? 'Loading Markers...' : 'Refresh Markers',
            ),
          ),
          const SizedBox(height: 16),
          // Zoom in button
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {
                _mapController?.animateCamera(
                  CameraUpdate.zoomIn(),
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.blue,
                size: 24,
              ),
              tooltip: 'Zoom In',
            ),
          ),
          const SizedBox(height: 16),
          // Zoom out button
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {
                _mapController?.animateCamera(
                  CameraUpdate.zoomOut(),
                );
              },
              icon: const Icon(
                Icons.remove,
                color: Colors.blue,
                size: 24,
              ),
              tooltip: 'Zoom Out',
            ),
          ),
          const SizedBox(height: 16),
          // Marker status indicator
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _pickupIcon != null ? Icons.check_circle : Icons.pending,
                  color: _pickupIcon != null ? Colors.green : Colors.orange,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  'Pine',
                  style: TextStyle(
                    fontSize: 12,
                    color: _pickupIcon != null ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _destinationIcon != null ? Icons.check_circle : Icons.pending,
                  color: _destinationIcon != null ? Colors.green : Colors.orange,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  'Pine1',
                  style: TextStyle(
                    fontSize: 12,
                    color: _destinationIcon != null ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            right: 16,
          child: Row(
            children: [
              // Back Button
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 20,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),

              const SizedBox(width: 16),

          Spacer(),

              // Title
              const Text(
                "Book Ride",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText,
                ),
              ),

          const SizedBox(width: 50),

          Spacer(),
        ],
      ),
    );
  }

  Widget _buildDraggableSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
        Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
          decoration: BoxDecoration(
            color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    // Pickup and Drop-off Information
                    _buildAddressSection(),

                    const SizedBox(height: 16),

                    // Time Selection
                    _buildTimeSelection(),

                    const SizedBox(height: 16),

                    // Vehicle Type Selection
                    _buildRideTypeSelection(),

                    const SizedBox(height: 16),

                    // Payment Method
                    _buildOptionCard(
                      icon: Icons.money,
                      title: _selectedPaymentMethod,
                      onTap: _showPaymentOptions,
                    ),

                    const SizedBox(height: 12),

                    // Booking For
                    _buildOptionCard(
                      icon: Icons.person,
                      title: _selectedBookingType,
                      onTap: _showBookingOptions,
                    ),

                    const SizedBox(height: 12),

                    // Apply Promo
                    _buildOptionCard(
                      icon: Icons.local_offer,
                      title: _hasPromo ? "Promo Applied" : "Apply Promo",
                      onTap: _showPromoOptions,
                      hasPromo: _hasPromo,
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddressSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pickup Location
          Row(
            children: [
              Icon(Icons.circle_outlined),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "6391 Elgin St. Celina, Delawa...",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),

          // Connecting Line
          Container(
            margin: const EdgeInsets.only(left: 12),
            width: 2,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(1),
            ),
          ),

          // Destination Location
          Row(
            children: [
              Icon(Icons.location_pin, color: AppColors.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "1901 Thornridge Cir. Sh...",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "16 miles",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSelection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _showScheduleRide,
          borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          Icon(
            Icons.access_time,
            color: AppColors.primary,
            size: 20,
          ),
          const SizedBox(width: 12),
              Text(
                _isScheduled ? _getScheduledTimeText() : "Now",
                style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey[400],
            size: 16,
          ),
        ],
          ),
        ),
      ),
    );
  }

  Widget _buildRideTypeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Ride Type",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _rideOptions.length,
            itemBuilder: (context, index) {
              final option = _rideOptions[index];
              return Container(
                width: 180,
                margin: EdgeInsets.only(right: index < _rideOptions.length - 1 ? 12 : 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: option['isSelected'] ? AppColors.primary : Colors.grey[300]!,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () => _selectRideType(option['type']),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              option['icon'],
                              color: option['isSelected'] ? AppColors.primary : Colors.grey[600],
                              size: 30,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              option['waitTime'],
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: 4),

                            Divider(
                              color: Colors.grey[300],
                              thickness: 1,
                            ),

                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            Text(
                              option['type'],
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              option['price'],
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              option['capacity'],
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (option['isSelected'])
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool hasPromo = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            icon,
            color: hasPromo ? AppColors.success : AppColors.primary,
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: hasPromo ? AppColors.success : AppColors.primaryText,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey[400],
            size: 16,
          ),
        ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookButton() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _bookRide,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              "Book $_selectedRideType",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchingRideOverlay() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
              const SizedBox(height: 16),
              const Text(
                "Searching for a ride...",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRideFoundOverlay() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                color: AppColors.success,
                size: 80,
              ),
              const SizedBox(height: 16),
              const Text(
                "Ride Found!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Your ride is on its way. Sit back and relax.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRideNotFoundOverlay() {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.5,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Illustration Section
                      SizedBox(
                        height: 200,
                        child: Stack(
                          children: [
                            // Background elements
                            Positioned(
                              right: 20,
                              top: 20,
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.grey[400],
                                  size: 30,
                                ),
                              ),
                            ),

                            // Phone with map
                            Positioned(
                              left: 20,
                              top: 40,
                              child: Container(
                                width: 80,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey[300]!, width: 2),
                                ),
                                child: Column(
                                  children: [
                                    // Phone screen
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Stack(
                                          children: [
                                            // Map background
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                            ),
                                            // Route line
                                            Positioned(
                                              top: 20,
                                              left: 10,
                                              right: 10,
                                              child: Container(
                                                height: 2,
                                                decoration: BoxDecoration(
                                                  color: AppColors.primary,
                                                  borderRadius: BorderRadius.circular(1),
                                                ),
                                              ),
                                            ),
                                            // Location pin
                                            Positioned(
                                              bottom: 15,
                                              right: 15,
                                              child: Container(
                                                width: 8,
                                                height: 8,
                                                decoration: BoxDecoration(
                                                  color: AppColors.primary,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Person character
                            Positioned(
                              right: 40,
                              bottom: 20,
                              child: SizedBox(
                                width: 100,
                                height: 120,
                                child: Column(
                                  children: [
                                    // Head
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF5D0C5),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Body (orange shirt)
                                    Container(
                                      width: 60,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Container(
                                          width: 50,
                                          height: 2,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.3),
                                            borderRadius: BorderRadius.circular(1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    // Legs
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 15,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF2C2C2C),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Container(
                                          width: 15,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF2C2C2C),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Building outlines
                            Positioned(
                              left: 10,
                              bottom: 10,
                              child: Container(
                                width: 40,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Message Section
                      const Text(
                        "Ride Not Found",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        "please try again in a few minutes",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.secondaryText,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const Spacer(),
                    ],
                  ),
                ),
              ),

              // Try Again Button
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Reset to initial state and try again
                      setState(() {
                        _isRideNotFound = false;
                        _isSearchingRide = false;
                        _isRideFound = false;
                        _isDriverAssigned = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Try Again",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              // Bottom safe area
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDriverInfoOverlay() {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.3,
      maxChildSize: 0.6,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header with Ride Founded and ETA
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    const Text(
                      "Ride Founded",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "5 min Away",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Driver Information
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Driver Profile Section
                      Row(
                        children: [
                          // Driver Avatar
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/driver-profile');
                            },
                            child:                           Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                image: AssetImage('assets/images/user6.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          ),

                          const SizedBox(width: 16),

                          // Driver Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _driverInfo?['name'] ?? 'Driver Name',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryText,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _driverInfo?['vehicle'] ?? 'Vehicle Type',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Price and Ride Code
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                _driverInfo?['price'] ?? '\$0.00/mile',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _driverInfo?['plateNumber'] ?? 'RIDE-CODE',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Additional Driver Info
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${_driverInfo?['rating'] ?? 4.8} Rating',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryText,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.verified,
                              color: AppColors.success,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Verified Driver',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // Request Ride Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _requestRide,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            "Request Ride",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchingButton() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: null, // Disabled during search
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[400],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              "Searching...",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTryAgainButton() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _bookRide, // Reset to initial state and try again
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              "Try Again",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleCancelRide() {
    // Reset to initial state
    setState(() {
      _isRideFound = false;
      _isSearchingRide = false;
      _isDriverAssigned = false;
      _isRideNotFound = false;
    });

    // Show success bottom sheet
    showCancelBookingBottomSheet(
      context,
      bookingReference: '854HG23', // This should come from actual booking data
      onGotIt: () {
        Navigator.pop(context); // Close the bottom sheet
      },
    );
  }
}
