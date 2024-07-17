import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.lightGreen,
                  Colors.teal,
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text('Hello Friends!',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: const Color.fromARGB(255, 0, 0, 0))),
                  subtitle: Text('DASHBOARD',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(color: Color.fromARGB(255, 94, 78, 7))),
                  trailing: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/hello.jpg'),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            color: Colors.teal,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 62, 188, 192),
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(200))),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  itemDashboard('Videos', CupertinoIcons.play_rectangle,
                      const Color.fromARGB(255, 255, 255, 255)),
                  itemDashboard('Analytics', CupertinoIcons.graph_circle,
                      Color.fromARGB(255, 255, 255, 255)),
                  itemDashboard('Audience', CupertinoIcons.person_2,
                      const Color.fromARGB(255, 255, 255, 255)),
                  itemDashboard('Comments', CupertinoIcons.chat_bubble_2,
                      const Color.fromARGB(255, 255, 255, 255)),
                  itemDashboard('Revenue', CupertinoIcons.money_dollar_circle,
                      Color.fromARGB(255, 255, 255, 255)),
                  itemDashboard('Upload', CupertinoIcons.add_circled,
                      const Color.fromARGB(255, 255, 255, 255)),
                  itemDashboard('About', CupertinoIcons.question_circle,
                      const Color.fromARGB(255, 255, 255, 255)),
                  itemDashboard('Contact', CupertinoIcons.phone,
                      const Color.fromARGB(255, 255, 255, 255)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  Widget itemDashboard(String title, IconData iconData, Color background) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 78, 179, 120),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: Color.fromARGB(255, 1, 24, 15)),
          ),
          const SizedBox(height: 8),
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}
