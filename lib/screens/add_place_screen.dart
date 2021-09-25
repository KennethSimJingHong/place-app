import 'dart:io';

import 'package:flutter/material.dart';
import 'package:place_app/constant.dart';
import 'package:place_app/models/place.dart';
import 'package:place_app/providers/places.dart';
import 'package:place_app/widgets/image_input.dart';
import 'package:place_app/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
  static const routeName = "/add_place";
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  File _pickedImage;
  Location _pickedLocation;
  void _selectImage(File pickImage){
    _pickedImage = pickImage;
  }

  void _selectPlace(double lat, double lng){
    _pickedLocation = Location(latitude: lat, longitude: lng);
  }

  void _savePlace(){
    if(_titleController.text.isEmpty || _descController.text.isEmpty || _pickedImage == null || _pickedLocation == null){
      return;
    }
    Provider.of<Places>(context, listen: false).addPlace(_titleController.text, _descController.text, _pickedImage, _pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Add New Place",
          style: TextStyle(
            fontFamily: "PatuaOne",
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed:_savePlace,
          )
        ],
        backgroundColor: kGreenHighColor,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children:[
                      TextField(
                        decoration: InputDecoration(labelText: "Title"),
                        controller: _titleController,
                      ),
                      SizedBox(height:10),
                      TextField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black)),
                          hintText: "Thing to notes down..."
                        ),
                        controller: _descController,
                      ),
                      SizedBox(height:10),
                      ImageInput(_selectImage),
                      SizedBox(height:10),
                      LocationInput(_selectPlace),
                    ]
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}