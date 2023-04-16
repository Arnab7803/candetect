import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:gfgprojects/screens/signin.dart';
import '../functions/auth_functions.dart';
import 'Result.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    CameraScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.deepOrangeAccent,
        backgroundColor: Colors.amberAccent,
        items: <Widget>[
          Icon(Icons.camera_alt, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class CameraScreen extends StatefulWidget {
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image;

  int totalScans = 0;
  int malignantScans = 0;
  int benignScans = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue,
            Colors.purple,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Text(
            'Take Image From Device Camera:',
            style: TextStyle(
              fontFamily: GoogleFonts.openSansCondensed().fontFamily,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              // Open the device camera
              final camimage =
                  await ImagePicker().getImage(source: ImageSource.camera);
              setState(() {
                _image = File(camimage!.path);
              });
              totalScans++;
              Navigator.pushNamed(context, ProcessPage.routeName,
                  arguments: _image);
            },
            child: Text('Open Camera'),
          ),
          SizedBox(height: 100),
          Text(
            'Select Image From Device Gallery:',
            style: TextStyle(
              fontFamily: GoogleFonts.openSansCondensed().fontFamily,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              // Open the device gallery
              final galimage =
                  await ImagePicker().getImage(source: ImageSource.gallery);
              _image = File(galimage!.path);
              totalScans++;
              Navigator.pushNamed(context, ProcessPage.routeName,
                  arguments: _image);
            },
            child: Text('Open Gallery'),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profiles'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              final Map<String, dynamic> data =
                  documents[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['firstName'] + ' ' + data['lastName']),
                subtitle: Text(data['email']),
              );
            },
          );
        },
      ),
      floatingActionButton: GestureDetector(
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            AuthServices.signinUser(email, password, context);
            Navigator.pushNamed(context, HomePage.routeName);
          }
        },
        child: FloatingActionButton(
          onPressed: () => SignInPage.routeName,
          child: Icon(Icons.add),
          backgroundColor: Colors.grey,
        ),
      ),
    );
  }
}
