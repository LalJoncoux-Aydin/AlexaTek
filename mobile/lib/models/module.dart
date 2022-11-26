class Module {
  Module({
    required this.name,
    required this.id,
    this.value,
  });
  final String name;
  final int id;
  String? value = "";

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      name: json['name'],
      id: json['id'],
    );
  }
}
