import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vinter/components/get_themes.dart';
import 'package:vinter/components/loading.dart';

class ContactsList extends StatefulWidget {
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  List<Contact> _contacts;

  @override
  void initState() {
    _getContacts();
    super.initState();
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.contacts);
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.disabled) {
      Map<PermissionGroup, PermissionStatus> permissionStatus =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.contacts]);
      return permissionStatus[PermissionGroup.contacts] ??
          PermissionStatus.unknown;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw new PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to location data denied",
          details: null);
    } else if (permissionStatus == PermissionStatus.disabled) {
      throw new PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
  }

  _getContacts() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      var contacts =
          (await ContactsService.getContacts(withThumbnails: false)).toList();
      setState(() {
        _contacts = contacts;
      });
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _contacts != null
          ? ListView.builder(
              itemCount: _contacts?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                Contact c = _contacts?.elementAt(index);

                return Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 5, bottom: 5),
                      margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                      alignment: Alignment.topLeft,
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
                      child: Stack(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.only(left: 0),
                            leading: (c.avatar != null && c.avatar.length > 0)
                                ? CircleAvatar(
                                    backgroundImage: MemoryImage(c.avatar))
                                : CircleAvatar(
                                    child: Text(c.displayName
                                        .substring(0, 2)
                                        .toUpperCase())),
                            title: SizedBox(
                              child: Row(children: <Widget>[
                                Text(
                                    c.displayName == ''
                                        ? 'Unknown'
                                        : c.displayName,
                                    style: TextStyle(
                                        color: AppTheme.darkerText,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ]),
                            ),
                            subtitle: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('080654567876'),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                );

                ListTile(
                  onTap: () {},
                  leading: (c.avatar != null && c.avatar.length > 0)
                      ? CircleAvatar(backgroundImage: MemoryImage(c.avatar))
                      : CircleAvatar(child: Text(c.initials())),
                  title: Text(c.displayName ?? ""),
                );
              },
            )
          : Center(
              child: Loading(),
            ),
    );
  }
}
