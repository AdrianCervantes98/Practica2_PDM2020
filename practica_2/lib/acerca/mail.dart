import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class Mail extends StatelessWidget {
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  _sendEmail()  {
    final String _email = 'mailto:' +
        "titino98.adrian@gmail.com" +
        '?subject=' +
        _subjectController.text +
        '&body=' +
        _bodyController.text;
    try {
       launch(_email);
    } catch (e) {
      throw 'No se pudo enviar el correo.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enviar correo')),
      body: Center(
          child: Column(
        children: <Widget>[
          TextField(
            controller: _subjectController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Asunto',
            ),
          ),
          TextField(
            controller: _bodyController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Mensaje',
            ),
          ),
          RaisedButton(
            child: Text('Enviar correo'),
            color: Colors.red,
            onPressed: (){
              _sendEmail();
              Navigator.of(context).pop();
            }
          ),
        ],
      )),
    );
  }
}