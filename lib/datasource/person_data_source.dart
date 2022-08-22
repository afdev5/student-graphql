import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:students/datasource/query.dart';
import 'package:students/models/person_model.dart';

class PersonDataSource {
  final _client = GraphQLClient(
      link: HttpLink(
        'https://examplegraphql.herokuapp.com/graphql',
      ),
      cache: GraphQLCache());

  Future<List<PersonModel>> getData() async {
    final _persons = <PersonModel>[];
    final _options = QueryOptions(document: gql(QuerySchema.getData));
    final _result = await _client.query(
      _options
    );
    if(_result.data?.values.last.length > 0) {
      for(var i in _result.data?.values.last) {
        _persons.add(PersonModel.fromJson(i));
      }
    }
    // print(_result.data?.values.last);
    return _persons;
  }

  Future<bool> addData(String id, String name, String lastName, int age) async {
    final _options = MutationOptions(document: gql(QuerySchema.addData), variables: {
      'id': id,
      'name': name,
      'lastName': lastName,
      'age': age
    });
    final _result = await _client.mutate(_options);
    print(_result.hasException);
    return _result.hasException;
  }

  Future<bool> editData(String id, String name, String lastName, int age) async {
    final _options = MutationOptions(document: gql(QuerySchema.editData), variables: {
      'id': id,
      'name': name,
      'lastName': lastName,
      'age': age
    });
    final _result = await _client.mutate(_options);
    // print(_result.hasException);
    return _result.hasException;
  }

  Future<bool> deleteData(String id,) async {
    final _options = MutationOptions(document: gql(QuerySchema.deleteData), variables: {
      'id': id,
    });
    final _result = await _client.mutate(_options);
    // print(_result.hasException);
    return _result.hasException;
  }
}
