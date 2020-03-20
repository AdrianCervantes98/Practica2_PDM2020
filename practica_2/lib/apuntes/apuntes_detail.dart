import 'package:flutter/material.dart';
import 'package:practica_dos/models/apunte.dart';
import 'package:photo_view/photo_view.dart';

class ApuntesDetail extends StatefulWidget {
  final Apunte apunte;
  ApuntesDetail({Key key, @required this.apunte}) : super(key: key);

  @override
  _ApuntesDetailState createState() => _ApuntesDetailState();
}

class _ApuntesDetailState extends State<ApuntesDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles de ${widget.apunte.materia}"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 300,
                height: 300,
                child: PhotoView(
                  imageProvider: NetworkImage(
                    "${widget.apunte.imageUrl}",
                  ),
                ),
              ),
              
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "${widget.apunte.materia}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "${widget.apunte.descripcion}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}