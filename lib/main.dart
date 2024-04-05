import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:studentrecords/home_screen.dart';
import 'package:studentrecords/student_helper.dart';
import 'package:studentrecords/student_model.dart';

String hiveStudent = 'students';
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());
  runApp(const MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  void initState() {
   StudentHelper sdntList=StudentHelper();
      sdntList.getStudentList();
    super.initState();
    
  }



  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      home: HomeScreen(),
    );
  }
  
 
}
