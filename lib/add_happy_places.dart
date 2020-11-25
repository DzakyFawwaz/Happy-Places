import 'dart:io';
import 'dart:ui';

import 'package:belajar/place_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'class_penangkap.dart';
import 'search_location.dart';

class AddHappyPlaces extends StatefulWidget {
  final ClassPenangkap places;

  AddHappyPlaces(this.places);

  @override
  _AddHappyPlacesState createState() => _AddHappyPlacesState(this.places);
}

class _AddHappyPlacesState extends State<AddHappyPlaces> {
  _AddHappyPlacesState(this.places);

  String dateFormate = DateFormat("dd-MM-yyyy").format(DateTime.now());
  final DateFormat formatter = DateFormat("dd-MM-yyyy");
  Map<int, File> imageFileMap = {};
  ClassPenangkap places;

  TextEditingController _controllerDate = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();
  TextEditingController _controllerLocation = TextEditingController();
  TextEditingController _controllerTitle = TextEditingController();
  DateTime _dateTime;
  File _image;

  @override
  void dispose() {
    _controllerLocation.dispose();
    super.dispose();
  }

  Future<File> _getPictureFromCamera() async {
    var image = File(await ImagePicker()
        .getImage(source: ImageSource.camera)
        .then((pickedFile) => pickedFile.path));

    setState(() {
      _image = image;
    });
  }

  Future<File> _getPictureFromGallery() async {
    var image = File(await ImagePicker()
        .getImage(source: ImageSource.gallery)
        .then((pickedFile) => pickedFile.path));

    setState(() {
      _image = image;
    });
  }

  AlertDialog ShowAlertDialog() {
    return AlertDialog(
      actions: [
        FlatButton(
            onPressed: () => _getPictureFromCamera(),
            child: Text('Open Camera')),
        FlatButton(
            onPressed: () => _getPictureFromGallery(),
            child: Text('Open Gallery'))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (places != null) {
      _controllerTitle.text = places.title;
      _controllerDescription.text = places.deskripsi;
      _controllerDate.text = places.date;
      _controllerLocation.text = places.location;
    }
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    DateTime _dateTime;
    String dateFormate = DateFormat("dd-MM-yyyy").format(DateTime.now());
    final DateFormat formatter = DateFormat("dd-MM-yyyy");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: places == null
            ? Text('Add Happy Places')
            : Text('Edit Happy Places'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextFormField(
              controller: _controllerTitle,
              decoration: InputDecoration(
                  hintText: 'Title',
                  labelText: 'Title',
                  hintStyle: TextStyle(color: Colors.grey),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            TextFormField(
                controller: _controllerDescription,
                decoration: InputDecoration(
                    hintText: 'Description',
                    labelText: 'Description',
                    hintStyle: TextStyle(color: Colors.grey),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)))),
            TextFormField(
                controller: _controllerDate,
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                        onTap: () => showDatePicker(
                                    context: context,
                                    initialDate: _dateTime == null
                                        ? DateTime.now()
                                        : _dateTime,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2021))
                                .then((value) {
                              final String formatted = formatter.format(value);

                              dateFormate = formatted.toString();
                            }),
                        child: Icon(Icons.access_alarm)),
                    hintText: dateFormate,
                    // labelText: dateFormate,
                    hintStyle: TextStyle(color: Colors.grey),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)))),
            TextFormField(
                onTap: () async {
                  final sessionToken = Uuid().v4();

                  final Suggestion result = await showSearch(
                    context: context,
                    delegate: AddressSearch(sessionToken),
                  );
                  if (result != null) {
                    setState(() {
                      _controllerLocation.text = result.description;
                    });
                  }
                },
                
                controller: _controllerLocation,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
                    hintText: 'Location',
                    labelText: 'Location',
                    hintStyle: TextStyle(color: Colors.grey),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  child: _image == null
                      ? Center(child: Icon(Icons.image))
                      : Image.file(_image),
                ),
                Center(
                    child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => ShowAlertDialog(),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 40),
                    child: Text(
                      'ADD IMAGE',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ))
              ],
            ),
            Container(
              width: width,
              height: 50,
              child: RaisedButton(
                child: Text('Save',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
                onPressed: () {
                  if (places == null) {
                    places = ClassPenangkap(
                      _controllerTitle.text,
                      _controllerDescription.text,
                      _controllerDate.text,
                      _controllerLocation.text,
                      // _image.toString()
                    );
                  } else {
                    places.title = _controllerTitle.text;
                    places.deskripsi = _controllerDescription.text;
                    places.date = _controllerDate.text;
                    places.location = _controllerLocation.text;
                    places.image = _image.toString();
                  }

                  Navigator.pop(context, places);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
