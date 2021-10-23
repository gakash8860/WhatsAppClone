import 'package:chatflutter_node/Custom_UI/ownMessage.dart';
import 'package:chatflutter_node/Custom_UI/replycard.dart';
import 'package:chatflutter_node/Models/chatmodel.dart';
import 'package:chatflutter_node/Models/messagemodel.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as Io;

class IndividualPage extends StatefulWidget {
  final ChatModel chatModel;
  final ChatModel sourceChat;
  const IndividualPage(
      {Key? key, required this.chatModel, required this.sourceChat})
      : super(key: key);

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  late Io.Socket socket;
  bool sendButton = false;
  ScrollController _scrollController = ScrollController();
  List<MessageModel> messages = [];
  late DateTime now;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    now = DateTime.now();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      } else {}
    });
  }

  void connect() {
    socket = Io.io("http://192.168.0.101:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoconnect": false,
    });
    socket.connect();
    socket.emit("signin", widget.sourceChat.id);
    socket.onConnect((data) {
      print("Connected Flutter to node");
      socket.on("message", (msg) {
        print(msg);
        setMessage("destination", msg["message"]);
      });
    });
    print(socket.connected);
  }

  void send(String message, int sourceId, int targetId) {
    setMessage("source", message);
    socket.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

  void setMessage(String type, String message) {
        now = DateTime.now();
    MessageModel messageModel = MessageModel(message: message, type: type,time: now.toString());
    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image.asset()
        Scaffold(
          backgroundColor: Colors.grey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              leadingWidth: 70,
              titleSpacing: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blueGrey,
                    ),
                  ],
                ),
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chatModel.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Online",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.video_call)),
                IconButton(onPressed: () {}, icon: Icon(Icons.call)),
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
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Column(
                children: [
                  Expanded(
                    // height: MediaQuery.of(context).size.height - 140,
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length + 1,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Container(
                            height: 50,
                          );
                        }
                        if (messages[index].type == "source") {
                          return OwnMessageCard(
                            message: messages[index].message,
                            
                            // time
                          );
                        } else {
                          return ReplyMessageCard(
                            message: messages[index].message,

                          );
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 55,
                                child: Card(
                                  margin: const EdgeInsets.only(
                                      left: 2, right: 2, bottom: 8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    controller: _controller,
                                    focusNode: focusNode,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    onChanged: (value) {
                                      if (value.length > 0) {
                                        setState(() {
                                          sendButton = true;
                                        });
                                      } else {
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Type a message",
                                        contentPadding: EdgeInsets.all(5),
                                        suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      context: context,
                                                      builder: (builder) =>
                                                          bottomSheet());
                                                },
                                                icon: Icon(Icons.attach_file)),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(Icons.camera_alt)),
                                          ],
                                        ),
                                        prefixIcon: IconButton(
                                            onPressed: () {
                                              focusNode.unfocus();
                                              focusNode.canRequestFocus = false;
                                              setState(() {
                                                show = !show;
                                              });
                                              print('vv');
                                            },
                                            icon: Icon(Icons.emoji_emotions))),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 5, right: 5, left: 3),
                                child: CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Colors.teal,
                                  child: IconButton(
                                      onPressed: () {
                                        if (sendButton == true) {
                                          _scrollController.animateTo(
                                              _scrollController
                                                  .position.maxScrollExtent,
                                              duration:
                                                  Duration(milliseconds: 300),
                                              curve: Curves.easeOut);
                                          send(
                                              _controller.text,
                                              widget.sourceChat.id,
                                              widget.chatModel.id);
                                          _controller.clear();
                                          setState(() {
                                            sendButton = false;
                                          });
                                        }
                                      },
                                      icon: Icon(
                                        sendButton ? Icons.send : Icons.mic,
                                        color: Colors.white,
                                      )),
                                ),
                              )
                            ],
                          ),
                          show ? emojiSelect() : Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              onWillPop: () async {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
        rows: 4,
        columns: 7,
        onEmojiSelected: (emoji, category) {
          print(emoji);
          setState(() {
            _controller.text = _controller.text + emoji.emoji;
          });
        });
  }

  Widget iconCreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 25,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(text),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Colors.indigo, "Documents"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
                  // Icon(Icons.)
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.location_pin, Colors.green, "Location"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Colors.purple, "Contact"),
                  // Icon(Icons.)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
