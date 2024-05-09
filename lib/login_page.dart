import 'package:flutter/material.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleRememberMe() {
    setState(() {
      _rememberMe = !_rememberMe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [


              SizedBox(height: 50,),
              Align(
                alignment: Alignment.topLeft,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/picture2-removebg-preview.png', // Change this to your image path
                      width: 150, // Adjust width as needed
                      height: 150, // Adjust height as needed
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Text(
                          'Welcome! 👋',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Text(
                          'Please sign in to your account',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )

                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                ),
              ),
              SizedBox(height: 20,),

              Padding(
                padding: EdgeInsets.all(3),
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(),

                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),

                        labelText: 'Password',
                      ),
                    ),
                    SizedBox(height: 5.0),

                ],
              )),



              SizedBox(height: 20.0),
              Container(

                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), // Adjust as needed
                  gradient: LinearGradient(
                    colors: [Colors.purple, Colors.blue],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    print("email: ${_emailController.text}");
                    print("email: ${_passwordController.text}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );


                    // Add your button onPressed functionality here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),


                  ),
                  child: Text(
                    'Connect',
                    style: TextStyle(
                      color: Colors.white, // Adjust text color here
                      fontSize: 16.0, // Adjust text size here
                    ),
                  ),
                )
              ),
              SizedBox(height: 35,),

              Image.asset(
                'assets/sous-login.png', // Change this to your image path
              ),


            ],
          ),
        ),
      ),
    );
  }
}
