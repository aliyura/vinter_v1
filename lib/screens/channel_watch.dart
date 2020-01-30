import 'package:flutter/material.dart';
import 'package:vinter/models/data_models.dart';
import 'package:vinter/components/get_themes.dart';
import 'package:vinter/components/get_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vinter/screens/broadcast/channel_watching_camera.dart';
import 'package:permission_handler/permission_handler.dart';

class ChannelWatchingScreen extends StatefulWidget {
  final user;
  final channel;
  ChannelWatchingScreen({this.user, this.channel});

  @override
  _ChannelWatchingScreenState createState() =>
      _ChannelWatchingScreenState();
}

class _ChannelWatchingScreenState extends State<ChannelWatchingScreen> {
  UserModel currentUser;
  DocumentSnapshot channel;

  void initState() {
      currentUser = widget.user;
      channel = widget.channel;
      _validatePermisions();
    super.initState();
  }

  _validatePermisions()async{
     await _handleCameraAndMic();
  }
  
  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.nearlyBlack,
      appBar: singleAppBar(
          context,
          channel != null && channel['name'] != null
              ? channel['name']
              : 'Unknown Channel'),
      body: ChannelWatchingScreen(
           user:currentUser,channel:channel
        ),
    );
  }
}
