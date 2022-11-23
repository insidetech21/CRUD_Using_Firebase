import 'package:flutter/material.dart';

import 'add_student_page.dart';
import 'list_student_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Flutter FireStore CRUD'),
            ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddStudentPage(),
                      ),
                  )
                },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
              child: const Text('Add', style: TextStyle(fontSize: 20.0)
              ),
            )
          ],
        ),
      ),
      body: const ListStudentPage(),
    );
  }
}
