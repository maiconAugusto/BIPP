import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/src/services/index.dart';
import 'package:dio/dio.dart';

class NewProduct extends StatefulWidget {
  @override
  _NewProduct createState() => _NewProduct();
}

class _NewProduct extends State<NewProduct> {
  final _formKey = GlobalKey<FormState>();
  ImagePicker picker = ImagePicker();
  File _image;
  bool loading = false;

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

  void sendDataToApi() async {
    try {
      setState(() {
        loading = true;
      });
      String fileName = _image.path.split('/').last;
      Dio dio = new Dio();

      FormData data = FormData.fromMap({
        'name': name.text,
        'description': description.text,
        'quantity': quantity.text,
        'price': double.parse(price.text),
        'active': true,
        "file": await MultipartFile.fromFile(
          _image.path,
          filename: fileName,
        ),
      });

      await dio.post(Api.api + 'product', data: data).then((response) {
        setState(() {
          loading = false;
          name.clear();
          description.clear();
          price.clear();
          quantity.clear();
        });
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFF0C2338),
          title: Text(
            'Novo produto',
          ),
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 180,
                    child: _image == null
                        ? Center(
                            child: Text(
                              'Imagem não informada',
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Image.file(_image),
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                      keyboardType: TextInputType.text,
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
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                sendDataToApi();
                              }
                            },
                          ),
                  ),
                ],
              ),
            )));
  }
}
