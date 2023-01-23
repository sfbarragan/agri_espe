class Datos_Parcelas {
  late int id;
  late String nombre;
  late String ubicacion;
  late String tamanio;
  late String tipo_suelo;

  Datos_Parcelas(
    this.id,
    this.nombre,
    this.ubicacion,
    this.tamanio,
    this.tipo_suelo,
  );
  
  Datos_Parcelas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    ubicacion = json['ubicacion'];
    tamanio = json['tamaño'];
    tipo_suelo = json['tipo_suelo'];
  }
}
