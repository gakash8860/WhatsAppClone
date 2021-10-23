// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReplyMessageCard extends StatelessWidget {
  
  String message;
   ReplyMessageCard({ Key? key ,required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width-45,
    
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin:const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        // color: Color(0xffdcf8c6),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 60,top: 5,bottom: 20),
              child: Text(message,style: TextStyle(
                fontSize: 16,

                
                ),),
            ),
            Positioned(
              bottom: 4,
              right: 10,
              child: Text(
              now.hour.toString()+":"+now.minute.toString() ,style: TextStyle(
                 fontSize: 13,
                 color: Colors.grey[600],
               ),
                ),
            )
          ],
        ),
        ),
      ),
    );
  }
}