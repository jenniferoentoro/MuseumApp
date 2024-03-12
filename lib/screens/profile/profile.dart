import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:museum_app/api_service.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/screens/login/Screens/Login/login_screen.dart';
import 'package:museum_app/screens/profile/privacyPolicy.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

import '../../navbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String value;
  late bool logged;
  late String name;
  late String email;

  @override
  void initState() {
    getProfile();
    name = user_1.getNama();
    if (name == "" || name == null) {
      name = "Guest";
    }
    email = user_1.getEmail();
    if (email == "" || email == null) {
      email = "guest@petra.ac.id";
    }

    super.initState();
    getSavedData().then((value) {
      setState(() {
        if (value != null) {
          logged = true;
        } else {
          logged = false;
        }
      });
    });
  }

  Future<String?> getSavedData() async {
    final storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'jwt');

    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 30),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(25, 50, 15, 10),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF555B6E),
                ),
                child: const Icon(
                  Icons.account_circle_outlined,
                  color: Colors.white,
                  size: 100.0,
                ),
              ),

              // if (finalNRP == null) ...[
              //   Text("Guest",
              //       style: TextStyle(
              //           fontSize: 24, fontWeight: FontWeight.w600),
              //       textAlign: TextAlign.start),
              //   Text(
              //     "guest@petra.ac.id",
              //     style: TextStyle(
              //       fontSize: 14,
              //     ),
              //     textAlign: TextAlign.start,
              //   )
              // ] else ...[
              Text(
                  // userName!,
                  // userName ??
                  name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center),
              Text(
                // userEmail!,
                // userEmail ??
                email,
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              // ],
              const SizedBox(height: 50)
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (logged) ...[
                // _buildAbout(),
                _buildClearCache(),
                _buildPrivacyPolicy(),
                _buildLogout()
              ] else ...[
                // _buildAbout(),
                _buildClearCache(),
                _buildPrivacyPolicy(),
                _buildLogin()
              ]
            ],
          )
        ],
      ),
    ));
  }

  Widget _buildClearCache() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 15),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.delete_outline_outlined),
        style: ElevatedButton.styleFrom(
            elevation: 2,
            // backgroundColor: Color(0xffEEF6FF),
            primary: const Color(0xFFE2EFFF),
            // foregroundColor: Color.fromARGB(255, 44, 55, 134),
            onPrimary: const Color(0xff0D1B2A),
            minimumSize: const Size.fromHeight(45),
            alignment: Alignment.centerLeft,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        onPressed: () {
          // do clear cache
        },
        label: const Text(
          "Clear Cache",
          style: TextStyle(
            fontFamily: "Cera Round Pro 2",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildPrivacyPolicy() {
    //Privacy and Policy
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 15),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.security_outlined),
        style: ElevatedButton.styleFrom(
            elevation: 2,
            // backgroundColor: Color(0xffEEF6FF),
            primary: const Color(0xFFE2EFFF),
            // foregroundColor: Color.fromARGB(255, 44, 55, 134),
            onPrimary: const Color(0xff0D1B2A),
            minimumSize: const Size.fromHeight(45),
            alignment: Alignment.centerLeft,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        onPressed: () {
          // navigate ke Privacy and Policy
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PrivacyPolicyPage(),
            ),
          );
        },
        label: const Text(
          "Privacy and Policy",
          style: TextStyle(
            fontFamily: "Cera Round Pro 2",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildLogout() {
    //Logout
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 15),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.logout_rounded),
        style: ElevatedButton.styleFrom(
            elevation: 2,
            // backgroundColor: Color.fromARGB(255, 44, 55, 134),
            primary: const Color.fromARGB(255, 44, 55, 134),
            // foregroundColor: Color(0xffEEF6FF),
            onPrimary: const Color(0xffEEF6FF),
            minimumSize: const Size.fromHeight(45),
            alignment: Alignment.centerLeft,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        onPressed: () {
          logout();
        },
        label: const Text(
          "Logout",
          style: TextStyle(
            fontFamily: "Cera Round Pro 2",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future logout() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'jwt');
    final response = await http
        .post(Uri.parse('http://10.0.2.2:8000/api/auth/logout'), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer " + token!
    });
    if (response.statusCode == 200) {
      Alert(context: context, title: "Logout Berhasil", type: AlertType.success)
          .show();
      storage.delete(key: 'jwt');
    } else {
      Alert(context: context, title: "Logout Gagal", type: AlertType.error)
          .show();
    }

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Navbar()));
  }

  Widget _buildLogin() {
    //Login
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 15),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.login_rounded),
        style: ElevatedButton.styleFrom(
            elevation: 2,
            // backgroundColor: Color.fromARGB(255, 44, 55, 134),
            primary: const Color(0xFF555B6E),
            // foregroundColor: Color(0xffEEF6FF),
            onPrimary: const Color(0xffEEF6FF),
            minimumSize: const Size.fromHeight(45),
            alignment: Alignment.centerLeft,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        label: const Text(
          "Login",
          style: TextStyle(
            fontFamily: "Cera Round Pro 2",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
