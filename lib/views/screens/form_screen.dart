import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:students/bloc/person_bloc.dart';
import 'package:students/models/person_model.dart';
import 'package:students/views/widgets/card_background_with_text_dot.dart';
import 'package:students/views/widgets/custom_text_form_field.dart';

class FormScreen extends StatefulWidget {
  final PersonModel? data;

  const FormScreen({Key? key, this.data}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.data != null) {
      _setUpDefaultData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonBloc, PersonState>(
      listener: (context, state) {
        if (state.isLoading) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Row(
                    children: [
                      CircularProgressIndicator(),
                      Container(
                          margin: EdgeInsets.only(left: 7),
                          child: Text("Loading...")),
                    ],
                  ),
                );
              });
        } else if (state.isError) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text('${state.message}'),
              ).build(context);
            },
          );
        } else {
          Navigator.pop(context);
          if (state.message != null && state.message!.contains('success')) {
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Form Student'),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (widget.data == null) ...[
                  CardBackgroundWithTextDot(
                      title: 'ID',
                      dotColor: Colors.red,
                      widget: TextFieldWithoutBorder(
                        initialValue: _idController.text,
                        onChanged: (value) {
                          _idController.text = value;
                        },
                      )),
                  SizedBox(height: 16),
                ],
                Row(
                  children: [
                    Expanded(
                      child: CardBackgroundWithTextDot(
                          title: 'First Name',
                          dotColor: Colors.red,
                          widget: TextFieldWithoutBorder(
                            initialValue: _nameController.text,
                            onChanged: (value) {
                              _nameController.text = value;
                            },
                          )),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: CardBackgroundWithTextDot(
                          title: 'Last Name',
                          dotColor: Colors.red,
                          widget: TextFieldWithoutBorder(
                            initialValue: _lastNameController.text,
                            onChanged: (value) {
                              _lastNameController.text = value;
                            },
                          )),
                    )
                  ],
                ),
                SizedBox(height: 16),
                CardBackgroundWithTextDot(
                    title: 'Age',
                    dotColor: Colors.red,
                    widget: TextFieldWithoutBorder(
                      initialValue: _ageController.text,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _ageController.text = value;
                      },
                    )),
                SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        if (widget.data != null) {
                          BlocProvider.of<PersonBloc>(context).add(EditPerson(
                              id: _idController.text,
                              name: _nameController.text,
                              lastName: _lastNameController.text,
                              age: int.tryParse(_ageController.text) ?? 0));
                        } else {
                          BlocProvider.of<PersonBloc>(context).add(AddPerson(
                              id: _idController.text,
                              name: _nameController.text,
                              lastName: _lastNameController.text,
                              age: int.tryParse(_ageController.text) ?? 0));
                        }
                      },
                      child: const Text('Submit')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setUpDefaultData() {
    _idController.text = widget.data!.id;
    _nameController.text = widget.data!.name;
    _lastNameController.text = widget.data!.lastName;
    _ageController.text = widget.data!.age.toString();
  }
}
