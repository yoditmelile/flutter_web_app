import 'package:flutter/material.dart';
import 'package:flutter_web_app/Custom/TodoCard.dart';
import 'package:flutter_web_app/Service/Auth_Service.dart';
import 'package:flutter_web_app/pages/AddTodo.dart';
import 'package:flutter_web_app/pages/SignUpPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
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
              child: Text(
                "Monday 21",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
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
            icon: Icon(
              Icons.settings,
              size: 32,
              color: Colors.white,
            ),
            label: '',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(children: [
            TodoCard(
              title: "Wake up broo",
              check: true,
              iconBgColor: Colors.white,
              iconColor: Colors.red,
              iconData: Icons.alarm,
              time: "10PM",
            ),
            SizedBox(
              height: 20,
            ),
            TodoCard(
              title: "do laundary",
              check: false,
              iconBgColor: Colors.white,
              iconColor: Colors.teal,
              iconData: Icons.wash,
              time: "12PM",
            ),
            SizedBox(
              height: 20,
            ),
            TodoCard(
              title: "meet friends  ",
              check: false,
              iconBgColor: Colors.white,
              iconColor: Colors.purple,
              iconData: Icons.people,
              time: "15PM",
            ),
          ]),
        ),
      ),
    );
  }
}

// IconButton(
//             onPressed: () async {
//               await authClass.logOut();
//               Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (builder) => SignUpPage()),
//                   (route) => false);
//             },
//             icon: Icon(Icons.logout_rounded)),
