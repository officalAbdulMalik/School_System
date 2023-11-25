class ChatsUsers{

  String? firstName;
  String? lastName;
  String? profileImage;
  String? userId;
  String? userType;

  ChatsUsers(
      {this.firstName,
      this.lastName,
      this.profileImage,
      this.userId,
      this.userType,
     });

  factory ChatsUsers.fromMap(Map<String, dynamic> data) {
    return ChatsUsers(
      firstName: data['firstName'],
      lastName: data['lastName'],
      profileImage: data['profileImage'],
      userId: data['user_id'],
      userType: data['user_type'],
    );
  }
}
class ChatsMessage{
String? download;
String? message;
String? path;
String? read;
String? sendBy;
String? time;
ChatsMessage({
  this.download,
  this.message,
  this.path,
  this.read,
  this.sendBy,
  this.time

});

factory ChatsMessage.fromMap(Map<String, dynamic> data) {
  return ChatsMessage(
    download: data['message'],
    message: data['message'],
    path: data['path'],
    read: data['message'],
    sendBy: data['send_by'],
    time: data['time'],
  );
}


}