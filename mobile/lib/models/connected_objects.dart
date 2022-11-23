class ConnectedObjects {
  const ConnectedObjects({
    required this.name,
    required this.uid,
    required this.type,
  });
  final String name;
  final String uid;
  final String type;

  Map<String, dynamic> toJson() => <String, dynamic>{
    "name": name,
    "uid": uid,
    "type": type,
  };
}
