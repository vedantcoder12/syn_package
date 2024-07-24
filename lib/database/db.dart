import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:sync_package/models/employee.dart';



class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('employees.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE employees (
      id $idType,
      name $textType,
      designation $textType
    )
    ''');
  }

  Future<Employee> create(Employee employee) async {
    final db = await instance.database;
    final id = await db.insert('employees', employee.toMap());
    return employee.id != null ? employee : Employee(
      id: id,
      name: employee.name,
      designation: employee.designation,
    );
  }

  Future<Employee> readEmployee(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'employees',
      columns: ['id', 'name', 'designation'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Employee.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Employee>> readAllEmployees() async {
    final db = await instance.database;
    final result = await db.query('employees');
    return result.map((json) => Employee.fromMap(json)).toList();
  }

  Future<int> update(Employee employee) async {
    final db = await instance.database;
    return db.update(
      'employees',
      employee.toMap(),
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'employees',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}