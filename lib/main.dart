import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main(){ 
  runApp(MaterialApp(
  home: DogsData(),
));
}

class DogsData extends StatefulWidget {
  @override
  DogsState createState() => DogsState();
}

class DogsState extends State<DogsData> {
  final String url = "https://reqres.in/api/users";
  List data;

  Future<String> getSWData() async{
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept":"application/json"});

    setState((){
      var resBody = json.decode(res.body);
      data = resBody["data"];
    });
    return "success!";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(backgroundColor: Colors.pink[50],      
        appBar: AppBar(  
          title: Text('Usuarios'),
          backgroundColor: Colors.pink[100], 
        ),
        body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index){ 
            return new Container(
              child: Center(
                child: Column( 
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Card(color: Colors.pink[100],
                      child: Column(
                        children: <Widget>[
                          FadeInImage(
                            image: NetworkImage(data[index]["avatar"]),
                            placeholder: AssetImage('assets/jar-loading.gif'),
                            fadeOutDuration: Duration(milliseconds: 200),
                            height: 300.0,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            padding: EdgeInsets.all(15.0) ,
                            child: Text('Photo')
                          ),
                        ],
                      ),
                    ),
                    Card(color: Colors.pink[100],
                      elevation: 20.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(data[index]["first_name"],                          
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white
                            ),
                          ),
                           subtitle: Text('Nombre')
                        )],
                      )
                    ),
                    Card(color: Colors.pink[100],
                      elevation: 20.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(data[index]["last_name"],                          
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white
                            ), 
                          ),
                           subtitle: Text('Apellido')
                        )],
                      )
                    ),
                    Card(color: Colors.pink[100],
                      elevation: 20.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(data[index]["email"],
                              style: TextStyle(
                                fontSize:20.0,
                                color: Colors.white
                              ),
                            ),
                            subtitle: Text('Email'),
                          )
                        ],
                      )  
                    ),
                    SizedBox(height:100.0) 
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
  
  @override
  void initState() { 
    super.initState();
    this.getSWData();
  }
}