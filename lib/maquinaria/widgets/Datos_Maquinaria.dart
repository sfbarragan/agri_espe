class Datos_Maquinaria {
  late int id;
  late String nombre;
  late String tipo;
  late String marca;
  late String estado;
  late int id_empleado;

  
  Datos_Maquinaria(
    this.id,
    this.nombre,
    this.tipo,
    this.marca,
    this.estado,
    this.id_empleado
  );
  
  Datos_Maquinaria.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    tipo = json['tipo'];
    marca = json['marca'];
    estado = json['estado'];
    id_empleado = json['id_empleado']==null?json['id_empleado']=0:json['id_empleado'];
  }
}
