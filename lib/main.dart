import 'package:crud_using_firebase/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized(); // Very Important thing to Bind Project with Firebase
  //For Web app support
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDpsyy0u5XB-df5JXcJ7ZKjs0o47lkGpGY",
        appId: "1:384011803423:web:b26bf2060df58578ec6e2a",
        messagingSenderId: "384011803423",
        projectId: "flutter-crud-ab3f6")
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final Future<FirebaseApp> _initialization = Firebase.initializeApp(); // for Firebase use

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future : _initialization,
      builder: (context, snapshot){
        // Check For Errors

        if(snapshot.hasError){
          print("Something Went Wrong");
        }
        // once completed show your application
        if(snapshot.connectionState == ConnectionState.done){
          return MaterialApp(
            title: 'Flutter FireStore CRUD',
            theme: ThemeData(

              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home: const HomePage(),
          );
        }
        return const CircularProgressIndicator();
      },
    );

  }
}

