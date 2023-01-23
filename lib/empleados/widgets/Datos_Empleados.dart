class Datos_Empleados {
  late int id;
  late String nombre;
  late int edad;
  late String cedula;
  late double sueldo;
  late int id_parcela;

  
  Datos_Empleados(
    this.id,
    this.nombre,
    this.edad,
    this.cedula,
    this.sueldo,
    this.id_parcela
  );
  
  Datos_Empleados.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    edad = json['edad'];
    cedula = json['cedula'];
    sueldo = json['sueldo'];
    id_parcela = json['id_parcela']==null?json['id_parcela']=0:json['id_parcela'];
  }
}
