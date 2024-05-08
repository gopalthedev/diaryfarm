import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diaryfarm/addnew.dart';
import 'package:diaryfarm/models/boxModel.dart';
import 'package:diaryfarm/shelterdata.dart';
import 'package:diaryfarm/utils/systemValues.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<QueryDocumentSnapshot> cowsList = [];

  Future getCows() async {
    try{
      await FirebaseFirestore.instance.collection('Cows').get().then((value) {
        List<QueryDocumentSnapshot> temp = [];
        print(value.size);
        for (QueryDocumentSnapshot i in value.docs) {
          temp.add(i);
        }
        setState(() {
          cowsList = temp;
        });
        print(cowsList);
      });
    }
    catch(e){
      print("Error is $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCows();
    getShelterData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:customAppBar(title: "DairyFarm"),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddCow(callBack: (){getCows();},),));
      }, child: Icon(Icons.add),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return BoxModel(
                        name: cowsList[index].get('name'),
                        status: cowsList[index].get('status'),
                        docId: cowsList[index].id,);
                  },
                  itemCount: cowsList.length,
                )
              ],
          ),
        ),
      ),
    );
  }
}
