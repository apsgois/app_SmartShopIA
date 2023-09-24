import 'package:flutter/material.dart';
import 'package:smart_ia/views/super_market/super_market_page.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    // Crie um temporizador para aguardar 10 segundos
    Future.delayed(Duration(seconds: 3), () {
      // Navegue para a próxima tela após 10 segundos
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SuperMarketPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aguarde...'),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(), // Barra de progresso
                SizedBox(height: 16.0),
                Text(
                  'Com base nas suas escolhas essas são as melhores opções',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados'),
      ),
      body: Center(
        child: Text(
          'Com base nas suas escolhas essas são as melhores opções',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoadingPage(),
  ));
}
