import 'package:flutter/material.dart';
import 'package:mobile/src/screens/productDetail/index.dart';

void main() {
  runApp(ListProduct());
}

class ListProduct extends StatefulWidget {
  @override
  List createState() => List();
}

class List extends State<ListProduct> {
  var list = [
    "Melancia",
    "Carnsa",
    "Melancxia",
    "Carnaa",
    "Melarncia",
    "Carnga",
    "Melhancia",
    "Carjna",
    "Carjnaa"
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blueGrey[900]),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Produtos'),
            actions: [
              IconButton(
                icon: Icon(Icons.add, color: Colors.white),
                onPressed: () {},
              )
            ],
          ),
          body: ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 4.0,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductDetail(
                        name: 'Maicon',
                        imageUrl: 'https://picsum.photos/250?image=9',
                        price: 123.90,
                      ),
                    ));
                  },
                  leading: Container(
                    height: 50,
                    width: 50,
                    child: Hero(
                      child: Image.network('https://picsum.photos/250?image=9'),
                      tag: index.toString(),
                    ),
                  ),
                  title: Text(list[index]),
                  trailing: Text(
                    ' R\$ 120,00',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.w700),
                  ),
                ),
              );
            },
          )),
    );
  }
}
