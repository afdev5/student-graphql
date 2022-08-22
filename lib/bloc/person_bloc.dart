import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:students/datasource/person_data_source.dart';
import 'package:students/models/person_model.dart';

part 'person_event.dart';

part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  PersonBloc() : super(PersonState(datas: [])) {
    on<PersonEvent>((event, emit) async {
      if (event is GetPerson) {
        try {
          emit(state.copyWith(isLoading: true));
          final _response = await PersonDataSource().getData();
          emit(state.copyWith(datas: _response, isLoading: false));
        } catch (e) {
          debugPrint('Error Get Person -> $e');
          emit(state.copyWith(
              datas: [],
              isLoading: false,
              message: 'Terjadi kesalahan, coba lagi'));
        }
      } else if (event is AddPerson) {
        emit(state.copyWith(isLoading: true));
        if (event.id.isEmpty ||
            event.name.isEmpty ||
            event.lastName.isEmpty ||
            event.age == 0) {
          emit(state.copyWith(message: 'all field cant be empty', isError: true, isLoading: false));
        } else {
          try {
            final _result = await PersonDataSource()
                .addData(event.id, event.name, event.lastName, event.age);
            if (_result) {
              emit(state.copyWith(
                  isError: true,
                  isLoading: false,
                  message: 'Gagal, coba lagi'));
            } else {
              final _response = await PersonDataSource().getData();
              emit(state.copyWith(datas: _response, isLoading: false, message: 'success', isError: false));
            }
          } catch (e) {
            debugPrint('Error Add Person -> $e');
            emit(state.copyWith(
                isError: true,
                isLoading: false,
                message: 'Terjadi kesalahan, coba lagi'));
          }
        }
      } else if (event is EditPerson) {
        emit(state.copyWith(isLoading: true));
        if (event.id.isEmpty ||
            event.name.isEmpty ||
            event.lastName.isEmpty ||
            event.age == 0) {
          emit(state.copyWith(message: 'all field cant be empty', isError: true, isLoading: false));
        } else {
          try {
            final _result = await PersonDataSource()
                .editData(event.id, event.name, event.lastName, event.age);
            if (_result) {
              emit(state.copyWith(
                  isError: true,
                  isLoading: false,
                  message: 'Gagal, coba lagi'));
            } else {
              final _response = await PersonDataSource().getData();
              emit(state.copyWith(datas: _response, isLoading: false, message: 'success', isError: false));
            }
          } catch (e) {
            debugPrint('Error Edit Person -> $e');
            emit(state.copyWith(
                isError: true,
                isLoading: false,
                message: 'Terjadi kesalahan, coba lagi'));
          }
        }
      } else if (event is DeletePerson) {
        try {
          emit(state.copyWith(isLoading: true));
          final _result = await PersonDataSource().deleteData(event.id);
          if (_result) {
            emit(state.copyWith(isLoading: false, message: 'Gagal, coba lagi'));
          } else {
            add(GetPerson());
          }
        } catch (e) {
          debugPrint('Error Delete Person -> $e');
          emit(state.copyWith(
              isLoading: false, message: 'Terjadi kesalahan, coba lagi'));
        }
      }
    });
  }
}
