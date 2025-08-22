import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapConfigService {
  static const MapConfigService _instance = MapConfigService._internal();
  factory MapConfigService() => _instance;
  const MapConfigService._internal();

  /// Get optimized map configuration to reduce buffer issues
  Map<String, dynamic> getOptimizedMapConfig() {
    return {
      'liteModeEnabled': false,
      'trafficEnabled': false,
      'buildingsEnabled': false,
      'indoorViewEnabled': false,
      'myLocationEnabled': true,
      'myLocationButtonEnabled': false,
      'zoomControlsEnabled': false,
      'mapToolbarEnabled': false,
      'compassEnabled': false,
      'mapType': MapType.normal,
      // Reduce unnecessary callbacks that can cause buffer issues
      'onCameraMove': null,
      'onCameraIdle': null,
      'onTap': null,
      'onLongPress': null,
    };
  }

  /// Get optimized camera position with reduced zoom to minimize buffer usage
  CameraPosition getOptimizedCameraPosition(LatLng target, {double zoom = 14.0}) {
    return CameraPosition(
      target: target,
      zoom: zoom.clamp(10.0, 18.0), // Limit zoom range to reduce buffer usage
      tilt: 0, // Reduce 3D rendering
      bearing: 0, // Reduce rotation calculations
    );
  }

  /// Get optimized marker configuration
  Set<Marker> getOptimizedMarkers(Set<Marker> markers) {
    // Limit the number of markers to reduce buffer usage
    if (markers.length > 20) {
      return markers.take(20).toSet();
    }
    return markers;
  }

  /// Dispose map controller safely
  void disposeMapController(GoogleMapController? controller) {
    try {
      controller?.dispose();
    } catch (e) {
      debugPrint('Error disposing map controller: $e');
    }
  }
}
