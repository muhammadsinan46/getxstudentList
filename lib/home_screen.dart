// ignore_for_file: must_be_immutable


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:studentrecords/add_students.dart';
import 'package:studentrecords/profile_details.dart';
import 'package:studentrecords/search-Screen.dart';
import 'package:studentrecords/student_helper.dart';



class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

StudentHelper controller = Get.put(StudentHelper());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("STUDENTS RECORDS"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const  SearchScreen()));
            },
          )
        ],
      ),
      body: SizedBox(
          child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: controller.stdList.length,
                  itemBuilder: (context, index) {
                    final student = controller.stdList[index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                              stdrecords: student,
                              index: index,
                              id: student.id),
                        ));
                      },
                      child: Card(
                        child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(File(student.profile)),
                            ),
                            title: Text(controller.stdList[index]),
                            subtitle: Text(controller.stdList[index].b),
                            trailing: IconButton(
                              onPressed: () {
                                StudentHelper().deleteStudent(student.id);
                              },
                              icon: const Icon(Icons.delete),
                            )),
                      ),
                    );
                  }))
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 50,
        width: 100,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddStudent()));
          },
          child: const Row(children: [Icon(Icons.add), Text("Add Student")]),
        ),
      ),
    );
  }
}
