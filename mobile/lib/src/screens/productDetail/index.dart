import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/src/screens/editionProduct/index.dart';
import 'package:mobile/src/services/index.dart';

class ProductDetail extends StatefulWidget {
  final String name;
  final String imageUrl;
  final double price;
  final String id;
  final int quantity;
  final String description;
  final String imagePath;

  const ProductDetail(
      {Key key,
      this.name,
      this.imageUrl,
      this.price,
      this.id,
      this.quantity,
      this.description,
      this.imagePath})
      : super(key: key);
  @override
  _ProductDetail createState() => _ProductDetail();
}

class _ProductDetail extends State<ProductDetail> {
  bool loading = false;
  bool success = false;

  Future<bool> removeProduct(String id, BuildContext context) async {
    bool success = false;
    setState(() {
      loading = true;
    });

    await http.delete(Api.api + 'product/' + id).then((response) {
      success = true;
      setState(() {
        loading = false;
      });
      Navigator.of(context).pop();
    }).catchError((error) {
      setState(() {
        loading = false;
      });
    });

    return success;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFF0C2338),
          title: Text('Produto'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Hero(
              child: Container(
                height: 200,
                margin: EdgeInsets.all(20),
                child: Image.network(widget.imageUrl),
              ),
              tag: 'image',
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
              child: Column(
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: 18),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                    child: Text(
                      widget.description,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Text(
                      'R\$' +
                          ' ' +
                          widget.price
                              .toStringAsFixed(2)
                              .toString()
                              .replaceAll('.', ','),
                      style: TextStyle(color: Colors.green, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            loading == true
                ? Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditionProduct(
                                    id: widget.id,
                                    imageUrl: widget.imageUrl,
                                    name: widget.name,
                                    price: widget.price,
                                    quantity: widget.quantity,
                                    description: widget.description,
                                    imagePath: widget.imagePath,
                                  ),
                                ));
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.amberAccent[600],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Text('Editar'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () async {
                                var value =
                                    await removeProduct(widget.id, context);
                                if (value == true) {
                                  return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                              'Produto deletado com sucesso!'),
                                          actions: [
                                            FlatButton(
                                              child: Text('Ok'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        );
                                      });
                                }
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Text('Remover'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          ],
        )));
  }
}
