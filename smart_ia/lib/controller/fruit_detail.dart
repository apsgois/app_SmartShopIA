import 'package:flutter/material.dart';
import 'package:smart_ia/model/FruitDataModel.dart';

class FruitDetail extends StatelessWidget {
  final FruitDataModel fruitDataModel;
  const FruitDetail({Key? key, required this.fruitDataModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(fruitDataModel.nome),
        ),
        body: Column(
          children: [
            Image.network(fruitDataModel.imageUrl),
            Text(fruitDataModel.descricao),
          ],
        ));
  }
}
