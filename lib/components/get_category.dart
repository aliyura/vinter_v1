import 'package:flutter/material.dart';
import 'package:vinter/components/get_themes.dart';
import 'package:vinter/config.dart' as config;
class Category extends StatefulWidget {

  final title, description,icon,type;
  Category({this.title,this.description, this.icon, this.type});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  dynamic title, description,icon,type;

  @override
  void initState() {
      title=widget.title;
      icon=widget.icon;
      type=widget.type;
      description=widget.description;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: <Widget>[
            Container( 
              width: double.infinity,
              margin: EdgeInsets.only(left: 46.0),
              decoration: BoxDecoration(
                color: AppTheme.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 5.0
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      child:
                    ListTile(
                      title: Text(title, style: TextStyle(
                        color: AppTheme.nearlyBlack,
                        fontSize: 18,
                      ),),
                      subtitle: Text(description,style: TextStyle(
                        color: AppTheme.dark_grey,
                        fontSize: 12
                      ),),
                    ),
                    ),
                    Align(
                      alignment:Alignment.bottomLeft,
                      child:
                    Container(
                      padding:EdgeInsets.only(left:18),
                      width: 50,
                    child:Divider(height: 10, color: AppTheme.white)
                    ),
                    ),
                    
                     Align(
                      alignment:Alignment.bottomRight,
                      child:
                    Container(
                      child: FlatButton.icon(
                        padding: EdgeInsets.all(0),
                        color: AppTheme.white,
                        icon:Icon(Icons.arrow_right),
                        textColor: AppTheme.appLightColor,
                        label: Text('Start Now'),
                        onPressed: (){
                              switch(type){
                                case '#broadcast':
                                    setState(() {
                                      config.currentScreen=2;
                                    });
                                break;
                               case '#one2one':
                                    setState(() {
                                      config.currentScreen=3;
                                    });
                                break;
                                case '#one2many':
                                    setState(() {
                                      config.currentScreen=3;
                                    });
                                break;

                                case '#interview':
                                    setState(() {
                                      config.currentScreen=3;
                                    });
                                break;
                                
                              }
                        },
                      ),
                    ),
                     )
                  
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              alignment: FractionalOffset.centerLeft,
              child: CircleAvatar(
                backgroundColor: AppTheme.appLightColor,
                radius: 40,
                backgroundImage: AssetImage(icon),

              )
            ),
          ],
        ));
  }
}
