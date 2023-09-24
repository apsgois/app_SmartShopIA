import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';

class SuperModel {
  final String nome;
  final String imageUrl;

  const SuperModel({
    required this.nome,
    required this.imageUrl,
  });
}

class SuperData {
  static final faker = Faker();
  static final superList = List.generate(
    100,
    (index) => SuperModel(
        nome: faker.company.name(),
        imageUrl:
            'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.gettyimages.com.br%2Ffotos%2Fma%25C3%25A7%25C3%25A3&psig=AOvVaw1LcQhhzqic9LYuHSgnM9iy&ust=1693100456229000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCPC30-2Y-YADFQAAAAAdAAAAABAE'),
  );

  void getSuperList(String query) async {
    List searchResult = [];
    
     final result = await FirebaseFirestore.instance
        .collection('Store')
        .where('nome_array', arrayContains: query)
        .get();
    setState(() {
      searchResult = result.docs.map((doc) => doc.data()).toList();
    });
  }
  
  void setState(Null Function() param0) {}

  /*return superList.where((superModel) {
      final superModelLower = superModel.nome.toLowerCase();
      final queryLower = query.toLowerCase();

      return superModelLower.contains(queryLower);
    }).toList();*/
}
