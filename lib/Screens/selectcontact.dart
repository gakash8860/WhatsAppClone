import 'package:chatflutter_node/Custom_UI/contactcard.dart';
import 'package:chatflutter_node/Models/chatmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  List<ChatModel> contactList = [
    ChatModel("currentMessage", false, "Akash", "time", "Available",1),
    ChatModel("currentMessage", false, "Anuj", "time", "Available",2),
    ChatModel("currentMessage", false, "Anuj", "time", "Available",3),
    // ChatModel("currentMessage", false, "Anuj", "time", "Available",),
    ChatModel("currentMessage", false, "Anuj", "time", "Available",4),
    ChatModel("currentMessage", false, "Anuj", "time", "Available",5),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Contact",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "256 Contact",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            PopupMenuButton<String>(onSelected: (value) {
              print(value);
            }, itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  child: Text("Create Group"),
                  value: "Create Group",
                ),
                const PopupMenuItem(
                  child: Text("Invite"),
                  value: "Invite",
                ),
                const PopupMenuItem(
                  child: Text("Linked Device"),
                  value: "Linked Device",
                ),
                const PopupMenuItem(
                  child: Text("Starred Message"),
                  value: "Starred Message",
                ),
                const PopupMenuItem(
                  child: Text("Setting"),
                  value: "Setting",
                ),
              ];
            })
          ],
        ),
        body: ListView.builder(
            itemCount: contactList.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container();
              } else if (index == 1) {
                return Container();
              } else {
                return ContactCard(contact: contactList[index]);
              }
            }));
  }
}
