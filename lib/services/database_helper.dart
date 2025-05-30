import 'package:flutter_application_laboratorio/Entity/Actividad.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {
  
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  static Database ? _database;

  factory DatabaseHelper() {
    return _instance;
    }

  DatabaseHelper._internal();
  Future<void> initializeDatabase() async {
    await database;
    }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'activity_database.db');

    return await openDatabase(
      path, 
      version: 1, 
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Actividad (
      ID INTEGER PRIMARY KEY,
      Nombre TEXT NOT NULL,
      Fecha TEXT NOT NULL
      )'''
    );
  }

  Future<void> insertActivity(Actividad activity) async {
    final db = await database;
    await db.insert(
      'Actividad',
      activity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  
  Future<List<Actividad>> Actividades() async {

    final db = await database;

    final List<Map<String, Object?>> ListaActividades = await db.query('Actividad');
    return [
     for (final {'ID': id as int, 'Nombre': nombre as String, 'Fecha': fecha as String}
          in ListaActividades)
        Actividad(id: id, nombre: nombre, fecha: DateTime.parse(fecha)),
    ];
  }

  Future<void> updateActividad(Actividad actividad) async {

    final db = await database;

    await db.update(
      'Actividad',
      actividad.toMap(),
      where: 'id = ?',
      whereArgs: [actividad.id],
    );
  }

  Future<void> deleteActividad(int id) async {

  final db = await database;
  await db.delete(
    'Actividad',
    where: 'id = ?',
    whereArgs: [id],
  );
}
}
