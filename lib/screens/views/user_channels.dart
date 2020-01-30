import 'package:flutter/material.dart';
import 'package:vinter/components/get_channels.dart';
import 'package:vinter/components/get_themes.dart';

class UserChannelsView extends StatefulWidget {

  final owner;
  UserChannelsView({this.owner});

  @override
  _UserChannelsViewState createState() => _UserChannelsViewState();
}

class _UserChannelsViewState extends State<UserChannelsView> {

  String ownerID;
  @override
  void initState() {
    ownerID=widget.owner;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: AppTheme.background,
      height: MediaQuery.of(context).size.height/1.8,
      child: ChannelsCard(owner:ownerID),
    );
  }
}
