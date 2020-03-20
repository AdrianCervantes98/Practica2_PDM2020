import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:practica_dos/apuntes/add_apunte/bloc/add_apunte_bloc.dart';

import 'package:practica_dos/apuntes/bloc/apuntes_bloc.dart';

class AddApunte extends StatefulWidget {
  AddApunte({Key key}) : super(key: key);

  @override
  _AddApunteState createState() => _AddApunteState();
}

class _AddApunteState extends State<AddApunte> {
  File _choosenImage;
  String _url;
  bool _isLoading = false;
  TextEditingController _materiaController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();
  AddApunteBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agregar apunte")),
      body: BlocProvider(
        create: (context) {
          bloc = AddApunteBloc()..add(InitEvent());
          return bloc;
        },
        child: BlocListener<AddApunteBloc, AddApunteState>(
          listener: (context, state) {
            if (state is GetImageState) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Obteniendo imagen..."),
                  ),
                );
            } 
            else if (state is GetImageErrorState) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Error al cargar la imagen."),
                  ),
                );
            } 
            else if (state is UploadedFileState) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Subiendo imagen..."),
                  ),
                );
            } 
            else if (state is UploadedFileErrorState) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Error al subir la imagen."),
                  ),
                );
            }
          },
          child: BlocBuilder<AddApunteBloc, AddApunteState>(
            builder: (context, state) {
              
              if (state is GetImageState) {
                _choosenImage = state.image;
              } 
              if (state is UploadedFileState) {
                _url = state.image;
                _saveData();
              }
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Stack(
                    alignment: FractionalOffset.center,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          _choosenImage != null
                              ? Image.file(
                                  _choosenImage,
                                  width: 150,
                                  height: 150,
                                )
                              : Container(
                                  height: 150,
                                  width: 150,
                                  child: Placeholder(
                                    fallbackHeight: 150,
                                    fallbackWidth: 150,
                                  ),
                                ),
                          SizedBox(height: 48),
                          IconButton(
                            icon: Icon(Icons.image),
                            onPressed: () {
                              bloc.add(ChooseImageEvent());
                            },
                          ),
                          SizedBox(height: 48),
                          TextField(
                            controller: _materiaController,
                            decoration: InputDecoration(
                              hintText: "Nombre de la materia",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          TextField(
                            controller: _descripcionController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: "Notas para el examen...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: RaisedButton(
                                  child: Text("Guardar"),
                                  onPressed: () {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    bloc.add(UploadFileEvent(image: _choosenImage));
                                  },
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      _isLoading ? CircularProgressIndicator() : Container(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _saveData() {
    BlocProvider.of<ApuntesBloc>(context).add(
      SaveDataEvent(
        materia: _materiaController.text,
        descripcion: _descripcionController.text,
        imageUrl: _url,
      ),
    );
    _isLoading = false;
    Future.delayed(Duration(milliseconds: 1500)).then((_) {
      Navigator.of(context).pop();
    });
  }
}
