import 'package:flutter/material.dart';
import 'package:sync_package/widgets/view_card.dart';
import 'package:sync_package/database/db.dart';
import 'package:sync_package/models/employee.dart';

class ViewData extends StatefulWidget {
  final Function()? onDataChanged;
  const ViewData({Key? key, this.onDataChanged}) : super(key: key);

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  List<Employee> employees = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEmployees();
  }

  Future<void> _loadEmployees() async {
    print("Loading employees..."); // Debug print
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });

    try {
      final loadedEmployees = await dbHelper.readAllEmployees();
      print('Loaded ${loadedEmployees.length} employees'); // Debug print

      if (!mounted) return;
      setState(() {
        employees = loadedEmployees;
        isLoading = false;
      });
      print("State updated with ${employees.length} employees"); // Debug print
      widget.onDataChanged?.call();
    } catch (e) {
      print('Error loading employees: $e');
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _deleteEmployee(Employee employee) async {
    try {
      await dbHelper.delete(employee.id!);
      setState(() {
        employees.removeWhere((e) => e.id == employee.id);
      });
      widget.onDataChanged?.call();
    } catch (e) {
      print('Error deleting employee: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete employee')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print(
        "Building ViewData with ${employees.length} employees"); // Debug print

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (employees.isEmpty) {
      return const Center(child: Text('No employees found'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: employees.length,
      itemBuilder: (context, index) {
        final employee = employees[index];
        return CustomCards.viewCard(
          name: employee.name,
          desg: employee.designation,
          onDelete: () => _deleteEmployee(employee),
        );
      },
    );
  }
}
