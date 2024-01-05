//This class is for company adding details to create campaign

class CampaignModel{
  String? id;
  String? title;
  String? description;
  String? niche;
  String? budget;
  String? location;
  int? count;
  String? image;
  String? userId;
  String? companyName;


  CampaignModel({this.id, this.title, this.description, this.niche, this.budget, this.count, this.location, this.image, this.userId, this.companyName});

  // receiving data from the server
  factory CampaignModel.fromMap(map) {
    return CampaignModel(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        niche: map['niche'],
        budget: map['budget'],
        count: map['count'],
        location: map['location'],
        image: map['image'],
        userId: map['userId'],
        companyName: map['companyName']
    );
  }

  // sending data from the server
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'niche': niche,
      'budget': budget,
      'count': count,
      'location': location,
      'image': image,
      'userId': userId,
      'companyName': companyName,
    };
  }
}

