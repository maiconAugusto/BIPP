import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  final String name;
  final String imageUrl;
  final double price;

  const ProductDetail({Key key, this.name, this.imageUrl, this.price})
      : super(key: key);
  @override
  _ProductDetail createState() => _ProductDetail();
}

class _ProductDetail extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produto'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            child: Image.network(widget.imageUrl),
            tag: 'image',
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                  style: TextStyle(color: Colors.green, fontSize: 14),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.amberAccent[600],
                  ),
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          )
        ],
      )),
    );
  }
}
