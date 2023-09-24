import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/product.dart';
import '../super_market2_page.dart';

class SuperMarketPage extends StatefulWidget {
  const SuperMarketPage({super.key});

  @override
  State<SuperMarketPage> createState() => _SuperMarketPageState();
}

class _SuperMarketPageState extends State<SuperMarketPage> {
  final String cityName =
      'Santa Rita do Sapucaí'; // Substitua pelo nome da cidade
  final String supermarketName =
      'Supermercado A'; // Substitua pelo nome do supermercado
  final String proximidade = '2km';
  List<Product> products = []; // Lista de produtos
  bool _sortByPrice = false; // Indica se a lista deve ser ordenada por preço
  bool _sortByName = false; // Indica se a lista deve ser ordenada por nome
  String selectedSortOption = 'Nenhum'; // Opção de ordenação selecionada

  List<String> sortOptions = ['Nenhum', 'Por Preço', 'Por Produto'];

  Future<void> loadProductsFromJson() async {
    final jsonString = await rootBundle.loadString('assets/srs_product.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    setState(() {
      products = jsonList
          .map((productJson) => Product(
                name: productJson['name'],
                description: productJson['description'],
                image: productJson['image'],
                price: productJson['price'],
              ))
          .toList();
    });
  }

  void _sortProducts() {
    // Ordenar a lista de produtos com base nas opções selecionadas
    setState(() {
      if (_sortByPrice) {
        // Ordenar por preço (do menor para o maior)
        products.sort((a, b) => a.price.compareTo(b.price));
      } else if (_sortByName) {
        // Ordenar por nome
        products.sort((a, b) => a.name.compareTo(b.name));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadProductsFromJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Melhores Ofertas'),
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.purple, // Cor de fundo roxa
                borderRadius: BorderRadius.circular(
                    16.0), // Borda quadrada com raio de 8.0
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$supermarketName - $cityName - $proximidade',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0), // Espaçamento entre os textos
                    Text(
                      'Localização: Rua A, N 123, Centro',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    leading: Image.network(product.image),
                    title: Text(
                      product.name,
                      style: TextStyle(
                        color:
                            Colors.black, // Defina a cor do texto como branca
                      ),
                    ),
                    subtitle: Text(
                      product.description,
                      style: TextStyle(
                        color:
                            Colors.black, // Defina a cor do texto como branca
                      ),
                    ),
                    trailing: Text(
                      'R\$ ${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            Colors.black, // Defina a cor do texto como branca
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.purple, // Cor de fundo roxa
                borderRadius: BorderRadius.circular(
                    8.0), // Borda quadrada com raio de 8.0
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Total: 350,00',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Aqui você pode aplicar os filtros selecionados (sortByPrice e sortByProximity)
                      // e navegar de volta para a página anterior com os resultados.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SuperMarket2Page(),
                        ),
                      );
                    },
                    child: Text('Outras opções ->'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
