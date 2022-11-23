import 'package:crud_using_firebase/pages/update_student_page.dart';
import 'package:flutter/material.dart';

class ListStudentPage extends StatefulWidget {
  const ListStudentPage({Key? key}) : super(key: key);

  @override
  State<ListStudentPage> createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {

  deleteUser(id){
    print("User Deleted $id");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Table(
          border: TableBorder.all(),
          columnWidths: const <int, TableColumnWidth>{
            //1: FixedColumnWidth(200),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                TableCell(
                    child: Container(
                      color: Colors.greenAccent,
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
                    color: Colors.greenAccent,
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
                    color: Colors.greenAccent,
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
            TableRow(
              children: [
                const TableCell(
                    child: Center(
                      child: Text(
                        'Vasant Basutkar',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ),

                const TableCell(
                  child: Center(
                    child: Text(
                      'Vasantbasutkar143@gmail.com',
                      style: TextStyle(
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
                              builder:(context) => const UpdateStudentPage(id: '',),
                          ),
                          )
                        },
                          icon: const Icon(
                              Icons.edit,
                              color: Colors.yellow,
                            ),
                        ),
                        IconButton(onPressed: () => {
                          deleteUser(1)
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

          ],
        ),
      ),
    );
  }
}
