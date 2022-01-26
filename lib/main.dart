import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphqltuts/graphql_operations/queries/readData.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink('https://hasura.io/learn/graphql');

    Link linkk;

    final AuthLink authLinkk = AuthLink(
        getToken: () =>
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJlZGluam9leUBnbWFpbC5jb20iLCJuYW1lIjoiZWRpbmpvZXkiLCJpYXQiOjE2NDIxMDcyMTkuMzA2LCJpc3MiOiJodHRwczovL2hhc3VyYS5pby9sZWFybi8iLCJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsidXNlciJdLCJ4LWhhc3VyYS11c2VyLWlkIjoiZWRpbmpvZXlAZ21haWwuY29tIiwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoidXNlciIsIngtaGFzdXJhLXJvbGUiOiJ1c2VyIn0sImV4cCI6MTY0MjE5MzYxOX0.SvSwshjvrEgjgd9iV-4UZM8YIUdzBj0l78IwiGrIEkE');

    linkk = authLinkk.concat(httpLink);

    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: linkk,
        cache: GraphQLCache(store: HiveStore()),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GraphQL CLIENT'),
      ),
      body: Query(
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return const CircularProgressIndicator();
          }

          if (result.data == null) {
            return const Text('No Data Found !');
          }

          print('result.isOptimistic -->> ${result.isOptimistic}');

          print('result.isConcrete --->> ${result.isConcrete}');

          debugPrint(result.data.toString());

          return const Text('Data Available');
        },
        options: QueryOptions(
            document: gql(readData),
            variables: <String, dynamic>{'numberOfItems': 4}),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
