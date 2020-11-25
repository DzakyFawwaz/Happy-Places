import 'dart:io';

import 'package:belajar/crud.dart';
import 'package:flutter/material.dart';

import 'add_happy_places.dart';
import 'class_penangkap.dart';
import 'detail_happy_places.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CRUD dbHelper = CRUD();
  Future<List<ClassPenangkap>> future;
  @override
  void initState() {
    super.initState();
    updateListView();
  }

  void updateListView() {
    setState(() {
      future = dbHelper.getContactList();
    });
  }

  Future<ClassPenangkap> navigateToEntryForm(
      BuildContext context, ClassPenangkap places) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return AddHappyPlaces(places);
    }));
    return result;
  }

   Future<ClassPenangkap> navigateToDetail(
      BuildContext context, ClassPenangkap places) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return DetailHappyPlaces(places);
    }));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Happy Places'),
      ),
      body: FutureBuilder<List<ClassPenangkap>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
                children: snapshot.data.map((todo) => cardo(todo)).toList());
          } else {
            return Center(child: Text('No Happy Places Available'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Add Happy Places',
        onPressed: () async {
          var contact = await navigateToEntryForm(context, null);
          if (contact != null) {
            int result = await dbHelper.insert(contact);
            if (result > 0) {
              updateListView();
            }
          }
        },
      ),
    );
  }

  Card cardo(ClassPenangkap places) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: Colors.blue, child: Icon(Icons.people_alt)
            // places.image == null ? Container(color: Colors.blue,): Image(image: FileImage(File(places.image)),),
            ),
        title: Text(
          places.title,
        ),
        subtitle: Text(places.deskripsi.toString()),
        trailing: GestureDetector(
          child: Icon(Icons.delete),
          onTap: () async {
            int result = await dbHelper.delete(places);
            if (result > 0) {
              updateListView();
            }
          },
        ),
        onTap: () async {
          var placesDetail = await navigateToDetail(context, places);
          if (placesDetail != null) {
            int result = await dbHelper.update(placesDetail);
            if (result > 0) {
              updateListView();
            }
          }
          // var contact2 = await navigateToEntryForm(context, places);
          // if (contact2 != null) {
          //   int result = await dbHelper.update(contact2);
          //   if (result > 0) {
          //     updateListView();
          //   }
          // }
        },
      ),
    );
  }
}
