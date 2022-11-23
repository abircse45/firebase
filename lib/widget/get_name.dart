import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetName extends StatefulWidget {

  final String ? collectionId;
  const GetName({Key? key, this.collectionId}) : super(key: key);

  @override
  State<GetName> createState() => _GetNameState();
}

class _GetNameState extends State<GetName> {
  CollectionReference  _collectionRefrence = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {

    return Container(
      child: FutureBuilder<DocumentSnapshot?>(
        future:_collectionRefrence.doc(widget.collectionId).get(),
        builder: (context,snapshot){
          if(snapshot.connectionState== ConnectionState.done){
            Map<String,dynamic> data = snapshot.data!.data()as Map<String,dynamic>;
            return Card(
              elevation: 10,

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${data["first_name"]}"),
                ));
          }else{
            return Center(child: CircularProgressIndicator(),);
          }

        },

      ),
    );
  }
}
