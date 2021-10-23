// ignore_for_file: file_names

import 'package:chatflutter_node/Models/chatmodel.dart';
import 'package:chatflutter_node/Page/chatpage.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final List<ChatModel> chatModels;
  final ChatModel sourceChat;
  HomeScreen({Key? key, required this.chatModels,required this.sourceChat}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WhatsApp Clone"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          PopupMenuButton<String>(onSelected: (value) {
            print(value);
          }, itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                child: Text("New Group"),
                value: "New Group",
              ),
              const PopupMenuItem(
                child: Text("Broadcast"),
                value: "Broadcast",
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
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: tabController,
          tabs: [
            Tab(
              icon: const Icon(Icons.camera_alt),
            ),
            Tab(
              text: "Chats",
            ),
            Tab(
              text: "Status",
            ),
            Tab(
              text: "Calls",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Text('Camera'),
          ChatPage(
            chatModel: widget.chatModels,
            sourceChat: widget.sourceChat,
          ),
          Text('Status'),
          Text('Call'),
        ],
      ),
    );
  }
}
