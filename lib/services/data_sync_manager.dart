import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sync_package/database/db.dart';
import 'package:sync_package/services/services.dart';

class DataSyncManager {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final Services _services = Services();
  Timer? _syncTimer;

  DataSyncManager();

  Future<bool> sync() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        print(
            'Connected to the internet. Attempting to sync local data to API.');
        await _syncLocalDataToApi();
        return true;
      } else {
        print('No internet connection. Starting periodic sync checks.');
        _startPeriodicSync();
        return false;
      }
    } catch (e) {
      print('Error during sync operation: $e');
      return false;
    }
  }

  Future<void> _syncLocalDataToApi() async {
    final employees = await _dbHelper.readAllEmployees();
    for (var employee in employees) {
      try {
        await _services.addEmployee(employee.name, employee.designation);
        await _dbHelper.delete(employee.id!);
      } catch (e) {
        print('Failed to sync employee ${employee.name}: $e');
      }
    }
  }

  void _startPeriodicSync() {
    _syncTimer?.cancel();
    _syncTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        print('Internet restored. Attempting to sync data.');
        bool success = await sync();
        if (success) {
          _syncTimer?.cancel();
        }
      }
    });
  }

  void dispose() {
    _syncTimer?.cancel();
  }
}
