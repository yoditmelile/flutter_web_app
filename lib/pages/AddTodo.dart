import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff1d1e26),
          Color(0xff252041),
        ])),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 30,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.arrow_left,
                color: Colors.white,
                size: 28,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create",
                    style: TextStyle(
                      fontSize: 33,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "New Todo",
                    style: TextStyle(
                      fontSize: 33,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  label("Task Title"),
                  SizedBox(
                    height: 12,
                  ),
                  title(),
                  SizedBox(
                    height: 20,
                  ),
                  label("Task Type"),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      chipData("Important", 0xff2664fa),
                      SizedBox(
                        width: 20,
                      ),
                      chipData("Planned", 0xff2bc8d9),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  label("Description"),
                  SizedBox(
                    height: 5,
                  ),
                  description(),
                  SizedBox(
                    height: 20,
                  ),
                  label("Catagory"),
                  SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    runSpacing: 10,
                    children: [
                      chipData("Food", 0xffff6d6e),
                      SizedBox(
                        width: 20,
                      ),
                      chipData("work", 0xfff69739),
                      SizedBox(
                        width: 20,
                      ),
                      chipData("Design", 0xff6557ff),
                      SizedBox(
                        width: 20,
                      ),
                      chipData("Run", 0xff234ebd),
                      SizedBox(
                        width: 20,
                      ),
                      chipData("Meet friends", 0xff2bc8d9),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  button(),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget button() {
    return Container(
      height: 56,
      width: MediaQuery.of(context).size.width - 0,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          Color(0xfffd746c),
          Color(0xffff9068),
          Color(0xfffd746c),
        ]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          "Add Todo",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget description() {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.white, fontSize: 17),
        maxLines: null,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Description",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 17,
            ),
            contentPadding: EdgeInsets.only(
              left: 20,
              right: 20,
            )),
      ),
    );
  }

  Widget chipData(String label, int color) {
    return Chip(
      backgroundColor: Color(color),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
    );
  }

  Widget title() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Color(0xff2a2e3d), borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        style: TextStyle(color: Colors.white, fontSize: 17),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Task Title",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 17,
            ),
            contentPadding: EdgeInsets.only(
              left: 20,
              right: 20,
            )),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
          fontSize: 16.5),
    );
  }
}
