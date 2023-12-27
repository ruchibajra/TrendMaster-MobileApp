//This class is for creator registration
class UserModel {
  String? uid;
  String? firstName;
  String? middleName;
  String? lastName;
  String? address;
  String? gender;
  String? email;
  String? phone;
  String? instagram;
  String? youtube;
  String? facebook;
  int? instagramSubscriber;
  int? youtubeSubscriber;
  int? facebookSubscriber;
  String? niche;
  String? description;
  String? userType;

  UserModel({this.uid, this.firstName, this.middleName, this.lastName, this.address, this.gender, this.email, this.phone, this.instagram,
  this.youtube, this.facebook, this.instagramSubscriber, this.youtubeSubscriber, this.facebookSubscriber, this.niche, this.description, this.userType});

  // receiving data from server
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      firstName: map['firstName'],
      middleName: map['middleName'],
      lastName: map['lastName'],
      address: map['address'],
      gender: map['gender'],
      email: map['email'],
      phone: map['phone'],
      instagram: map['instagram'],
      youtube: map['youtube'],
      facebook: map['facebook'],
      instagramSubscriber: map['instagramSubscriber'],
      youtubeSubscriber: map['youtubeSubscriber'],
      facebookSubscriber: map['facebookSubscriber'],
      niche: map['niche'],
      description: map['description'],
      userType: map['userType'],
    );
  }
    // sending data to server
    Map<String, dynamic> toMap(){
      return {
        'firstName' : firstName,
        if (middleName != null && middleName!.isNotEmpty) 'middleName': middleName,
        'lastName' : lastName,
        'address': address,
        'gender' : gender,
        'email': email,
        'phone' : phone,
        'instagram': instagram,
        'youtube' : youtube,
        'facebook': facebook,
        'instagramSubscriber' : instagramSubscriber,
        'youtubeSubscriber': youtubeSubscriber,
        'facebookSubscriber' : facebookSubscriber,
        'niche': niche,
        'description': description,
        'userType': userType,
    };
  }
}

//This class is for company registration
class CompanyModel{
  String? uid;
  String? name;
  String? address;
  String? email;
  String? phone;
  String? website;
  String? facebook;
  String? twitter;
  String? linkedin;
  String? description;
  String? userType;

  CompanyModel({this.uid, this.name, this.address, this.email, this.phone, this.website, this.facebook, this.twitter, this.linkedin, this.description, this.userType});

  // receiving data from server
  factory CompanyModel.fromMap(map){
    return CompanyModel(
      uid: map['uid'],
      name: map['name'],
      address: map['address'],
      email: map['email'],
      phone: map['phone'],
      website: map['website'],
      facebook: map['facebook'],
      twitter: map['twitter'],
      linkedin: map['linkedin'],
      description: map['description'],
      userType: map['userType'],
    );
  }

  // sending data to server
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'email': email,
      'phone': phone,
      'website': website,
      'facebook': facebook,
      'twitter': twitter,
      'linkedin': linkedin,
      'description': description,
      'userType': userType,
    };
  }

  void updateUid(String newUid){
    uid = newUid;
  }
}
