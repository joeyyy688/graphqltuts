// ignore_for_file: file_names

const String readData = r'''
query UsersByPagination($numberOfItems: Int){
  users(limit: $numberOfItems){
    name
    todos {
      id
    }
  }
}

                  ''';
