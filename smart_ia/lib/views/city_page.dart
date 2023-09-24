import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'item_list_page.dart';

class CitySelectionPage extends StatefulWidget {
  @override
  _CitySelectionPageState createState() => _CitySelectionPageState();
}

class _CitySelectionPageState extends State<CitySelectionPage> {
  final List<String> cities = [
    'Santa Rita do Sapucaí',
    'Pouso Alegre',
    'Itajuba',
    'Outras'
  ];
  List<String> filteredCities = [];
  bool isSearching = false;

  TextEditingController _searchController = TextEditingController();
  GoogleMapController? _mapController; // Controlador para o mapa
  @override
  void initState() {
    super.initState();
    filteredCities = cities;
    _searchController.addListener(_filterCities);
  }

  void _filterCities() {
    setState(() {
      final query = _searchController.text.toLowerCase();
      filteredCities =
          cities.where((city) => city.toLowerCase().contains(query)).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleção de Cidade'),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          // SizedBox(height: 100.0),
          Container(
            child: Text(
              'Onde você está agora: ',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 50.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: TextField(
                onTap: () {
                  setState(() {
                    isSearching = true;
                  });
                },
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Pesquisar Cidade',
                  prefixIcon: Icon(Icons.search),
                  labelStyle: TextStyle(color: Colors.purple),
                  hintStyle: TextStyle(color: Colors.purple),
                ),
                style: TextStyle(color: Colors.purple),
              ),
            ),
          ),

          if (isSearching)
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  itemCount: filteredCities.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        filteredCities[index],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShoppingListPage(),
                          ),
                        );
                        // Aqui você pode adicionar a lógica para lidar com a seleção da cidade.
                        // Por exemplo, você pode navegar para a próxima página com a cidade selecionada.
                      },
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
