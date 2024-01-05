class WorkRequestModel{
  String? uid;
  String? senderId;
  String? receiverId;
  String? status;
  String? fname;
  String? lname;
  String? mname;

  WorkRequestModel({ this.uid, this.senderId, this.receiverId, this.status, this.fname, this.lname, this.mname});

  //receiving data from server
  factory WorkRequestModel.fromMap(map){
    return WorkRequestModel(
      uid: map['uid'],
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      status: map['status'],
      fname: map['fname'],
      lname: map['lname'],
      mname: map['mname'],
    );
  }

  //sending data from server
  Map <String, dynamic> toMap(){
    return{
      'senderId': senderId,
      'receiverId': receiverId,
      'status' : status,
      'fname' : fname,
      'lname' : lname,
      'mname' : mname,
    };
  }
}