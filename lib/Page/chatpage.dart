import 'package:chatflutter_node/Custom_UI/customcart.dart';
import 'package:chatflutter_node/Models/chatmodel.dart';
import 'package:chatflutter_node/Screens/selectcontact.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final List<ChatModel> chatModel;
  final ChatModel sourceChat;
  ChatPage({Key? key, required this.chatModel, required this.sourceChat})
      : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [
    ChatModel(
      "currentMessage",
      false,
      "Akash",
      "2:58 pm",
      "",
      1,
    ),
    ChatModel(
      "currentMessage",
      false,
      "Pankaj",
      "2:58 pm",
      "",
      2,
    ),
    ChatModel(
      "currentMessage",
      false,
      "Ankush",
      "2:58 pm",
      "",
      3,
    ),
    ChatModel("currentMessage", false, "Ankit", "2:58 pm", "", 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.chatModel.length,
        itemBuilder: (context, index) => CustomCard(
          chatModel: widget.chatModel[index],
          sourceChat: widget.sourceChat,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SelectContact()));
        },
        child: const Icon(Icons.chat),
      ),
    );
  }
}
