import 'dart:convert';
import 'dart:developer';

import 'package:cl_pgn_mobile/extensions/mediaquery.dart';
import 'package:cl_pgn_mobile/network/api.dart';
import 'package:cl_pgn_mobile/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final username = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _login() async {
    if (isLoading) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      var data = {'email': username.text, 'password': password.text};

      var res = await Network().authData(data, '/api/login');
      var body = jsonDecode(res.body);
      inspect(res);
      inspect(body);

      if (res.statusCode == 200) {
        var token = body['data']['token'];
        var user = body['data']['user'];

        SharedPreferences localStorage = await SharedPreferences.getInstance();

        localStorage.setString('token', json.encode(token));
        localStorage.setString('user', json.encode(user));

        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
      } else {
        _showAlert(body['message']);
      }
    } catch (e) {
      _showAlert(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showAlert(msg) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Failed'),
          content: Text(msg),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: Container(
      //     height: 200,
      //     padding: const EdgeInsets.all(10),
      //     child: Image.asset(
      //       "assets/images/yorindo.png",
      //       width: context.mediaQuery.size.width * 0.4,
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        title: const Text('Login PGN Scanner'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo-colored.png",
                width: context.mediaQuery.size.width * 0.8,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Text(
              //     'Event : Penerapan Generative AI Bagi Sumber Daya Manusia (HR) di Industri Manufaktur',
              //     textAlign: TextAlign.center,
              //     style: Theme.of(context)
              //         .textTheme
              //         .titleSmall
              //         ?.copyWith(fontWeight: FontWeight.w600),
              //   ),
              // ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextFormField(
                        controller: username,
                        decoration: const InputDecoration(
                          hintText: 'Username',
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Tidak boleh kosong';
                          }

                          var emailRegex = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                          if (!emailRegex.hasMatch(value!)) {
                            return 'Masukkan email yang valid';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: password,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Tidak boleh kosong';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _login();
                            }
                          },
                          child: isLoading
                              ? const Text('Memproses...')
                              : const Text('LOGIN'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
