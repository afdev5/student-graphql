class QuerySchema {
  static String getData = """{
      persons{
        id
        name
        lastName
        age
      }
    }
    """;

  static String addData =
          """mutation addperson(\$id: ID, \$name: String, \$lastName: String, \$age: Int) {
      addPerson(id: \$id, name: \$name, lastName: \$lastName, age: \$age) {
        id
        name
        lastName
        age
      }
    }""";

  static String editData =
  """mutation editperson(\$id: ID, \$name: String, \$lastName: String, \$age: Int) {
      editPerson(id: \$id, name: \$name, lastName: \$lastName, age: \$age) {
        id
        name
        lastName
        age
      }
    }""";

  static String deleteData = """mutation deleteperson(\$id: ID) {
      deletePerson(id: \$id) {
        id
      }
    }""";
}
