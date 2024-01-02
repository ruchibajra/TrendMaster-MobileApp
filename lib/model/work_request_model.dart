class WorkRequestModel{
  String? uid;
  String? senderId;
  String? receiverId;
  String? status;

  WorkRequestModel({ this.uid, this.senderId, this.receiverId, this.status});

  //receiving data from server
  factory WorkRequestModel.fromMap(map){
    return WorkRequestModel(
      uid: map['uid'],
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      status: map['status']
    );
  }

  //sending data from server
  Map <String, dynamic> toMap(){
    return{
      'senderId': senderId,
      'receiverId': receiverId,
      'status' : status,
    };
  }
}