import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  String selectedUserRole = 'user'; // Default value for user role

  Future<void> register(BuildContext context) async {
    final Uri apiUrl = Uri.parse('http://3.142.126.252:90/api/Auth/register');

    final Map<String, dynamic> requestData = {
      'UserName': usernameController.text,
      'Password': passwordController.text,
      'Email': emailController.text,
      'DateOfBirth': dobController.text,
      'Address': addressController.text,
      'District': districtController.text,
      'City': cityController.text,
      'UserRole': selectedUserRole, // Updated to use selectedUserRole
      'PhoneNumber': phoneNumberController.text,
      'Name': nameController.text,
    };

    try {
      final http.Response response = await http.post(
        apiUrl,
        body: json.encode(requestData),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        // Registration successful, show success snackbar
        showSnackBar(context, 'Registration successful', true);
      } else {
        // Registration failed, show error snackbar
        showSnackBar(context, 'Registration failed', false);
      }
    } catch (e) {
      // Exception occurred, show error snackbar
      showSnackBar(
          context, 'An error occurred. Please try again later.', false);
      print('Exception: $e');
    }
  }

  void showSnackBar(BuildContext context, String message, bool success) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: success ? Colors.green : Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dobController.text = picked.toString().substring(0, 10);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent, Colors.tealAccent],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Pacifico', // Custom font
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: dobController,
                      decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        suffixIcon: Icon(Icons.calendar_today),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: districtController,
                  decoration: InputDecoration(
                    labelText: 'District',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: cityController,
                  decoration: InputDecoration(
                    labelText: 'City',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedUserRole,
                  onChanged: (value) {
                    setState(() {
                      selectedUserRole = value!;
                    });
                  },
                  items: ['user', 'admin'] // Add more roles if needed
                      .map((role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'User Role',
                    hintText: 'Select User Role',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => register(context), // Pass context here
                  child: Text('Register'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.indigoAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
