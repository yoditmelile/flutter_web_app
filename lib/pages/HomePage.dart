// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_app/Custom/TodoCard.dart';
import 'package:flutter_web_app/Service/Auth_Service.dart';
import 'package:flutter_web_app/pages/AddTodo.dart';
import 'package:flutter_web_app/pages/ProfilePage.dart';
import 'package:flutter_web_app/pages/SignUpPage.dart';
import 'package:flutter_web_app/pages/view_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("Todo").snapshots();
  List<Select> selected = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text(
            "Today's Schedule",
            style: TextStyle(
                fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/mo4.jpg"),
            ),
            SizedBox(
              width: 25,
            ),
          ],
          bottom: PreferredSize(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Monday 21",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {
                        var instance =
                            FirebaseFirestore.instance.collection("Todo");
                        for (var i = 0; i < selected.length; i++) {
                          if (selected[i].checkvalue) {
                            instance.doc(selected[i].id).delete();
                          }
                        }
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            preferredSize: Size.fromHeight(35),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black87,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 32,
                color: Colors.white,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => AddTodoPage()));
                },
                child: Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [
                        Colors.indigoAccent,
                        Colors.purple,
                      ])),
                  child: Icon(
                    Icons.add,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => Profile()));
                },
                child: Icon(
                  Icons.settings,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              label: '',
            ),
          ],
        ),
        body: StreamBuilder(
            stream: _stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    IconData iconData;
                    Color iconColor;
                    Map<String, dynamic> document = snapshot.data?.docs[index]
                        .data() as Map<String, dynamic>;
                    switch (document["category"]) {
                      case "Food":
                        iconData = Icons.food_bank_outlined;
                        iconColor = Color.fromARGB(255, 251, 20, 20);
                        break;
                      case "work":
                        iconData = Icons.run_circle_outlined;
                        iconColor = Color.fromARGB(255, 24, 20, 251);
                        break;
                      default:
                        iconData = Icons.today_outlined;
                        iconColor = const Color.fromARGB(255, 5, 65, 7);
                    }
                    selected.add(Select(
                        id: snapshot.data!.docs[index].id, checkvalue: false));
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => ViewData(
                                      document: document,
                                      id: snapshot.data!.docs[index].id,
                                    )));
                      },
                      child: TodoCard(
                          title: document["title"] == null
                              ? "Supp baby"
                              : document["title"],
                          iconData: iconData,
                          iconColor: iconColor,
                          time: "10 AM",
                          index: index,
                          onChange: onChange,
                          check: selected[index].checkvalue,
                          iconBgColor: Colors.white),
                    );
                  });
            }));
  }

  void onChange(int index) {
    setState(() {
      selected[index].checkvalue = !selected[index].checkvalue;
    });
  }
}

class Select {
  late String id;
  bool checkvalue = false;
  Select({required this.id, required this.checkvalue});
}
