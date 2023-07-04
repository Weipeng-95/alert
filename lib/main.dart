// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a blue toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme:
//             ColorScheme.fromSeed(seedColor: Color.fromARGB(1, 100, 200, 1)),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'OpenOlat Login Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'OpenOlat Login Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;
//
//   @override
//   MyHomePageState createState() => MyHomePageState();
// }
//
// class MyHomePageState extends State<MyHomePage> {
//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   String? sessionCookie;
//
//   Future<void> attemptLogin() async {
//     final response = await http.post(
//       Uri.parse(
//           'https://olat.vcrp.de/auth'), // Replace with your OpenOlat auth URL
//       body: {
//         'username': usernameController.text,
//         'password': passwordController.text,
//       },
//     );
//
//     if (response.statusCode == 200) {
//       sessionCookie = response.headers['set-cookie'];
//     } else {
//       throw Exception('Failed to login');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               controller: usernameController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Username',
//               ),
//             ),
//             TextField(
//               controller: passwordController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Password',
//               ),
//               obscureText: true,
//             ),
//             ElevatedButton(
//               onPressed: attemptLogin,
//               child: Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// void main() async {
//   var username = 'weipeng';
//   var password = 'Ww123123';
//   var credentials =
//       const Base64Encoder().convert('$username:$password'.codeUnits);
//
//   var response = await http.get(
//     Uri.parse(
//         'https://olat.vcrp.de/restapi/users/4203216959?withPortrait=false'),
//     headers: {'Authorization': 'Basic $credentials'},
//   );
//
//   if (response.statusCode == 200) {
//     print('User info: ${response.body}');
//   } else {
//     print('Request failed with status: ${response.statusCode}.');
//   }
// }

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'UserInfoPage.dart';
import 'package:xml/xml.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromRGBO(237, 108, 54, 1)),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('OpenOlat Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String? _token; // Add this line to hold the token

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      var credentials =
          const Base64Encoder().convert('$_username:$_password'.codeUnits);

      var response = await http.get(
        Uri.parse(
            'https://olat.vcrp.de/restapi/users/4203216959?withPortrait=false'),
        headers: {'Authorization': 'Basic $credentials'},
      );

      if (response.statusCode == 200) {
        final XmlDocument xmlDocument = XmlDocument.parse(response.body);
        final XmlElement userElement = xmlDocument.rootElement;
        final String identityKey =
            userElement.getElement('key')?.innerText ?? '';
        final String firstName =
            userElement.getElement('firstName')?.innerText ?? '';
        final String lastName =
            userElement.getElement('lastName')?.innerText ?? '';
        final String email = userElement.getElement('email')?.innerText ?? '';

        // print('First Name: $firstName');
        // print('Last Name: $lastName');
        // print('Email: $email');

        print('User info: ${response.body}');
        if (response.headers.containsKey('x-olat-token')) {
          // Add these lines to extract the token
          _token = response.headers['x-olat-token'];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserInfoPage(
                identityKey: int.parse(identityKey),
                firstName: firstName,
                lastName: lastName,
                email: email,
              ),
            ),
          );

          print('X-OLAT-TOKEN: $_token');
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Username'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
            onSaved: (value) {
              _username = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            onSaved: (value) {
              _password = value!;
            },
            obscureText: true,
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            child: Text('Login'),
            onPressed: _submitForm,
          ),
        ],
      ),
    );
  }
}
