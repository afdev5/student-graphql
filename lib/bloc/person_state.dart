part of 'person_bloc.dart';

class PersonState {
  final bool isLoading;
  final bool isError;
  final String? message;
  final List<PersonModel> datas;

  PersonState(
      {this.isLoading = false,
      this.message,
      required this.datas,
      this.isError = false});

  PersonState copyWith(
      {bool? isLoading,
      String? message,
      List<PersonModel>? datas,
      bool? isError}) {
    return PersonState(
        datas: datas ?? this.datas,
        message: message ?? this.message,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError);
  }
}
