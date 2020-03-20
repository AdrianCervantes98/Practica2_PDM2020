import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica_dos/apuntes/apuntes_detail.dart';
import 'package:practica_dos/apuntes/bloc/apuntes_bloc.dart';
import 'package:practica_dos/models/apunte.dart';

class ItemApuntes extends StatefulWidget {
  final String imageUrl;
  final String materia;
  final String descripcion;
  final int index;
  ItemApuntes({
    Key key,
    @required this.imageUrl,
    @required this.index,
    @required this.materia,
    @required this.descripcion,
  }) : super(key: key);

  @override
  _ItemApuntesState createState() => _ItemApuntesState();
}

class _ItemApuntesState extends State<ItemApuntes> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Apunte apunte = new Apunte(materia: widget.materia, descripcion: widget.descripcion, imageUrl: widget.imageUrl);
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context){
            return ApuntesDetail(apunte: apunte);
          })
        );
      },
      child: Card(
        margin: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _showDialog();
                  },
                )
              ],
            ),
            Image.network(
              widget.imageUrl ?? "https://via.placeholder.com/150",
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
            Container(
              child: Text(
                "${widget.materia}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: Text("${widget.descripcion}"),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Eliminar apunte"),
          content: new Text("¿Desea eliminar el apunte de la materia ${widget.materia}?"),
          actions: <Widget>[
            new RaisedButton(
              child: new Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new RaisedButton(
              child: new Text("Aceptar"),
              onPressed: () {
                _deleteNote();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteNote() {
    BlocProvider.of<ApuntesBloc>(context).add(
      RemoveDataEvent(index: widget.index),
    );
  }
}
