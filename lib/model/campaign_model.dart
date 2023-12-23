class CampaignModel{
  String? id;
  String? title;
  String? description;
  String? location;
  String? niche;
  String? creator_no;
  String? budget;

  CampaignModel({this.id, this.title, this.description, this.location, this.niche, this.creator_no, this.budget});

  //receiving data from the server
  factory CampaignModel.fromMap(map){
    return CampaignModel(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        location: map['location'],
        niche: map['niche'],
        creator_no: map['creator_no'],
        budget: map['budget']
    );
  }

  //sending data from the server
  Map <String, dynamic> toMap(){
    return{
      'title': title,
      'description': description,
      'location': location,
      'niche': niche,
      'creator_no': creator_no,
      'budget': budget,
    };
  }


}