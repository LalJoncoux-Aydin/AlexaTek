class Module {
  const Module({
    required this.name,
    required this.id,
    //required this.type,
  });
  final String name;
  final int id;
  //final String type;

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      name: json['name'],
      id: json['id'],
    );
  }
}
