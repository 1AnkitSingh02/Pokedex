import 'package:flutter/material.dart';
import 'search.dart';

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: myController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Pok.name = myController.text;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Pokelist()),
          );

          // return showDialog(
          //   context: context,
          //   builder: (context) {
          //     return AlertDialog(

          //       content: Text(myController.text),
          //     );
          //   },
          // );
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields),
      ),
    );
  }
}
