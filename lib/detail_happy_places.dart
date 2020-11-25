import 'dart:io';

import 'class_penangkap.dart';
import 'package:flutter/material.dart';

class DetailHappyPlaces extends StatelessWidget {
  ClassPenangkap places;
  DetailHappyPlaces(this.places);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(label: Text('See on Maps', style: TextStyle(letterSpacing: 0),), onPressed: (){},),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: false,
            floating: true,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back)),
            title: Text(places.title),
            flexibleSpace: Container(
              color: Colors.grey,
              height: height / 3,
              child: (places.image == null)
                  ? Center(
                      child: Icon(Icons.image, color: Colors.white),
                    )
                  : Text('The data is available')
              // FileImage(File(places.image))
              ),
          ),
          SliverFillRemaining(
            child: Container(
            width: width,
            height: height,
            padding: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                
                Row(
                  children: [
                    Icon(Icons.location_pin, color: Colors.blue),
                    Text(places.location,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.blue)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(places.date,
                    style: TextStyle(
                        fontSize: 12.5, fontWeight: FontWeight.normal, color: Colors.grey)),
                SizedBox(
                  height: 25,
                ),
                Text(places.deskripsi),
              ],
            ),
          )
          )],
      ),
         
      
      // Column(
      //   children: [
          // Container(
          //     color: Colors.grey,
          //     height: height / 3,
          //     child: (places.image == null)
          //         ? Center(
          //             child: Icon(Icons.image, color: Colors.white),
          //           )
          //         : Text('The data is available')
          //     // FileImage(File(places.image))
          //     ),
      //     Container(
      //       width: width,
      //       padding: EdgeInsets.only(left: 10),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           SizedBox(
      //             height: 20,
      //           ),
      //           Text(
      //             places.title,
      //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //           ),
      //           SizedBox(
      //             height: 15,
      //           ),
      //           Row(
      //             children: [
      //               Icon(Icons.location_pin, color: Colors.blue),
      //               Text(places.location,
      //                   style: TextStyle(
      //                       fontSize: 14,
      //                       fontWeight: FontWeight.normal,
      //                       color: Colors.blue)),
      //             ],
      //           ),
      //           SizedBox(
      //             height: 10,
      //           ),
      //           Text(places.date,
      //               style: TextStyle(
      //                   fontSize: 12.5, fontWeight: FontWeight.normal)),
      //           SizedBox(
      //             height: 25,
      //           ),
      //           Text(places.deskripsi)
      //         ],
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
