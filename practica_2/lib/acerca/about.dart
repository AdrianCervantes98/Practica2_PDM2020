import 'package:flutter/material.dart';
import 'package:practica_dos/acerca/mail.dart';

class About extends StatelessWidget {
  const About({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacto"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text (
                  "Práctica 2 PDM", 
                  style: TextStyle (
                    fontSize: 20, 
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text (
              "Esta aplicación permite al usuario crear recordatorios y apuntes para sus exámenes.", 
              textAlign: TextAlign.center,
              style: TextStyle (
                fontSize: 16, 
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text (
                  "Desarrollador:", 
                  style: TextStyle (
                    fontSize: 20, 
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text (
                  "Adrián Alejandro Cervantes Amezcua", 
                  style: TextStyle (
                    fontSize: 16, 
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text (
                  "Contacta al desarrollador", 
                  style: TextStyle (
                    fontSize: 16, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return Mail();
                      })
                    );
                  },
                  color: Colors.grey[400],
                  minWidth: MediaQuery.of(context).size.width*.4,
                  child: Text(
                    "Contactar"
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
