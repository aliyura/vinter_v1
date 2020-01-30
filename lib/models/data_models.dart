class ChannelModel {
  final id;
  final uid;
  final islive;
  final location;
  final name;
  final description;
  final publisgedDate;
  final userName;
  final userPhoto;
  final userLocation;
  ChannelModel(
      {this.userName,
      this.userPhoto,
      this.userLocation,
      this.id,
      this.uid,
      this.islive,
      this.location,
      this.name,
      this.description,
      this.publisgedDate});
}

class UserModel {
  final uid;
  final name;
  final photo;
  final location;
  final country;
  final countryCode;
  final phoneNumber;

  UserModel({
    this.uid,
    this.name,
    this.photo,
    this.location,
    this.country,
    this.countryCode,
    this.phoneNumber
  });
}


