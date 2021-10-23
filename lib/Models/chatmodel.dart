class ChatModel {
  late String name;
  late String icon;
  late bool isGroup;
  late String time;
  late String currentMessage;
  late String status;
  int id;
  ChatModel(
    this.currentMessage,
    this.isGroup,
    this.name,
    this.time,
    this.status,
    this.id,
  );
}
