class WorkRequestModel{
  String? senderId;
  String? receiverId;
  String? status;

  WorkRequestModel({ this.senderId, this.receiverId, this.status});

  //receiving data from server
  factory WorkRequestModel.fromMap(map){
    return WorkRequestModel(
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