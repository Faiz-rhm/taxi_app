class AppConfig {
  // Google Maps API Configuration
  // Get your API key from: https://console.cloud.google.com/apis/credentials

  // TODO: Replace with your actual Google Maps API key
  static const String googleMapsApiKey = 'AIzaSyAB0ZdfHb1mWv-7LzLk23vRihEtqoB6ttM';

  // Enable/disable features
  static const bool enableDynamicRouting = true;
  static const bool enableRouteCaching = true;

  // Route preferences
  static const String defaultRouteMode = 'driving'; // driving, walking, bicycling, transit
  static const bool avoidHighways = true;
  static const bool avoidTolls = false;

  // Debug settings
  static const bool enableRouteDebugLogs = true;
  static const bool enableApiTesting = true;
}
