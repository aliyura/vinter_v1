import 'package:flutter/material.dart';
import 'package:vinter/components/get_channels.dart';
import 'package:vinter/components/get_themes.dart';

class ChannelView extends StatefulWidget {
  @override
  _ChannelViewState createState() => _ChannelViewState();
}
class _ChannelViewState extends State<ChannelView> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: AppTheme.background,
      height: MediaQuery.of(context).size.height/1.8,
      child: ChannelsCard(owner:'all'),
    );
  }
}
