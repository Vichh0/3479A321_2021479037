class Actividad{

  final String nombre;
  final int id;
  final DateTime fecha;

  Actividad({required this.nombre,required this.id,required this.fecha});

  Map<String, dynamic> toMap(){
    return{
      'ID': id, 'Nombre': nombre, 'Fecha': fecha.toIso8601String()
    };
  }

  factory Actividad.fromMap( Map<String, dynamic> mapa){
    return Actividad(nombre: mapa['Nombre'], id: mapa['ID'], fecha: DateTime.parse(mapa['Fecha']));
  }
}