import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/src/screens/newProduct/index.dart';
import 'package:mobile/src/screens/productDetail/index.dart';
import 'package:mobile/src/services/index.dart';

void main() {
  runApp(ListProduct());
}

class ListProduct extends StatefulWidget {
  @override
  _ListProduct createState() => _ListProduct();
}

class _ListProduct extends State<ListProduct> {
  List<Map<String, dynamic>> products = new List();
  bool loading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.getData();
  }

  void getData() async {
    setState(() {
      loading = true;
    });

    http.Response response = await http.get(Api.api + 'products');
    var data = json.decode(response.body);

    Map<String, dynamic> structProduct = new Map();
    List<Map<String, dynamic>> productsAPI = new List();

    for (var item in data['data']) {
      structProduct = item;
      productsAPI.add(structProduct);
    }
    setState(() {
      loading = false;
      products = productsAPI;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Produtos'),
          backgroundColor: Color(0XFF0C2338),
          actions: [
            IconButton(
              icon: Icon(Icons.add, color: Colors.white),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => NewProduct()))
                    .then((response) {
                  this.getData();
                });
              },
            )
          ],
        ),
        body: loading == true
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: this.products.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 4.0,
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                          builder: (context) => ProductDetail(
                            name: products[index]['name'],
                            imageUrl: products[index]['image_url'],
                            price: double.parse(
                                products[index]['price'].toStringAsFixed(2)),
                            id: products[index]['id'],
                          ),
                        ))
                            .then((response) {
                          this.getData();
                        });
                      },
                      leading: Container(
                          height: 40,
                          child: Image.network(products[index]['image_url'])),
                      title: Text(products[index]['name']),
                      subtitle: Text(products[index]['description']),
                      trailing: Text(
                        'R\$' +
                            ' ' +
                            products[index]['price']
                                .toStringAsFixed(2)
                                .toString()
                                .replaceAll('.', ','),
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.w800),
                      ),
                    ),
                  );
                },
              ));
  }
}
