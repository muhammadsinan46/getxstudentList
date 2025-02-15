// ignore_for_file: file_names, unrelated_type_equality_checks

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:studentrecords/main.dart';
import 'package:studentrecords/profile_details.dart';
import 'package:studentrecords/student_helper.dart';
import 'package:studentrecords/student_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
StudentHelper controller = Get.put(StudentHelper());

  StudentHelper sdntList = StudentHelper();
  late Box<Student> studentBox = Hive.box(hiveStudent);
  TextEditingController searchController = TextEditingController();
  String searchtext = '';
  Timer? debouncer;
  @override
  void initState() {
    super.initState();
    sdntList.getStudentList();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text("Students Records"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (search) {
                  onSearch(search);
                },
                controller: searchController,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                        onPressed: () => searchController.clear(),
                        icon: const Icon(Icons.remove_circle_outline)),
                    hintText: "Search Students..",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            // Expanded(
            //     child: 
      
              
            //     ListView.separated(
            //           itemCount: .length,
            //           separatorBuilder: (context, index) => const Divider(),
            //           itemBuilder: (context, index) {
            //             final student = studentList[index];
            //             return ListTile(
            //                 onTap: () {
            //                   Navigator.of(context).push(MaterialPageRoute(
            //                     builder: (context) => ProfileScreen(
            //                         stdrecords: student,
            //                         index: index,
            //                         id: student.id),
            //                   ));
            //                 },
            //                 leading: CircleAvatar(
            //                   backgroundImage: FileImage(File(student.profile)),
            //                 ),
            //                 title: Text(studentList[index].name),
            //                 trailing: IconButton(
            //                   onPressed: () {
            //                     StudentHelper().deleteStudent(student.id);
            //                   },
            //                   icon: const Icon(Icons.close),
            //                 ));
            //           });
                
            //   ,
            
            // )
          ],
        ),
      );
    
  }

  onSearch(String value) {
    final studentList = studentBox.values.toList();
    value = searchController.text;
    if (debouncer?.isActive ?? false) debouncer?.cancel();
    debouncer = Timer(const Duration(milliseconds: 500), () {
      if (searchtext != searchController) {
        setState(() {
          final searchStudent = studentList.where((std) =>
                std.name.toLowerCase().contains(value.toLowerCase())).toList();
        //  stdList.value = searchStudent;
        });
      }
    });
  }
}
