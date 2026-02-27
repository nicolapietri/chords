import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../pages/main_page.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  Future<PackageInfo> getAppInfo() async {
    return await PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> showAboutDialog(PackageInfo info) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'About Chords',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('App name: ${info.appName}'),
                  Text('Version: ${info.version}'),
                  Text('Build: ${info.buildNumber}'),
                  SizedBox(height: 32),
                  Wrap(
                    children: [
                      Icon(
                        Icons.copyright_outlined,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      SizedBox(width: 8),
                      Text('NP soft (2026)'),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Row(
                children: [
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: Image.asset('assets/icons/icon.png'),
                  ),
                  // Icon(
                  //   Icons.home,
                  //   color: Theme.of(context).colorScheme.primary,
                  // ),
                  SizedBox(width: 10),
                  Text(
                    'Chords menu',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // menu items
          Column(
            children: [
              /*SizedBox(height: 10),*/
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const MainPage(),
                    ),
                  );
                },
              ),

              /*SizedBox(height: 10),
              Divider(),
              SizedBox(height: 10),*/
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: () async {
                  PackageInfo info = await getAppInfo();
                  if (context.mounted) Navigator.pop(context);
                  showAboutDialog(info);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
