class WorkRequestModel{
  String? id;
  String? senderId;
  String? receiverId;
  String? status;

  WorkRequestModel({this.id, this.senderId, this.receiverId, this.status});

  //receiving data from server
  factory WorkRequestModel.fromMap(map){
    return WorkRequestModel(
      id: map['id'],
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      status: map['status']
    );
  }

  //sending data from server
  Map <String, dynamic> toMap(){
    return{
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'status' : status,
    };
  }
}