// import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// List<Poke> _postList = new List<Poke>();
// Future<List<Poke>> fetchpoke() async {

class Pok {
  static String name;
  static Future<Poke> fetchpoke() async {
    final response =
        await http.get('https://poke-api1.herokuapp.com/pokemon?name=${name}');

    if (response.statusCode == 200) {
      return Poke.fromJson(json.decode(response.body));

      //bit faster ig
      // List<dynamic> values = new List<dynamic>();
      // values = (jsonDecode(response.body));
      // if (values.length > 0) {
      //   for (int i = 0; i < values.length; i++) {
      //     if (values[i] != null) {
      //       Map<String, dynamic> map = values[i];
      //       _postList.add(Poke.fromJson(map));
      //       debugPrint('Id-------${map['id']}');
      //     }
      //   }
      // }
      // return _postList;
    } else {
      throw Exception('Failed to load album');
    }
  }
}

class Poke {
  final String type;
  final String legendary;
  final String speed;
  final String id;

  Poke({this.type, this.legendary, this.speed, this.id});

  factory Poke.fromJson(Map<String, dynamic> json) {
    return Poke(
      id: json['id'],
      type: json['Type'],
      speed: json['Speed'],
      legendary: json['Legendary'],
    );
  }
}

class Pokelist extends StatefulWidget {
  @override
  _PokelistState createState() => _PokelistState();
}

class _PokelistState extends State<Pokelist> {
  Future<Poke> futurepoke;
  @override
  void initState() {
    super.initState();
    futurepoke = Pok.fetchpoke();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pokedex'),
        ),
        body: Center(
          child: FutureBuilder<Poke>(
            future: futurepoke,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Scaffold(
                  body: Center(
                    child: new Column(
                      children: [
                        new Container(
                          height: 200,
                          width: 200,
                          decoration: new BoxDecoration(
                            image: DecorationImage(
                                image: new NetworkImage(
                                    'https://pokeres.bastionbot.org/images/pokemon/${int.parse(snapshot.data.id)}.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        new Container(
                          child: new Text(
                            "Type: ${snapshot.data.type}\n Speed: ${snapshot.data.speed}\n Legendary: ${snapshot.data.legendary}",
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
