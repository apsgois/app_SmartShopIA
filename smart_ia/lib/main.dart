import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:smart_ia/model/FruitDataModel.dart';
import 'package:smart_ia/controller/fruit_detail.dart';
import 'package:smart_ia/views/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // runApp(const MyApp());
  runApp(LoginApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart App IA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List searchResult = [];

  static List<String> fruitname = ['Maça', 'Banana', 'Laranja', 'Manga'];
  static List url = [
    'https://scfoods.fbitsstatic.net/img/p/maca-red-argentina-unidade-70942/257561.jpg?w=800&h=800&v=no-change&qs=ignore',
    'https://img.freepik.com/vetores-gratis/bando-de-banana-amarela-madura-de-vetor-isolado-no-fundo-branco_1284-45456.jpg?w=2000',
    'https://www.proativaalimentos.com.br/image/cache/catalog/img_prod/Laranja_lima_600x600[1]-1000x1000.jpg',
    'https://static.mundoeducacao.uol.com.br/mundoeducacao/2021/05/manga.jpg'
  ];

  final List<FruitDataModel> Fruitdata = List.generate(
      fruitname.length,
      (index) => FruitDataModel(
          nome: '${fruitname[index]}',
          imageUrl: '${url[index]}',
          descricao: '${fruitname[index]} é uma fruta muito boa.'));

  void searchFormFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('Store')
        .where('nome_array', arrayContains: query)
        .get();
    setState(() {
      searchResult = result.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            /*child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search Here',
              ),*/
            child: TypeAheadField(
              hideSuggestionsOnKeyboardHide: false,
              textFieldConfiguration: const TextFieldConfiguration(
                autofocus: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  hintText: 'Search the Super Name Here',
                ),
              ),
              suggestionsCallback: (pattern) async {
                final result = await FirebaseFirestore.instance
                    .collection('Store')
                    .where('nome_array', arrayContains: pattern)
                    .get();
                return result.docs.map((doc) => doc.data()).toList();
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  leading: Image.network(
                    suggestion['Produto']['imagemUrl'],
                    fit: BoxFit.cover,
                  ),
                  title: Text(suggestion['nome']),
                  //subtitle: Text(suggestion['string_id']),
                );
              },
              onSuggestionSelected: (suggestion) => Container(
                  /*ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(suggestion['nome']),
                  ),
                );*/
                  child: ListView.builder(
                      itemCount: Fruitdata.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(Fruitdata[index].nome),
                          leading: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.network(Fruitdata[index].imageUrl),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FruitDetail(
                                  fruitDataModel: Fruitdata[index],
                                ),
                              ),
                            );
                          },
                        );
                      })),
              noItemsFoundBuilder: (context) => Container(
                height: 100,
                child: Text(
                  'No Super Found',
                  style: TextStyle(fontSize: 24),
                ),
              ),

              // onChanged: (query) {
              // searchFormFirebase(query);
              // },
            ),
          ),
          /*Expanded(
            child: ListView.builder(
              itemCount: searchResult.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchResult[index]['nome']),
                  //subtitle: Text(searchResult[index]['string_id']),
                );
              },
            ),
          ),*/
          Expanded(
              child: ListView.builder(
                  itemCount: Fruitdata.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(Fruitdata[index].nome + 'Valor ' + '2.50'),
                      subtitle: Text(Fruitdata[index].descricao),
                      leading: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.network(Fruitdata[index].imageUrl),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FruitDetail(
                              fruitDataModel: Fruitdata[index],
                            ),
                          ),
                        );
                      },
                    );
                  }))
        ],
      ),
    );
  }
}
