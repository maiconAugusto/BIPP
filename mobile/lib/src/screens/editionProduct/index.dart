import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/src/services/index.dart';
import 'package:dio/dio.dart';

class EditionProduct extends StatefulWidget {
  final String name;
  final String imageUrl;
  final double price;
  final String id;
  final int quantity;
  final String description;
  final String imagePath;

  const EditionProduct({
    Key key,
    this.name,
    this.imageUrl,
    this.price,
    this.id,
    this.quantity,
    this.description,
    this.imagePath,
  }) : super(key: key);
  @override
  _EditionProduct createState() => _EditionProduct();
}

class _EditionProduct extends State<EditionProduct> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ImagePicker picker = ImagePicker();
  File _image;
  bool loading = false;
  String imageFromApi;
  bool validationImg;

  void initState() {
    super.initState();
    name.text = widget.name;
    description.text = widget.description;
    price.text = widget.price.toStringAsFixed(2).toString();
    quantity.text = widget.quantity.toString();
    imageFromApi = widget.imagePath;
  }

  Future getImage(bool take) async {
    File selectedImage;
    if (take) {
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      selectedImage = File(pickedFile.path);
    } else {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      selectedImage = File(pickedFile.path);
    }

    setState(() {
      _image = selectedImage;
    });
  }

  void sendDataToApiUpdate(String id) async {
    try {
      setState(() {
        loading = true;
      });

      Dio dio = new Dio();
      String pathName;
      String path;

      if (_image != null) {
        pathName = _image.path.split('/').last;
        path = _image.path;
      }

      FormData dataToUpdateWithNewFile = FormData.fromMap({
        'name': name.text,
        'description': description.text,
        'quantity': int.parse(quantity.text),
        'price': double.parse(price.text),
        'image_path': imageFromApi,
        "file": path == null
            ? ''
            : await MultipartFile.fromFile(
                path,
                filename: pathName,
              ),
      });

      FormData dataToUpdate = FormData.fromMap({
        'name': name.text,
        'description': description.text,
        'quantity': int.parse(quantity.text),
        'price': double.parse(price.text),
      });
      await dio
          .put(Api.api + 'product/$id',
              data: _image == null ? dataToUpdate : dataToUpdateWithNewFile)
          .then((response) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Parabéns'),
              content: Text('Produto editado com sucesso!'),
              actions: [
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false);
                  },
                )
              ],
            );
          },
        );
        setState(() {
          validationImg = true;
          loading = false;
          name.clear();
          description.clear();
          price.clear();
          quantity.clear();
          _image = null;
        });
      });
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ops'),
            content: Text('Algo deu errado, tente novamente!'),
            actions: [
              FlatButton(
                child: Text('Entendi!'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFF0C2338),
          title: Text(
            'Editar produto',
          ),
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 160,
                    child: validationImg == true
                        ? null
                        : _image == null
                            ? Padding(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Image.network(widget.imageUrl),
                              )
                            : Padding(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Image.file(_image),
                              ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 28, 0, 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              getImage(true);
                            },
                            icon: Icon(Icons.photo_camera),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              getImage(false);
                            },
                            icon: Icon(Icons.photo_camera_back),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: name,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Nome do produto',
                          labelStyle: TextStyle(color: Color(0XFF0C2338)),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Informe o nome do produto';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: description,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Descrição do produto',
                          labelStyle: TextStyle(color: Color(0XFF0C2338)),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Informe a descrição do produto';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: quantity,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Quantidade do produto',
                          labelStyle: TextStyle(color: Color(0XFF0C2338)),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Informe a quantidade do produto';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: price,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Color(0XFF0C2338)),
                          labelText: 'Preço',
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Informe o preço do produto';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: loading == true
                        ? CircularProgressIndicator()
                        : RaisedButton(
                            color: Colors.green[600],
                            child: Container(
                              alignment: Alignment.center,
                              height: 60,
                              width: double.infinity,
                              child: Text(
                                'Salvar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                sendDataToApiUpdate(widget.id);
                              }
                            },
                          ),
                  ),
                ],
              ),
            )));
  }
}
