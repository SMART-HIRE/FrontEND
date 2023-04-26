// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';

class HR_ques extends StatefulWidget {
  const HR_ques({Key? key}) : super(key: key);

  @override
  State<HR_ques> createState() => _MyHomePageState();
}

FirebaseStorage storage = FirebaseStorage.instance;

class _MyHomePageState extends State<HR_ques> {
  final Map<String, List<String>> selectedValues = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HR REQ PAGE"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            DropdownSearch<String>.multiSelection(
              mode: Mode.MENU,
              showSelectedItems: true,
              items: ["HTML", "CSS", "Python", "Java", "C++", "C", "SQL"],
              dropdownSearchDecoration: InputDecoration(
                labelText: "Skills",
                hintText: "Select multiple skills",
              ),
              popupItemDisabled: isItemDisabled,
              onChanged: (List<String> s) => addSelectedValues("Skills", s),
              selectedItems: [],
            ),
            SizedBox(
              height: 20,
            ),
            DropdownSearch(
              mode: Mode.DIALOG,
              items: ["BTECH", "MTECH", "MBA", "MCA"],
              dropdownSearchDecoration:
                  InputDecoration(labelText: "Qualification"),
              onChanged: (String? s) => addSelectedValue("Qualification", s),
              selectedItem: "BTECH",
              validator: (String? item) {
                if (item == null)
                  return "Required field";
                else if (item == "Brazil")
                  return "Invalid item";
                else
                  return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Text("Create JSON"),
              onPressed: () async {
                String jsonStr = json.encode(selectedValues);
                print(jsonStr);
                final bytes = utf8.encode(jsonStr);
                final fileName = 'HR/hr.json';
                final reference = storage.ref().child(fileName);
                await reference.putString(jsonStr);
                String successMessage = "Upload successful.";
                print(successMessage);
                ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                content: Text(successMessage),
                ),
              );
              },
            ),
          ],
        ),
      ),
    );
  }

  bool isItemDisabled(String s) {
    //return s.startsWith('I');

    if (s.startsWith('I')) {
      return true;
    } else {
      return false;
    }
  }

  void addSelectedValue(String key, String? value) {
    if (value != null) {
      selectedValues[key] = [value];
    } else {
      selectedValues.remove(key);
    }
  }

  void addSelectedValues(String key, List<String> values) {
    if (values.isNotEmpty) {
      selectedValues[key] = values;
    } else {
      selectedValues.remove(key);
    }
  }
}
