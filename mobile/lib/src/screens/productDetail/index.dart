import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/src/services/index.dart';

class ProductDetail extends StatefulWidget {
  final String name;
  final String imageUrl;
  final double price;
  final String id;

  const ProductDetail({Key key, this.name, this.imageUrl, this.price, this.id})
      : super(key: key);
  @override
  _ProductDetail createState() => _ProductDetail();
}

class _ProductDetail extends State<ProductDetail> {
  bool loading = false;
  bool success = false;

  Future<bool> removeProduct(String id, BuildContext context) async {
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
        body: Column(
          children: [
            Container(
              height: 200,
              margin: EdgeInsets.fromLTRB(0, 40, 0, 20),
              child: Image.network(widget.imageUrl),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 40),
              child: Column(
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'R\$' +
                        ' ' +
                        widget.price
                            .toStringAsFixed(2)
                            .toString()
                            .replaceAll('.', ','),
                    style: TextStyle(color: Colors.green, fontSize: 18),
                  ),
                ],
              ),
            ),
            loading == true
                ? Container(
                    margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                    child: CircularProgressIndicator(),
                  )
                : Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                color: Colors.amberAccent[600],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Text("Deletar"),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          ],
        ));
  }
}
