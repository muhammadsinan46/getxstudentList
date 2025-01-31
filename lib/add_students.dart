
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:studentrecords/student_helper.dart';
import 'package:studentrecords/student_model.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var ageController = TextEditingController();
    var emailController = TextEditingController();
    StudentHelper controller = Get.put(StudentHelper());
    return Scaffold(
      appBar: AppBar(),
      body:SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  height: 200,
                  width: 200,
                  child: Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () async {
                        
                      },
                      child: Container(
                        decoration: BoxDecoration(border: Border.all()),
                        height: 150,
                        width: 150,
                        child:
                          controller.proImage!=null
                         
                            ? Image.file(
                                File(controller.proImage.toString()),
                                fit: BoxFit.fill,
                              )
                            : const Icon(
                                Icons.person_add,
                                size: 70,
                              ),
                      ),
                    ),
                  ),
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: 'full name',
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1, color: Color.fromRGBO(53, 136, 200, 1)),
                          borderRadius: BorderRadius.circular(10.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0))),
                ),
                const SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: ageController,
                  decoration: InputDecoration(
                      hintText: 'age',
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1, color: Color.fromRGBO(53, 136, 200, 1)),
                          borderRadius: BorderRadius.circular(10.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0))),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "gender",
                        style: TextStyle(fontSize: 18),
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10.0)),
                  height: 180,
                  width: double.maxFinite,
                  child: ListView.builder(
                      itemCount: gendrList.length,
                      itemBuilder: (context, index) {
                        return RadioListTile(
                          title: Text(gendrList[index]),
                          value: gendrList[index],
                          groupValue: controller.gen,
                          onChanged: (value) {
                            controller.getGender(value!.toString());
                          },
                        );
                      }),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                        hintText: 'domain',
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1,
                                color: Color.fromRGBO(53, 136, 200, 1)),
                            borderRadius: BorderRadius.circular(10.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(10.0))),
                    items: domainList.map((String domain) {
                      return DropdownMenuItem(
                          value: domain, child: Text(domain));
                    }).toList(),
                    onChanged: (String? domain) {
                      controller.getDomain(domain!);
                    }),
                const SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: 'email',
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0))),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                    onPressed: () {
                      addToList(
                          name: nameController.text,
                          age: ageController.text,
                          gender: controller.gen.toString(),
                          batch: controller.dom.toString(),
                          email: emailController.text,
                          profile: controller.proImage.toString());
                           controller.proImage =null;
                      Navigator.of(context).pop();
                    },
                    child: const Text("Save"))
              ],
            ),
          ),
        ),
      );
  
  }

  addToList({
    required String name,
    required String age,
    required String gender,
    required String batch,
    required String profile,
    required String email,
  }) async {
    final value = Student(name, age, gender, batch, profile, email, -1);
    await StudentHelper().onSave(value);
  }
}
