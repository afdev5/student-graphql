import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:students/bloc/person_bloc.dart';
import 'package:students/models/person_model.dart';
import 'package:students/views/screens/form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PersonBloc>(context).add(GetPerson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student GraphQL'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _navigateToFormScreen();
        },
      ),
      body: BlocBuilder<PersonBloc, PersonState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.datas.isEmpty) {
            return Center(child: Text(state.message ?? 'Tidak ada data'));
          } else {
            return ListView.builder(
                itemCount: state.datas.length,
                itemBuilder: (context, index) {
                  final _data = state.datas[index];
                  return Card(
                    child: ListTile(
                      title: Text('${_data.name} ${_data.lastName}'),
                      subtitle: Text('Umur : ${_data.age}'),
                      trailing: IconButton(
                        color: Colors.red,
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          BlocProvider.of<PersonBloc>(context)
                              .add(DeletePerson(id: _data.id));
                        },
                      ),
                      onTap: () {
                        _navigateToFormScreen(data: _data);
                      },
                    ),
                  );
                });
          }
        },
      ),
    );
  }

  void _navigateToFormScreen({PersonModel? data}) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormScreen(data: data)));
  }
}
