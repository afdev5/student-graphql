part of 'person_bloc.dart';

@immutable
abstract class PersonEvent {}

class GetPerson extends PersonEvent {}

class AddPerson extends PersonEvent {
  final String id;
  final String name;
  final String lastName;
  final int age;

  AddPerson({required this.id, required this.name, required this.lastName, required this.age});
}

class EditPerson extends PersonEvent {
  final String id;
  final String name;
  final String lastName;
  final int age;

  EditPerson({required this.id, required this.name, required this.lastName, required this.age});
}

class DeletePerson extends PersonEvent {
  final String id;

  DeletePerson({required this.id});
}

