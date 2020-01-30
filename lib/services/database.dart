import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vinter/config.dart' as config;

import 'package:vinter/models/data_models.dart';

class DatabaseService {
  final uid;
  final channelCollection = Firestore.instance.collection('channels');
  final userCollection = Firestore.instance.collection('users');
  final liveUsersCollection = Firestore.instance.collection('live_users');

  DatabaseService(this.uid);

  Future<dynamic> addUser(
      String username, String country, String countryCode) async {
      final FirebaseUser user = await FirebaseAuth.instance.currentUser();

    try {
      await config.getCurrentLocation().then((location) {
        return userCollection.document(uid).setData({
          'userName': username,
          'country': country,
          'countryCode': countryCode,
          'location': location,
          'phoneNumber': user.phoneNumber,
          'photo': null,
        }).timeout(Duration(seconds: 60), onTimeout: () {
          return null;
        });
      });
    } catch (ex) {
      return null;
    }
  }

  Future<bool> checkUser() async {
    final snapShot = await userCollection.document(uid).get();
    if (snapShot == null || !snapShot.exists) {
      return false;
    } else {
      return true;
    }
  }

  Future addChannel(String name, description) async {
    final now = DateTime.now();
    try {
      await config.getCurrentLocation().then((location) {
        return channelCollection.add({
          'uid': uid,
          'islive': false,
          'name': name,
          'location': location,
          'description': description,
          'publisgedDate': now
        });
      });
    } catch (ex) {
      return null;
    }
  }

  Future notifyBroadcast(String channelId, bool isLive) async {
    try {
      final now = DateTime.now();
      await config.getCurrentLocation().then((location) {
        return channelCollection
            .document(channelId)
            .updateData(<String, dynamic>{
          'islive': isLive,
          'location': location,
          'publisgedDate': now
        });
      });
    } catch (ex) {
      return null;
    }
  }

  Future joinChannelBroadcast(
      String channelId, UserModel currentUser, bool isJoined) async {
    try {
      final now = DateTime.now();
      await config.getCurrentLocation().then((location) {
        if (isJoined) {
          return liveUsersCollection.document(currentUser.uid).setData({
            'user': currentUser,
            'type': '_channel',
            'location': location,
            'joinedDate': now
          }).timeout(Duration(seconds: 60), onTimeout: () {
            return null;
          });
        } else {
          return liveUsersCollection.document(currentUser.uid).delete();
        }
      });
    } catch (ex) {
      return null;
    }
  }
}

class SnapingService {
  final uid;
  final usersCollection = Firestore.instance.collection('users');
  SnapingService(this.uid);

  UserModel _userDetailFomart(DocumentSnapshot snapshot) {
    final document = snapshot.data;
    return UserModel(
      uid: uid,
      name: document['userName'],
      country: document['country'],
      countryCode: document['countryCode'],
      location: document['location'],
      phoneNumber: document['phoneNumber'],
      photo: document['photo'],
    );
  }

  Stream<UserModel> get geUser {
    return usersCollection.document(uid).snapshots().map(_userDetailFomart);
  }
}
