class PersonModel {
  final String id;
  final String name;
  final String lastName;
  final int age;

  PersonModel(
      {required this.id,
      required this.name,
      required this.lastName,
      required this.age});

  PersonModel copyWith({String? id, String? name, String? lastName, int? age}) {
    return PersonModel(
        id: id ?? this.id,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        age: age ?? this.age);
  }

  factory PersonModel.fromJson(dynamic json) => PersonModel(
      id: json['id'],
      name: json['name'],
      lastName: json['lastName'],
      age: json['age']);

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['lastName'] = lastName;
    map['age'] = age;
    return map;
  }
}
