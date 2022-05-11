import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'models/MyResponse.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink('https://countries.trevorblades.com/');
  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer ',
  );
  final Link link = authLink.concat(httpLink);
  ValueNotifier<GraphQLClient> client=ValueNotifier(GraphQLClient(link: link, cache: GraphQLCache(store: HiveStore())));
  var app=GraphQLProvider(client: client,child: const MyApp());



  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}




class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  String  countryInfoGQL ="""{
        country(code: "US") {
          name
          native
          capital
          emoji
          currency
          phone
          languages {
            code
            name
          }
        }
     }""";




  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Graph QL'),
      ),
      body: Query(
          options: QueryOptions(document: gql(countryInfoGQL), variables: {'':''}),

          builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }){

            if(result.isLoading){
              return const Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Center(child: CircularProgressIndicator()),
                ),
              );
            } else if(result.hasException){
              return Text(result.exception.toString());
            }else{
              var myData=result.data;
              // // // //
              // print('MY Data: $myData');
              // print('MY Data: ${myData!['country']!['name']}');
              // // //
                MyResponse myDataClass=MyResponse();
                myDataClass=MyResponse.fromJson(myData);
              //
              //   // print(myDataClass.country?.name??'');




              return Center(child: Text(myDataClass.country?.name??'Name not found'));
            }

          },

      ),
    );
  }
}
