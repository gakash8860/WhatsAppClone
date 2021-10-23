import 'package:chatflutter_node/Models/chatmodel.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final ChatModel contact;
  const ContactCard({Key? key,required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: CircleAvatar(
          radius: 23,
          backgroundColor: Colors.blueGrey[200],
          // child: ,
        ),
        title: Text(
         contact.name,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(contact.status),
      ),
    );
  }
}
