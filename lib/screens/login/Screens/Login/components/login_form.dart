import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:museum_app/screens/home/home.dart';

import '../../../../../navbar.dart';
import '../../../../profile/profile.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants2.dart';
import '../../Signup/signup_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController email = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: pass,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () {
                this._login();
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future _login() async {
    bool success = false;
    if (email.text.isEmpty || pass.text.isEmpty) {
      Alert(context: context, title: "Data Salah", type: AlertType.error)
          .show();
      return;
    }
    ProgressDialog pd = ProgressDialog(context: context);
    // pd.show(max: 100, msg: 'Loading...');
    final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/auth/login'),
        body: {'email': email.text, 'password': pass.text},
        headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      Alert(context: context, title: "Login Berhasil", type: AlertType.success)
          .show();
      success = true;
      final responseJson = jsonDecode(response.body)['token'];
      // Alert(
      //         context: context,
      //         title: responseJson.toString(),
      //         type: AlertType.info)
      //     .show();
      final storage = new FlutterSecureStorage();
      // String value = await storage.read(key: key);
      await storage.write(key: 'jwt', value: responseJson.toString());

      // var value = await storage.read(key: 'jwt');
      // Alert(context: context, title: value.toString(), type: AlertType.info)
      //     .show();
      // pd.close();
      // pd.update(value: 100);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => ProfilePage()),
      // );
    } else {
      Alert(context: context, title: "Login Gagal", type: AlertType.error)
          .show();
      email.text = "";
      pass.text = "";
      // pd.close();
      // pd.update(value: 100);
    }

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Navbar()),
      );
    }
  }
}
