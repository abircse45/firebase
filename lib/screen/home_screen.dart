
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widget/get_name.dart';


class HomeSCreen extends StatefulWidget {
  const HomeSCreen({Key? key}) : super(key: key);

  @override
  State<HomeSCreen> createState() => _HomeSCreenState();
}

class _HomeSCreenState extends State<HomeSCreen> {


  final userdata = FirebaseAuth.instance.currentUser;


  List<String> documentInformation = [];

  Future  getDocumentdata()async{
    await FirebaseFirestore.instance.collection("users").get().then((docdata) {
      docdata.docs.forEach((element) {
        documentInformation.add(element.reference.id);
      });
      setState(() {

      });
    });
  }

  @override
  void initState() {

    getDocumentdata();
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Home"),
      ),

      body: ListView.builder(
        itemCount: documentInformation.length,
        itemBuilder: (_,index){
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: ListTile(
                title: GetName(
                  collectionId:documentInformation[index],
                )
            ),
          );
        },
      ),
    );
  }
}
