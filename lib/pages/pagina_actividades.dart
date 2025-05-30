import 'package:flutter/material.dart';
import 'package:flutter_application_laboratorio/Entity/Actividad.dart';
import 'package:flutter_application_laboratorio/services/database_helper.dart';


class PaginaActividades extends StatefulWidget {
  const PaginaActividades({Key? key}) : super(key: key);

  @override
  _PaginaActividadesState createState() => _PaginaActividadesState();
}

class _PaginaActividadesState extends State<PaginaActividades> {
  final List<Actividad> actividades = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }
  @override
  Widget build(BuildContext context) {
    _dbHelper.insertActivity(Actividad(nombre: 'Actividad 1', id: actividades.length + 1, fecha: DateTime.now()));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Actividades'),
      ),
      body: 
      ListView.builder(
        itemCount: actividades.length,
        itemBuilder: (context, index) {
          final actividad = actividades[index];
          return ListTile(
            title: Text(actividad.nombre),
            subtitle: Text(actividad.fecha.toIso8601String()),
            trailing: Text('ID: ${actividad.id}'),
            onTap: () {
              // Aquí puedes agregar la lógica para manejar el tap en la actividad
              print('Actividad seleccionada: ${actividad.id}');
            },
          );
        },
      ),
      persistentFooterButtons: [
        FloatingActionButton(
          child: const Icon(Icons.edit),
          onPressed: () async {
            final idController = TextEditingController();
            final nameController = TextEditingController();
            final result = await showDialog<Map<String, String>>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Editar Actividad'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: idController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'ID de la actividad'),
                    ),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Nuevo nombre'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, {
                        'id': idController.text,
                        'nombre': nameController.text,
                      });
                    },
                    child: const Text('Guardar'),
                  ),
                ],
              ),
            );
            if (result != null && result['id'] != null && result['nombre'] != null) {
              final id = int.tryParse(result['id']!);
              final nuevoNombre = result['nombre']!;
              if (id != null && nuevoNombre.isNotEmpty) {
                final index = actividades.indexWhere((a) => a.id == id);
                if (index != -1) {
                  final actividadEditada = Actividad(
                    id: actividades[index].id,
                    nombre: nuevoNombre,
                    fecha: actividades[index].fecha,
                  );
                  await _dbHelper.updateActividad(actividadEditada);
                  _loadActivities();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('ID no encontrado')),
                  );
                }
              }
            }
          },
          tooltip: 'Editar actividad',
        ),
        FloatingActionButton(
          child: const Icon(Icons.delete),
          onPressed: () async {
            final idController = TextEditingController();
            final result = await showDialog<String>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Eliminar Actividad'),
                content: TextField(
                  controller: idController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'ID de la actividad'),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, idController.text);
                    },
                    child: const Text('Eliminar'),
                  ),
                ],
              ),
            );
            if (result != null && result.isNotEmpty) {
              final id = int.tryParse(result);
              if (id != null) {
                final index = actividades.indexWhere((a) => a.id == id);
                if (index != -1) {
                  await _dbHelper.deleteActividad(id);
                  _loadActivities();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Actividad eliminada')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('ID no encontrado')),
                  );
                }
              }
            }
          },
          tooltip: 'Eliminar actividad',
        ),
      ],
    );
  }
  
  void _loadActivities() {
    _dbHelper.Actividades().then((value) {
      setState(() {
        actividades.clear();
        actividades.addAll(value);
      });
    }).catchError((error) {
      print('Error al cargar actividades: $error');
    });
  }
}
