import 'package:flutter/material.dart';
import 'package:vinter/components/get_app_bar.dart';
import 'package:vinter/components/get_drawer.dart';
import 'package:vinter/components/get_themes.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:vinter/screens/views/channels.dart';
import 'package:vinter/screens/views/user_channels.dart';
import 'package:vinter/screens/views/contacts.dart';
import 'package:vinter/screens/views/home.dart';
import 'package:vinter/models/data_models.dart';
import 'package:vinter/models/global.dart';
import 'package:vinter/config.dart' as config;

class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> with TickerProviderStateMixin {
  AnimationController animationController;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel currentUser = CurrentUser(context).info;

    return Container(
      child: Scaffold(
        backgroundColor: AppTheme.background,
        appBar: appBar(context),
        drawer: Drawer(
          child: NavigationDrawer(iconAnimationController: animationController),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.home, size: 30, color: AppTheme.background),
            Icon(Icons.subscriptions, size: 30, color: AppTheme.background),
            Icon(Icons.missed_video_call, size: 40, color: AppTheme.background),
            Icon(Icons.people, size: 30, color: AppTheme.background),
          ],
          color: AppTheme.appLightColor,
          buttonBackgroundColor: AppTheme.appDarkColor,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 400),
          onTap: (index) {
            setState(() {
              config.currentScreen = index;
            });
          },
        ),
        body: Container(
          child: Center(
            child: ListView(
              children: <Widget>[
                config.currentScreen == 0
                    ? Container(
                        child: HomeView(),
                      )
                    : config.currentScreen == 1
                        ? Container(
                            child: ChannelView(),
                          )
                        : config.currentScreen == 2
                            ? Container(
                                child: UserChannelsView(owner:currentUser.uid),
                              )
                            : config.currentScreen == 3
                                ? Container(
                                    child: ContactsView(),
                                  )
                                : SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
