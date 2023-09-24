import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:smart_ia/views/super_market/super_market_page.dart';

import 'filtro.dart';
import 'loading_page.dart';

class ShoppingItem {
  final String name;
  bool isChecked;

  ShoppingItem({
    required this.name,
    this.isChecked = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isChecked': isChecked,
    };
  }

  factory ShoppingItem.fromJson(Map<String, dynamic> json) {
    return ShoppingItem(
      name: json['name'],
      isChecked: json['isChecked'],
    );
  }
}

class ShoppingListPage extends StatefulWidget {
  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  List<ShoppingItem> shoppingItems = [];
  TextEditingController _itemController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Carregue os itens iniciais do JSON (se existirem)
    loadShoppingItemsFromJson();
  }

  Future<void> loadShoppingItemsFromJson() async {
    try {
      // Carregue o JSON do arquivo de ativos
      final jsonString =
          await rootBundle.loadString('assets/lista_de_compras.json');
      final List<dynamic> jsonList = json.decode(jsonString);

      final loadedItems =
          jsonList.map((itemJson) => ShoppingItem.fromJson(itemJson)).toList();

      print('$jsonList');
      setState(() {
        shoppingItems = loadedItems;
      });
    } catch (e) {
      // Trate quaisquer erros que possam ocorrer durante o carregamento do JSON
      print('Erro ao carregar o JSON: $e');
    }
  }

  void saveShoppingItemsToJson() {
    // Atualize o JSON com a lista de itens atual
    final List<Map<String, dynamic>> jsonList =
        shoppingItems.map((item) => item.toJson()).toList();
    final jsonString = json.encode(jsonList);

    // Salve o JSON onde você preferir (por exemplo, em um arquivo)
    print(jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'),
      ),
      backgroundColor: Colors.black, // Define o fundo como preto
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: TextField(
                controller: _itemController,
                decoration: InputDecoration(
                  labelText: 'Adicionar Item',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      final newItemName = _itemController.text;
                      if (newItemName.isNotEmpty) {
                        final newItem = ShoppingItem(name: newItemName);
                        setState(() {
                          shoppingItems.add(newItem);
                          _itemController.clear();
                          saveShoppingItemsToJson(); // Salva a lista atualizada no JSON
                        });
                      }
                    },
                  ),
                ),
                style: TextStyle(
                    color: Colors.black), // Define a cor do texto como branco
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Itens da Lista de Compras:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Define a cor do texto como branco
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
                itemCount: shoppingItems.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = shoppingItems[index];
                  return ListTile(
                    title: Text(
                      item.name,
                      style: TextStyle(
                          color: Colors
                              .black), // Define a cor do texto como branco
                    ),
                    trailing: Checkbox(
                      value: item.isChecked,
                      onChanged: (value) {
                        setState(() {
                          item.isChecked = value ?? false;
                          saveShoppingItemsToJson(); // Salva a lista atualizada no JSON
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilterSelectionPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0), // Borda mais arredondada
              ),
            ),
            child: Text('Seguir',
                style: TextStyle(
                    color: Colors.white)), // Define a cor do texto como branco
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _itemController.dispose();
    super.dispose();
  }
}
