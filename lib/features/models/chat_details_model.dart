// class messagesModel {
//   messagesModel({
//     required this.msg,
//     required this.read,
//     required this.told,
//     required this.ID,
//     required this.type,
//     required this.sent,
//   });
//   late final String msg;
//   late final String read;
//   late final String told;
//   late final String ID;
//   late final Type type;
//   late final String sent;

//   messagesModel.fromJson(Map<String, dynamic> json) {
//     msg = json['msg'].toString();
//     read = json['read'].toString();
//     told = json['told'].toString();
//     ID = json['ID'].toString();
//     type = json['type'].toString() == Type.image.name ? Type.text : Type.image;
//     sent = json['sent '].toString();
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['msg'] = msg;
//     data['read'] = read;
//     data['told'] = told;
//     data['ID'] = ID;
//     data['type'] = type.name;
//     data['sent '] = sent;
//     return data;
//   }
// }

// // type of message
// enum Type { text, image }

class messagesModel {
  messagesModel({
    required this.msg,
    required this.to_uid,
    required this.from_uid,
    required this.type,
    required this.time_sent,
    required this.last_time,
    required this.from_name,
    required this.to_name,
  });
  late final String msg;
  late final String from_name;
  late final String to_name;
  late final String to_uid;
  late final String from_uid;
  late final Type type;
  late final String last_time;
  late final String time_sent;

  messagesModel.fromJson(Map<String, dynamic> json) {
    from_name = json['from_name'].toString();
    to_name = json['to_name'].toString();
    time_sent = json['time_sent'].toString();

    msg = json['msg'].toString();
    to_uid = json['to_uid'].toString();
    from_uid = json['from_uid'].toString();
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text;
    last_time = json['last_time'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['msg'] = msg;
    data['to_uid'] = to_uid;
    data['from_uid'] = from_uid;
    data['type'] = type.name;
    data['last_time'] = last_time;
    data['from_name'] = from_name;
    data['to_name'] = to_name;
    data['time_sent'] = time_sent;

    return data;
  }
}

// type of message
enum Type { text, image }
