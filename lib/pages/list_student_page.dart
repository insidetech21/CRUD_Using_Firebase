import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_using_firebase/pages/update_student_page.dart';
import 'package:flutter/material.dart';

class ListStudentPage extends StatefulWidget {
  const ListStudentPage({Key? key}) : super(key: key);

  @override
  State<ListStudentPage> createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {

  final Stream<QuerySnapshot> studentStream = FirebaseFirestore.
  instance.collection('students').snapshots();

  // For Deleting USer
  CollectionReference students =
  FirebaseFirestore.instance.collection('students');


    Future<void> deleteUser(id)
    {
      //print("User Deleted $id");
      return students
          .doc(id)
          .delete()
          .then((value) => print('User Deleted'))
      .catchError((error) => print('Failed to Delete User: $error'));
    }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(stream: studentStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>
    snapshot){
      if(snapshot.hasError){
        print('Something went wrong');
      }
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      final List storedocs = [];
      snapshot.data!.docs.map((DocumentSnapshot document) {
        Map a = document.data() as Map<String, dynamic>;
        storedocs.add(a);
        a['id'] = document.id;
        //print(document.id);
        //print(storedocs);
      }).toList();
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Table(
            border: TableBorder.all(),
            columnWidths: const <int, TableColumnWidth>{
              //2: FixedColumnWidth(96),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Container(
                      color: Colors.green,
                      child: const Center(
                        child: Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      color: Colors.green,
                      child: const Center(
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      color: Colors.green,
                      child: const Center(
                        child: Text(
                          'Action',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              for (var i=0; i< storedocs.length; i++)...[
              TableRow(
                children: [
                  TableCell(
                    child: Center(
                      child: Text(
                        storedocs[i]['Name'],
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  TableCell(
                    child: Center(
                      child: Text(
                        storedocs[i]['Email'],
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  TableCell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(onPressed: () => {
                          Navigator.push(
                            context, MaterialPageRoute(
                            builder:(context) =>
                            UpdateStudentPage(id: storedocs[i]['id']),
                          ),
                          )
                        },
                          icon: const Icon(
                            Icons.edit_rounded,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                        onPressed: () => {
                          deleteUser(storedocs[i]['id'])
                          //deleteUser(1)
                        },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ]
            ],
          ),
        ),
      );
    },
    );
    

  }
}
