class Collaborator {
  final String nombre;
  final String ubicacion;
  final String contacto;
  final String urlImage;

  Collaborator({
    required this.nombre,
    required this.ubicacion,
    required this.contacto,
    required this.urlImage
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nombre': nombre,
      'ubicacion': ubicacion,
      'contacto': contacto,
      'url_image': urlImage
    };
  }

  factory Collaborator.fromMap(Map<String, dynamic> map) {
    return Collaborator(
      nombre: map['nombre'] as String,
      ubicacion: map['ubicacion'] as String,
      contacto: map['contacto'] as String,
      urlImage: map['url_image'] as String
    );
  }
}
