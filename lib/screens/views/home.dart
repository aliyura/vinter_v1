import 'package:flutter/material.dart';
import 'package:vinter/components/get_category.dart';
import 'package:vinter/components/get_themes.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height / 1.8,
        child: ListView(
          children: <Widget>[
            Category(
              title: 'Talk to Friend',
              description:
                  'Start a real time video conversation with your friend',
              icon: 'assets/images/talks.png',
              type: '#one2one',
            ),
            Category(
              title: 'Group Talks',
              description:
                  'Create a live video meeting with family and friends',
              icon: 'assets/images/meeting.png',
              type: '#one2many',
            ),
            Category(
              title: 'Interview',
              description:
                  'Create real time interview  schedule with others',
              icon: 'assets/images/interview.png',
              type: '#interview',
            ),
            Category(
              title: 'Broadcast',
              description:
                  'Start broadcasting a real time video to your channel',
              icon: 'assets/images/broadcast.png',
              type: '#broadcast',
            ),
          ],
        ));
  }
}
