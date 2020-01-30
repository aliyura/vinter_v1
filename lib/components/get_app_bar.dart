import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:vinter/components/get_themes.dart';
import 'package:vinter/models/data_models.dart';
import 'package:vinter/screens/profile.dart';
import 'package:vinter/components/add_channel.dart';
import 'package:vinter/models/global.dart';

Widget appBar(BuildContext context) {
  final UserModel currentUser = CurrentUser(context).info;

  return PreferredSize(
    preferredSize: Size.fromHeight(210.0),
    child: GradientAppBar(
      flexibleSpace: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomPaint(
            painter: CircleOne(),
          ),
          CustomPaint(
            painter: CircleTwo(),
          ),
        ],
      ),
      title: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              currentUser.name != null ? currentUser.name : 'Untitled',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Text(
              currentUser.location != null
                  ? currentUser.location
                  : 'Unknown Location',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 20, 0),
          child: InkWell(
            onTap: () {
              Channel().requestAddDialog(context);
            },
            child: Icon(
              Icons.plus_one,
              size: 30,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 20, 0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(user: currentUser)));
            },
            child: CircleAvatar(
                radius: 25,
                backgroundColor: AppTheme.white,
                backgroundImage: currentUser.photo != null
                    ? NetworkImage(currentUser.photo)
                    : AssetImage('assets/images/avatar.jpg')),
          ),
        ),
      ],
      elevation: 0,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppTheme.appDarkColor, AppTheme.appLightColor],
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(10),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
          decoration: BoxDecoration(
            color: AppTheme.HeaderGreyLight,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Today Reminder',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Meeting with client',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    '13.00 PM',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width / 4,
              ),
              Image.asset(
                'assets/images/live.png',
                width: 50,
                height: 50,
                scale: 1.3,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 80),
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                  size: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget singleAppBar(BuildContext context, String title) {
  UserModel currentUser = CurrentUser(context).info;

  return PreferredSize(
    preferredSize: Size.fromHeight(60.0),
    child: GradientAppBar(
      flexibleSpace: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomPaint(
            painter: CircleOne(),
          ),
          CustomPaint(
            painter: CircleTwo(),
          ),
        ],
      ),
      title: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileScreen(user: currentUser)));
          },
          child: Container(
            padding: EdgeInsets.only(top: 5, bottom: 5, right: 20),
            child: CircleAvatar(
                radius: 25,
                backgroundColor: AppTheme.white,
                backgroundImage: currentUser.photo != null
                    ? NetworkImage(currentUser.photo)
                    : AssetImage('assets/images/avatar.jpg')),
          ),
        ),
      ],
      elevation: 0,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppTheme.appDarkColor, AppTheme.appLightColor],
      ),
    ),
  );
}

class CircleOne extends CustomPainter {
  Paint _paint;

  CircleOne() {
    _paint = Paint()
      ..color = AppTheme.HeaderCircle
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(28.0, 0.0), 99.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CircleTwo extends CustomPainter {
  Paint _paint;

  CircleTwo() {
    _paint = Paint()
      ..color = AppTheme.HeaderCircle
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(-30, 20), 50.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
