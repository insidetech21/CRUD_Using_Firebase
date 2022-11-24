import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateStudentPage extends StatefulWidget {

  final String id;

  const UpdateStudentPage({Key? key, required this.id}) : super(key: key);

  @override
  State<UpdateStudentPage> createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  final _formKey = GlobalKey<FormState>();

  // For Updating USer
  CollectionReference students =
  FirebaseFirestore.instance.collection('students');

  Future<void> updateUser(id, name, email, password)
  {
    //print("User Deleted $id");
    return students
        .doc(id)
        .update({'Name': name, 'Email': email, 'Password': password})
        .then((value) => print('User Updated'))
        .catchError((error) => print('Failed to Update User: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Student"),
      ),
      body: Form(
          key: _formKey,
          // Getting Specific Data by ID
          child:
          FutureBuilder<DocumentSnapshot <Map <String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('students')
                .doc(widget.id)
                .get(),
            builder: (_, snapshot){
              if(snapshot.hasError){
                print('Something went wrong');
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.data();
              var name = data!['Name'];
              var email = data['Email'];
              var password = data['Password'];

              return
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          initialValue: name,
                          autofocus: false,
                          onChanged: (value) => name = value,
                          decoration: const InputDecoration(
                            labelText: 'Name: ',
                            labelStyle: TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(),
                            errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          initialValue: email,
                          autofocus: false,
                          onChanged: (value) => email = value,
                          decoration: const InputDecoration(
                            labelText: 'Email: ',
                            labelStyle: TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(),
                            errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Email';
                            } else if (!value.contains('@')) {
                              return 'Please Enter Valid Email';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          initialValue: password,
                          autofocus: false,
                          onChanged: (value) => password = value,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password: ',
                            labelStyle: TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(),
                            errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Password';
                            }
                            return null;
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, otherwise false.
                              if (_formKey.currentState!.validate()) {
                                updateUser(widget.id, name, email, password);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'Update',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey),
                            child: const Text(
                              'Reset',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );

            },
          )
      ),
  );

  }
}
