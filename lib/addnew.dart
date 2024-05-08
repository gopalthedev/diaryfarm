import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diaryfarm/utils/systemValues.dart';
import 'package:flutter/material.dart';

class AddCow extends StatefulWidget {
  const AddCow({super.key, required this.callBack});
 final Function callBack;
  @override
  State<AddCow> createState() => _AddCowState();
}

class _AddCowState extends State<AddCow> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  bool checkFields() {
    if (_nameController.value.text != "" &&
        _statusController.value.text != "" &&
        _ageController.value.text != "" &&
        _breedController.value.text != "") {
      return true;
    }

    return false;
  }

  Future<void> addCow() async {
    print("Method is called");
    if (checkFields()) {
      try {
        await FirebaseFirestore.instance.collection("Cows").add({
          'name': _nameController.value.text,
          'age': _ageController.value.text,
          'status': _statusController.value.text,
          'breed': _breedController.value.text,
          'milk' : []
        }).then((value) => {
              showSnack("Cow has been added successfully", context),
              _nameController.clear(),
              _breedController.clear(),
              _ageController.clear(),
              _ageController.clear(),
          setState(() {
            widget.callBack;
          }),
          Navigator.pop(context)
            });
      } catch (e) {
        print("This is the error occurred $e");
        showSnack(e.toString(), context);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            "Enter all the fields",
            style: TextStyle(
                fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 5,
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Add new cow"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 1)),
              ),
              autocorrect: true,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              controller: _nameController,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Age",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 1)),
              ),
              autocorrect: true,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              controller: _ageController,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Breed",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 1)),
              ),
              autocorrect: true,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              controller: _breedController,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Current Status",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 1)),
              ),
              autocorrect: true,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              controller: _statusController,
            ),
            const SizedBox(
              height: 10,
            ),
            MaterialButton(
              onPressed: addCow,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green.shade300,
                    borderRadius: BorderRadius.circular(16)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text("Add",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
