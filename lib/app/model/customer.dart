class Customer {
  final String nombre;
  final String apellido;
  final String email;
  final String telefono;
  final String fechaRegistro;
  final bool isAdmin;

  Customer(
      {required this.nombre,
      required this.apellido,
      required this.email,
      required this.telefono,
      required this.fechaRegistro,
      required this.isAdmin});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nombre': nombre,
      'apellido': apellido,
      'email': email,
      'telefono': telefono,
      'fechaRegistro': fechaRegistro,
      'isAdmin': isAdmin
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      nombre: map['nombre'] as String,
      apellido: map['apellido'] as String,
      email: map['email'] as String,
      telefono: map['telefono'] as String,
      fechaRegistro: map['fechaRegistro'] as String,
      isAdmin: map['isAdmin'] as bool,
    );
  }
}
