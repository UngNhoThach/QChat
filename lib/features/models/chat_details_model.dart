class messagesModel {
  messagesModel({
    required this.msg,
    required this.read,
    required this.told,
    required this.ID,
    required this.type,
    required this.sent,
  });
  late final String msg;
  late final String read;
  late final String told;
  late final String ID;
  late final Type type;
  late final String sent;

  messagesModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'].toString();
    read = json['read'].toString();
    told = json['told'].toString();
    ID = json['ID'].toString();
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text;
    sent = json['sent '].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['msg'] = msg;
    data['read'] = read;
    data['told'] = told;
    data['ID'] = ID;
    data['type'] = type.name;
    data['sent '] = sent;
    return data;
  }
}

// type of message
enum Type { text, image }
