import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wit/controller/Auth.dart';
import 'package:wit/typography.dart';

import 'login_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isLoading = false;
  bool isHidden = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authC = Provider.of<Auth>(context);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(25),
          height: size.height,
          width: size.width,
          color: Colors.lightGreen.withOpacity(0.3),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  verticalSpace(height: 60),
                  Text(
                    'SignUp',
                    style: GoogleFonts.lexendDeca(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  verticalSpace(height: 50),
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter password';
                      } else {
                        return null;
                      }
                    },
                  ),
                  verticalSpace(height: 20),
                  TextFormField(
                    obscureText: isHidden,
                    controller: password,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isHidden = !isHidden;
                              });
                            },
                            icon: isHidden
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility)),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter password';
                      } else if (value.length < 6) {
                        return "password should be more than 6 letters";
                      } else {
                        return null;
                      }
                    },
                  ),
                  verticalSpace(height: 20),
                  TextFormField(
                    obscureText: true,
                    controller: confirmPassword,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18))),
                    validator: (value) {
                      if (password.text != value) {
                        return "Password does not match";
                      } else {
                        return null;
                      }
                    },
                  ),
                  verticalSpace(height: 30),
                  MaterialButton(
                    minWidth: size.width * 0.4,
                    height: size.height * 0.06,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    color: Colors.lightGreen,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        await authC.signUp(
                            email.text.trim(), password.text.trim());
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                            'SignUp',
                            style: GoogleFonts.lexendDeca(
                                fontSize: 18, fontWeight: FontWeight.w300),
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
