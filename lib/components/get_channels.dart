import 'package:flutter/material.dart';
import 'package:vinter/components/loading.dart';
import 'package:vinter/components/get_themes.dart';
import 'package:vinter/models/data_models.dart';
import 'package:vinter/models/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vinter/screens/channel_broadcasting.dart';
import 'package:vinter/screens/channel_watch.dart';
import 'package:vinter/components/add_channel.dart';

class ChannelsCard extends StatefulWidget {
  final owner;
  ChannelsCard({this.owner});

  @override
  _ChannelsCardState createState() => _ChannelsCardState();
}

class _ChannelsCardState extends State<ChannelsCard> {
  final channelsCollection = Firestore.instance.collection('channels');
  final usersCollection = Firestore.instance.collection('users');
  dynamic channelId, channelName, description, publisgedDate, islive;
  dynamic uid, name, photo, location;
  String ownerID;

  @override
  void initState() {
    ownerID = widget.owner;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel currentUser = CurrentUser(context).info;
    return Container(
      child: StreamBuilder(
        //channel stream
        stream: ownerID != null && ownerID != '' && ownerID != 'all'
            ? channelsCollection.where('uid', isEqualTo: ownerID).snapshots()
            : channelsCollection.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          }
          return snapshot.data.documents.length > 0
              ? ListView.builder(
                  itemExtent: 200,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot channelDocument =
                        snapshot.data.documents[index];
                    final uid = channelDocument['uid'];
                    return StreamBuilder(
                        //user stream
                        stream: usersCollection.document(uid).snapshots(),
                        builder: (context, userDocument) {
                          if (!userDocument.hasData) {
                            return Loading();
                          }
                          return _channelList(context, currentUser,
                              channelDocument, userDocument.data);
                        });
                  },
                )
              : Container(
                  child: Center(
                      child: Column(
                    children: <Widget>[
                      Text(' No Channel Available'),
                      SizedBox(height: 10),
                      FlatButton.icon(
                        icon: Icon(Icons.add),
                        label: Text('Create Channel'),
                        onPressed: () {
                          Channel().requestAddDialog(context);
                        },
                      )
                    ],
                  )),
                );
        },
      ),
    );
  }

  Widget _channelList(BuildContext context, UserModel currentUser,
      DocumentSnapshot channel, DocumentSnapshot user) {
    channelId = channel.documentID;
    channelName = channel['name'];
    description = channel['description'];
    publisgedDate = channel['publisgedDate'];
    location = channel['location'];
    islive = channel['islive'];
    uid = channel['uid'];
    //get user details
    name = user['userName'];
    photo = user['photo'];

    // print(publisgedDate);
    //print(Converter().convertToDate(publisgedDate));
    //dynamic time = DateTime.parse(publisgedDate.toString());
    //publisgedDate = timeago.format(time);

    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          constraints: BoxConstraints(minHeight: 70),
          margin: EdgeInsets.only(bottom: 10),
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
            color: AppTheme.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0.0, 5.0),
              ),
            ],
          ),
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.only(left: 0),
                leading: Image.asset(
                    photo == null || photo == ''
                        ? 'assets/images/avatar.jpg'
                        : photo,
                    width: 50,
                    height: 50),
                title: SizedBox(
                  child: Row(children: <Widget>[
                    Text(
                        channelName == '' || channelName == null
                            ? 'Unknown'
                            : channelName,
                        style: TextStyle(
                            color: AppTheme.darkerText,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Container(
                      child: CircleAvatar(
                        maxRadius: 6.0,
                        backgroundColor:
                            islive ? AppTheme.appLightColor : Colors.grey,
                      ),
                    ),
                  ]),
                ),
                subtitle:
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(name == '' || name == null ? 'Anonymous' : name),
                  SizedBox(width: 10),
                  Icon(
                    Icons.location_on,
                    size: 18,
                  ),
                  Text(location == '' || location == null
                      ? 'Unknown'
                      : location),
                ]),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(left: 65),
                child: Container(
                  child: Text(description == '' || description == null
                      ? 'No Description'
                      : description),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    margin: EdgeInsets.only(left: 65),
                    child: Row(
                      children: <Widget>[
                        Align(
                          child: Text('12 minues ago',
                              style: TextStyle(color: AppTheme.nearlyBlue)),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: FlatButton.icon(
                            color: AppTheme.white,
                            icon: Icon(Icons.arrow_right),
                            textColor: AppTheme.appLightColor,
                            label: uid == currentUser.uid
                                ? Text('Go Live')
                                : Text('Watch Now'),
                            onPressed: () {
                              if (uid == currentUser.uid) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChannelBroadcastingScreen(
                                                user: currentUser,
                                                channel: channel)));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChannelWatchingScreen(
                                                user: currentUser,
                                                channel: channel)));
                              }
                            },
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ],
    );
  }
}
