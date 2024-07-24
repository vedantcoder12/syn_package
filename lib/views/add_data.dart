import 'package:flutter/material.dart';
import 'package:sync_package/constants/custom_colors.dart';
import 'package:sync_package/database/db.dart';
import 'package:sync_package/models/employee.dart';
import 'package:sync_package/services/data_sync_manager.dart';
import 'package:sync_package/widgets/forms.dart';

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  TextEditingController name = TextEditingController();
  TextEditingController designation = TextEditingController();
  final dbHelper = DatabaseHelper.instance;
  late final DataSyncManager _dataSyncManager;

  @override
  void initState() {
    super.initState();
    _dataSyncManager = DataSyncManager();
    _performInitialSync();
  }

  Future<void> _performInitialSync() async {
    if (mounted) {
      await _dataSyncManager.sync();
    }
  }



  @override
  void dispose() {
    name.dispose();
    designation.dispose();
    _dataSyncManager.dispose();
    super.dispose();
  }

  void _addData() async {
    if (name.text.isEmpty || designation.text.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill in all fields'),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return;
    }

    final employee = Employee(name: name.text, designation: designation.text);
    try {
      // Add employee to local database
      await dbHelper.create(employee);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Employee added successfully to local database.'),
            backgroundColor: Colors.green,
          ),
        );
      }

      // Synchronize data with the API
      final isSyncSuccessful = await _dataSyncManager.sync();

      if (mounted) {
        if (isSyncSuccessful) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Data synchronized with API successfully.'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Data is saved locally and will be synced with API once internet is available.'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      print('Error adding employee: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error adding employee: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.appBarColor,
        foregroundColor: CustomColors.appBarFontColor,
      ),
      body: CustomForms.addForm(
        name: name,
        designation: designation,
        onPressed: _addData,
      ),
    );
  }
}
