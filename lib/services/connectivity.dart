import 'package:connectivity_plus/connectivity_plus.dart';

class Connection {
  // Method to check internet connectivity
  static Future<bool> checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    // Check for connectivity
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      return true; // Connected to mobile data or Wi-Fi
    }
    
    return false; // Not connected
  }

  
  static Future<String> getConnectivityStatus() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    
    if (connectivityResult == ConnectivityResult.mobile) {
      return 'Connected to Mobile Data';
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return 'Connected to Wi-Fi';
    } else {
      return 'No Internet Connection';
    }
  }

  // Method to listen to connectivity changes
  static Stream<ConnectivityResult> get connectivityStream {
    return Connectivity().onConnectivityChanged;
  }
}
