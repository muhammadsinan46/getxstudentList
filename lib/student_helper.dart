// ignore_for_file: list_remove_unrelated_type

import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:studentrecords/main.dart';
import 'package:studentrecords/student_model.dart';

List<String> gendrList = ["Male", "Female", "Other"];
List<String> domainList = [
  "Flutter",
  "MERN",
  "Python-Djngo",
  "Cyber Security",
  "Data Science",
  "Machine Learning",
  "Java",
  "GO-lang"
];

class StudentHelper extends GetxController {
  RxList stdList = [].obs;

  RxString? gen=''.obs;
  RxString? dom=''.obs;
  RxString? searchText=''.obs;
  RxString? proImage=''.obs;

  getSearch(String sText) {
    searchText!.value = sText;
    getStudentList();
  }

  getDomain(String domain) {
    dom!.value = domain;

    refresh();
  }

  getImage(File profile) async {
    final profileImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    File imagePath = File(profileImage!.path);
 proImage!.value =imagePath.toString();
  }

  getGender(String gender) {
    gen!.value = gender;
  }

  deleteStudent(int id) async {
    final studentBox = await Hive.openBox<Student>(hiveStudent);
    studentBox.delete(id);
    getStudentList();
  }

  getStudentList() async {
    final studentBox = await Hive.openBox<Student>(hiveStudent);
    final newList = List<Student>.from(studentBox.values);
    stdList.value = newList;
    stdList.refresh();
  }

  onSave(Student value) async {
    final saveBox = await Hive.openBox<Student>(hiveStudent);
    stdList.clear();
    final id = await saveBox.add(value);
    final data = saveBox.get(id);

    await saveBox.put(
        id,
        Student(data!.name, data.age, data.gender, data.batch, data.profile,
            data.email, id));
    stdList.addAll(saveBox.values);
    stdList.refresh();
  }
}
