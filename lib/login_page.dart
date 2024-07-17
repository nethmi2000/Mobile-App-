import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_login/log.dart';
import 'package:my_login/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;
  bool _loading = false;

  Future<void> _login() async {
    setState(() {
      _loading = true;
    });

    final url = Uri.parse("http://3.142.126.252:90/api/Auth/login");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json-patch+json"},
      body: jsonEncode({
        "UserName": emailController.text,
        "Password": passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      // Login successful, navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    } else {
      // Login failed, show an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Login Failed"),
            content: Text("Invalid username or password"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }

    setState(() {
      _loading = false;
    });
  }

  void _navigateToregisterpage() {
    // Navigate to the RegisterPage
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: myColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/download.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(top: 80, child: _buildTop()),
          Positioned(bottom: 0, child: _buildBottom()),
        ],
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "HELLO STUDENT!",
              style: TextStyle(
                color: Color.fromARGB(255, 189, 33, 137),
                fontWeight: FontWeight.bold,
                fontSize: 50,
                letterSpacing: 2,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      color: Color.fromARGB(255, 191, 238, 130),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome",
            style: TextStyle(
              color: Color.fromARGB(255, 3, 136, 7),
              fontSize: 48,
              fontWeight: FontWeight.w700,
            ),
          ),
          _buildGreyText("Please login with your information"),
          const SizedBox(
            height: 50,
          ),
          _buildGreyText("Email address"),
          _buildInputField(emailController),
          const SizedBox(height: 40),
          _buildGreyText("Password"),
          _buildInputField(passwordController, isPassword: true),
          const SizedBox(height: 15),
          // _buildRememberForgot(),
          const SizedBox(height: 15),
          _buildLoginButton(),
          const SizedBox(height: 15),
          _buildOtherLogin(),
          const SizedBox(height: 15),
          _buildregisterButton(), // Added register button
        ],
      ),
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Color.fromARGB(255, 51, 77, 4)),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? const Icon(Icons.remove_red_eye)
            : const Icon(Icons.done),
      ),
      obscureText: isPassword,
    );
  }

  // Widget _buildRememberForgot() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Row(
  //         children: [
  //           Checkbox(
  //               value: rememberUser,
  //               onChanged: (value) {
  //                 setState(() {
  //                   rememberUser = value!;
  //                 });
  //               }),
  //           _buildGreyText("Remember me"),
  //         ],
  //       ),
  //       TextButton(
  //           onPressed: () {}, child: _buildGreyText("I forgot my password"))
  //     ],
  //   );
  // }

  Widget _buildLoginButton() {
    return _loading
        ? CircularProgressIndicator() // Show loading indicator when waiting
        : ElevatedButton(
            onPressed: _login,
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              elevation: 20,
              shadowColor: myColor,
              minimumSize: const Size.fromHeight(60),
            ),
            child: const Text("LOGIN"),
          );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          _buildGreyText("Or Login with"),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // children: [
            //   Tab(icon: Image.asset("assets/images/facebook.png")),
            //   Tab(icon: Image.asset("assets/images/google.png")),
            // ],
          )
        ],
      ),
    );
  }

  Widget _buildregisterButton() {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: _navigateToregisterpage,
        child: Text(
          "Register",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class registerpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: Text('Register Page'),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        automaticallyImplyLeading: false, // Hide the back button
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the Home Page!'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
