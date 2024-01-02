class ImageModel{
  String? email;
  String? image;

  ImageModel({this.email, this.image});

  //receiving
  factory ImageModel.fromMap(map){
    return ImageModel(
      email: map['email'],
      image: map['image'],
    );
  }

  //sending data from the server
  Map <String, dynamic> toMap(){
    return{
      'email':email,
      'image': image,
    };
  }
}
