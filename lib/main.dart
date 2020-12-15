import 'package:flutter/material.dart';
import 'package:tababar/TabBarPage.dart';
import 'package:tababar/db_helper.dart';

import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
      DBHelper.myDatabase.initDb();
   getAllTask().whenComplete(() =>
       runApp(MyApp())
   );

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabBarPage(User("Nur","Email")),
    );
  }
}
