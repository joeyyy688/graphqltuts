// ignore_for_file: file_names

const String readGlobeData = r'''
query {
	country(code: "GH"){
  	name
    code
    phone
  	continent{
      name
      code
    }
    currency
    languages{
      name
      native
    }
	}
}
                  ''';
