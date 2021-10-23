import 'package:chatflutter_node/Custom_UI/buttoncard.dart';
import 'package:chatflutter_node/Models/chatmodel.dart';
import 'package:chatflutter_node/Screens/homescreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel sourceChat;
  List<ChatModel> chats = [
    ChatModel("currentMessage", false, "Akash", "2:58 pm", "", 1),
    ChatModel("currentMessage", false, "Pankaj", "2:58 pm", "", 2),
    ChatModel("currentMessage", false, "Ankush", "2:58 pm", "", 3),
    ChatModel("currentMessage", false, "Ankit", "2:58 pm", "", 4),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            sourceChat = chats.removeAt(index);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) =>  HomeScreen(chatModels: chats,sourceChat: sourceChat,)));
          },
          child: ButtonCard(
            name: chats[index].name,
            icon: Icons.person,
          ),
        ),
      ),
    );
  }
}
