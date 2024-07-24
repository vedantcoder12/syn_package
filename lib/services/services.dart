import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sync_package/models/employee.dart';

class Services {
  static String baseApiUrl = 'https://667bd8253c30891b865a399c.mockapi.io';

  /// CREATE: Add a new employee
  static Future<Employee> createEmployee(Employee employee) async {
    final response = await http.post(
      Uri.parse('$baseApiUrl/employees'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(employee.toJson()),
    );

    if (response.statusCode == 201) {
      return Employee.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create employee: ${response.reasonPhrase}');
    }
  }

  /// READ: Get all employees
  static Future<List<Employee>> getEmployees() async {
    final response = await http.get(Uri.parse('$baseApiUrl/employees'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Employee.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load employees: ${response.reasonPhrase}');
    }
  }

  Future<http.Response> addEmployee(String name, String desc) async {
    try {
      final response = await http.post(
        Uri.parse('$baseApiUrl/employee'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"name": name, "designation": desc}),
      );
      if (response.statusCode == 201) {
        print('Data added successfully');
      } else {
        print('Failed to add data. Status code: ${response.statusCode}');
      }
      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  /// READ: Get a single employee by ID
  static Future<Employee> getEmployee(int id) async {
    final response = await http.get(Uri.parse('$baseApiUrl/employees/$id'));

    if (response.statusCode == 200) {
      return Employee.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load employee: ${response.reasonPhrase}');
    }
  }

  /// UPDATE: Update an employee's information
  static Future<Employee> updateEmployee(Employee employee) async {
    final response = await http.put(
      Uri.parse('$baseApiUrl/employees/${employee.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(employee.toJson()),
    );

    if (response.statusCode == 200) {
      return Employee.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update employee: ${response.reasonPhrase}');
    }
  }

  /// DELETE: Delete an employee
  static Future<void> deleteEmployee(int id) async {
    final response = await http.delete(Uri.parse('$baseApiUrl/employees/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete employee: ${response.reasonPhrase}');
    }
  }
}
