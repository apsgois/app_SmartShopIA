import 'package:flutter/material.dart';
import 'package:smart_ia/views/super_market/super_market_page.dart';

import 'loading_page.dart';

class FilterSelectionPage extends StatefulWidget {
  @override
  _FilterSelectionPageState createState() => _FilterSelectionPageState();
}

class _FilterSelectionPageState extends State<FilterSelectionPage> {
  bool sortByPrice = false;
  bool sortByProximity = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtros'),
      ),
      backgroundColor: Colors.black,
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
              child: ListTile(
                title: Text(
                  'Ordenar por Preço',
                  style: TextStyle(
                      color: Colors.black), // Define a cor do texto como branco
                ),
                trailing: Checkbox(
                  value: sortByPrice,
                  onChanged: (value) {
                    setState(() {
                      sortByPrice = value ?? false;
                    });
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: ListTile(
                title: Text(
                  'Ordenar por Proximidade',
                  style: TextStyle(
                      color: Colors.black), // Define a cor do texto como branco
                ),
                trailing: Checkbox(
                  value: sortByProximity,
                  onChanged: (value) {
                    setState(() {
                      sortByProximity = value ?? false;
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Aqui você pode aplicar os filtros selecionados (sortByPrice e sortByProximity)
              // e navegar de volta para a página anterior com os resultados.
              Navigator.pop(context, {
                'sortByPrice': sortByPrice,
                'sortByProximity': sortByProximity,
              });
              print('Context $context');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoadingPage(),
                ),
              );
            },
            child: Text('Aplicar Filtros'),
          ),
        ],
      ),
    );
  }
}
