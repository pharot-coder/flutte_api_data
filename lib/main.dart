import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_getdata_api/myDrawer.dart';
import 'package:flutter_getdata_api/updatePage.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;
import 'bottomappBar.dart';
import 'createData.dart';

void main() => runApp(MaterialApp(
      home: GetDataAPI(),
    ));

class GetDataAPI extends StatefulWidget {
  @override
  _GetDataAPIState createState() => _GetDataAPIState();
}

class _GetDataAPIState extends State<GetDataAPI> {
  String url = "https://peopleinfoapi.herokuapp.com/api/person";

  Future Getdata() async {
    final response = await http.get(url);
    return jsonDecode(response.body)['data'];
  }

  Future deleteData(int id) async {
    final response = await http.delete("${url}/$id");
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Get Data API'),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: FutureBuilder(
        future: Getdata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    ListTile(
                      // leading: Image.network(
                      //   "https://img5.goodfon.com/wallpaper/nbig/0/b6/japanese-girl-cute-beautiful-pretty-asian.jpg",
                      //   fit: BoxFit.scaleDown,
                      // ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://img5.goodfon.com/wallpaper/nbig/0/b6/japanese-girl-cute-beautiful-pretty-asian.jpg"),
                        radius: 50,
                      ),
                      title: Text(snapshot.data[index]['first_name']),
                      onTap: () {
                        int id = snapshot.data[index]['id'];
                        String firstName = snapshot.data[index]['first_name'];
                        String lastName = snapshot.data[index]['last_name'];
                        String age = snapshot.data[index]['age'];
                        String activeDate = snapshot.data[index]['active_date'];

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => UpdatePage(
                                      id: id,
                                      firstName: firstName,
                                      lastName: lastName,
                                      age: age,
                                      activeDate: activeDate,
                                    )));
                      },
                      trailing: FlatButton(
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          deleteData(snapshot.data[index]['id']);
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => CrateData()));
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}
