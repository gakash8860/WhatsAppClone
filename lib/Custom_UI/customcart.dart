import 'package:chatflutter_node/Models/chatmodel.dart';
import 'package:chatflutter_node/Screens/individualpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final ChatModel chatModel;
 final ChatModel sourceChat;
  const CustomCard({Key? key, required this.chatModel,required this.sourceChat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => IndividualPage(chatModel: chatModel,sourceChat: sourceChat,)));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 25,
            ),
            trailing: Text("18:04"),
            title: Text(chatModel.name),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(
                  width: 5,
                ),
                Text("Hi"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
