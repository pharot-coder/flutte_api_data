import 'package:flutter/material.dart';
import 'package:flutter_getdata_api/bottomappBar.dart';
import 'package:flutter_getdata_api/myDrawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main.dart';

class UpdatePage extends StatefulWidget {
  final int id;
  final String firstName;
  final String lastName;
  final String age;
  final String activeDate;

  const UpdatePage(
      {Key key,
      this.id,
      this.firstName,
      this.lastName,
      this.age,
      this.activeDate})
      : super(key: key);
  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  String url = "https://peopleinfoapi.herokuapp.com/api/person";
  // String url = 'http://localhost:8888/CI_API/create';
  TextEditingController fristnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController activeDateController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    fristnameController.text = widget.firstName;
    lastnameController.text = widget.lastName;
    ageController.text = widget.age;
    activeDateController.text = widget.activeDate;
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Update Data Page",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text("Update Page"),
          actions: [
            IconButton(
              icon: Icon(Icons.info),
              onPressed: () {},
            ),
          ],
        ),
        drawer: MyDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              TextField(
                controller: fristnameController,
                decoration: InputDecoration(
                    labelText: "First Name", focusColor: Colors.blue),
              ),
              TextField(
                controller: lastnameController,
                decoration: InputDecoration(
                    labelText: "Last Name", focusColor: Colors.blue),
              ),
              TextField(
                controller: ageController,
                decoration:
                    InputDecoration(labelText: "Age", focusColor: Colors.blue),
              ),
              TextField(
                controller: activeDateController,
                decoration: InputDecoration(
                    labelText: "Active Date", focusColor: Colors.blue),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.red,
                  ),
                  FlatButton(
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      updateData();
                    },
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: MyBottomAppBar(),
      ),
    );
  }

  updateData() async {
    var fname = fristnameController.text;
    var lname = lastnameController.text;
    var age = ageController.text;
    var activeDate = activeDateController.text;
    // var email = emailController.text;
    // var address = addressController.text;
    var data = json.encode({
      "first_name": fname,
      "last_name": lname,
      "age": age,
      "active_date": activeDate
    });
    var header = {
      "Content-Type": "application/json",
      "Accept": "application/json"
    };

    var response =
        await http.put("$url/${widget.id}", headers: header, body: data);
    if (response.statusCode == 200) {
      return Navigator.push(
          context, MaterialPageRoute(builder: (_) => GetDataAPI()));
    } else {
      showDialog(
          context: context,
          child: new AlertDialog(
            title: new Text("Error !"),
            content: new Text("Error to create......!"),
          ));
    }
  }
}
