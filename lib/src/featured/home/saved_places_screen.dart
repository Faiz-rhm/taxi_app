import 'package:flutter/material.dart';
import '../../helper/constants/app_colors.dart';

class SavedPlacesScreen extends StatefulWidget {
  const SavedPlacesScreen({super.key});

  @override
  State<SavedPlacesScreen> createState() => _SavedPlacesScreenState();
}

class _SavedPlacesScreenState extends State<SavedPlacesScreen> {
  int _selectedIndex = 0;

  final List<String> _savedPlaces = [
    '2972 Westheimer Rd. San..',
    '2118 Thornridge Cir. Syra..',
    '6391 Elgin St. Celina, Dela..',
    '6391 Elgin St. Celina, Del..',
    '2715 Ash Dr. San Jose, So..',
    '4140 Parker Rd. Allentow..',
    '4517 Washington Ave...',
    '6391 Elgin St. Celina, Dela..',
    '3891 Ranchview Dr. Ric..',
    '2972 Westheimer Rd. San..',
    '3517 W. Gray St. Utica, Pe..',
    '2972 Westheimer Rd. San..',
  ];

  void _selectPlace(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _deletePlace(int index) {
    setState(() {
      _savedPlaces.removeAt(index);
      if (_selectedIndex >= _savedPlaces.length) {
        _selectedIndex = _savedPlaces.length - 1;
      }
      if (_selectedIndex < 0) {
        _selectedIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryText,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Saved Places',
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // List of saved places
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _savedPlaces.length,
              itemBuilder: (context, index) {
                final isSelected = index == _selectedIndex;
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      // Radio button
                      GestureDetector(
                        onTap: () => _selectPlace(index),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? AppColors.primary : AppColors.borderMedium,
                              width: 2,
                            ),
                            color: isSelected ? AppColors.primary : Colors.transparent,
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.check,
                                  size: 12,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Address text
                      Expanded(
                        child: Text(
                          _savedPlaces[index],
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Delete button
                      GestureDetector(
                        onTap: () => _deletePlace(index),
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primary,
                              width: 1.5,
                            ),
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 14,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Continue button
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // Handle continue action
                    Navigator.pop(context, _savedPlaces[_selectedIndex]);
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: const Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
