// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';

class Json2 extends StatefulWidget {
  @override
  _JsonState createState() => _JsonState();
}

class _JsonState extends State<Json2> {
  late List<dynamic> _items;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final ref =
        firebase_storage.FirebaseStorage.instance.ref().child('shire2.json');
    final url = await ref.getDownloadURL();
    final response = await http.get(Uri.parse(url));
    final jsonList = json.decode(response.body) as List<dynamic>;
    setState(() {
      _items = jsonList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SR Shortlisted Candidates"),
      ),
      body: _items == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index] as List<dynamic>;
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(item: item),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Container(
                          //   width: 50,
                          //   height: 50,
                          //   child: Image.network(
                          //     item[4].toString(),
                          //     fit: BoxFit.fill,
                          //   ),
                          // ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 8, right: 8),
                                    child: Text(
                                      item[1].toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8, right: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item[8].toString(),
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final List<dynamic> item;

  const DetailsPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item[1].toString()),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text('ID'),
              subtitle: Text(item[0].toString()),
            ),
            ListTile(
              title: Text('Education'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List<Widget>.from(
                  item[2].map((e) => Text(e.toString())).toList(),
                ),
              ),
            ),
            ListTile(
              title: Text('Skills'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List<Widget>.from(
                  item[3].map((e) => Text(e.toString())).toList(),
                ),
              ),
            ),
            ListTile(
              title: Text('Phone'),
              subtitle: Text(item[4].toString()),
            ),
            ListTile(
              title: Text('Email'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List<Widget>.from(
                  item[5].map((e) => Text(e.toString())).toList(),
                ),
              ),
            ),
            ListTile(
              title: Text('Github'),
              subtitle: InkWell(
                child: Text(
                  item[6].toString(),
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () => launchUrlString(item[6].toString()),
              ),
            ),
            ListTile(
              title: Text('LinkedIn'),
              subtitle: Text(item[7].toString()),
            ),
            ListTile(
              title: Text('Score'),
              subtitle: item[8] == null
                  ? Text('Not Available')
                  : Text(item[8].toString()),
            ),
          ],
        ),
      ),
    );
  }
}
