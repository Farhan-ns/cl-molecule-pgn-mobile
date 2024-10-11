import 'dart:convert';

import 'package:cl_pgn_mobile/extensions/mediaquery.dart';
import 'package:cl_pgn_mobile/screens/login_screen.dart';
import 'package:cl_pgn_mobile/screens/scanner_screen.dart';
import 'package:cl_pgn_mobile/screens/second_scanner.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  Future _getUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);

    return user;
  }

  _logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.clear();

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleTextStyle: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(color: Colors.black),
        title: Text('Home'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.black,
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        ),
      ),
      drawer: Drawer(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              FutureBuilder<dynamic>(
                future: _getUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return ListTile(
                      title: Text(
                        snapshot.error.toString(),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return ListTile(
                      title: Text('Halo, ${snapshot.data['name']}'),
                      subtitle: Text(snapshot.data['email']),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
              InkWell(
                child: ListTile(
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.blue.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: () {
                  _logout();
                },
              ),
              const Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(''),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 10),
          child: Column(
            children: [
              SizedBox(height: size.height / 5),
              Image.asset(
                "assets/images/logo-colored.png",
                width: context.mediaQuery.size.width * 0.6,
              ),
              SizedBox(height: context.mediaQuery.size.height * 0.1),
              FutureBuilder(
                future: _getUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  if (snapshot.hasData) {
                    return Text('${snapshot.data['name']}'.toUpperCase());
                  }
                  return const Text('-');
                },
              ),
              const Spacer(),
              SizedBox(
                width: size.width,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScannerScreen(),
                      ),
                    );
                  },
                  child: const Text('SCAN QR CODE'),
                ),
              ),
              // SizedBox(
              //   width: size.width,
              //   child: ElevatedButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => const SecondScannerScreen(),
              //         ),
              //       );
              //     },
              //     child: const Text('SCAN QR CODE Acara 2'),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
