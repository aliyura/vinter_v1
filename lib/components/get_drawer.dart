import 'package:vinter/components/get_themes.dart';
import 'package:vinter/models/data_models.dart';
import 'package:vinter/screens/about.dart';
import 'package:vinter/screens/feedback.dart';
import 'package:vinter/screens/help.dart';
import 'package:vinter/screens/invite_friend.dart';
import 'package:vinter/screens/profile.dart';
import 'package:vinter/screens/edit_profile.dart';
import 'package:vinter/screens/rate_app.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:vinter/services/auth.dart';
import 'package:vinter/services/database.dart';
import 'package:vinter/models/global.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({
    this.iconAnimationController,
  });

  final AnimationController iconAnimationController;
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

enum DrawerIndex {
  HOME,
  Help,

  FeedBack,
  Share,
  About,
  Invite,
  Testing,
}

class DrawerList {
  String labelName;
  Icon icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex index;
  Widget view;

  DrawerList({
    this.view,
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  List<DrawerList> drawerList;

  @override
  void initState() {
    _setdDrawerListArray();
    super.initState();
  }

  _setdDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        view: HelpScreen(),
        index: DrawerIndex.Help,
        labelName: 'Help',
        isAssetsImage: true,
        icon: Icon(Icons.help_outline),
      ),
      DrawerList(
        view: EditProfile(user:  CurrentUser(context).info),
        index: DrawerIndex.Help,
        labelName: 'Edit Profile',
        isAssetsImage: true,
        icon: Icon(Icons.person_add),
      ),
      DrawerList(
        view: FeedbackScreen(),
        index: DrawerIndex.FeedBack,
        labelName: 'FeedBack',
        icon: Icon(Icons.help),
      ),
      DrawerList(
        view: InviteFriend(),
        index: DrawerIndex.Invite,
        labelName: 'Invite Friend',
        icon: Icon(Icons.group),
      ),
      DrawerList(
        view: ReateAppScreen(),
        index: DrawerIndex.Share,
        labelName: 'Rate the app',
        icon: Icon(Icons.share),
      ),
      DrawerList(
        view: AboutScreen(),
        index: DrawerIndex.About,
        labelName: 'About Us',
        icon: Icon(Icons.info),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {

   UserModel currentUser=  CurrentUser(context).info;

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppTheme.appDarkColor, AppTheme.appLightColor],
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen(user: currentUser)));
                    },
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: AppTheme.grey.withOpacity(0.6),
                              offset: const Offset(2.0, 4.0),
                              blurRadius: 8),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(60.0)),
                        child: currentUser.photo != null
                            ? Image.network(currentUser.photo)
                            : Image.asset('assets/images/avatar.jpg'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 4),
                    child: Column(
                      children: <Widget>[
                        Text(
                          currentUser.name != null
                              ? currentUser.name
                              : 'Untitled',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.nearlyWhite,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          currentUser.phoneNumber != null
                              ? currentUser.phoneNumber
                              : 'No Number',
                          style: TextStyle(
                            color: AppTheme.nearlyWhite,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList.length,
              itemBuilder: (BuildContext context, int index) {
                return inkwell(drawerList[index]);
              },
            ),
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Sign Out',
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppTheme.darkText,
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(
                  Icons.power_settings_new,
                  color: Colors.red,
                ),
                onTap: () {
                  AuthService().userLogout();
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => listData?.view),
          );
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: new BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Icon(listData.icon.icon, color: AppTheme.nearlyBlack),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppTheme.nearlyBlack,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75 - 64,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
