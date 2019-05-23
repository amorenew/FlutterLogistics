import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/shipments_model.dart';

class LoginPage extends StatefulWidget {
  // final ShipmentsModel model = ShipmentsModel();
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submit(Function login) async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = _usernameTextController.text;
    final password = _passwordTextController.text;

    final String token = await login(username, password);
    if (token != null) {
      prefs.setString('token', token);
      Navigator.of(context).pushReplacementNamed('/menu');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('An Error Occured!'),
              content: Text('Your email or password is invalid.'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            decoration: BoxDecoration(color: Colors.white),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _usernameTextController,
                    decoration: InputDecoration(labelText: 'Username'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (String value) {
                      if (value.trim().isEmpty || value.trim().length < 3) {
                        return 'Please enter a valid username';
                      }
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                      controller: _passwordTextController,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (String value) {
                        if (value.isEmpty || value.length < 3) {
                          return 'Password invalid';
                        }
                      }),
                  SizedBox(
                    height: 25.0,
                  ),
                  ScopedModelDescendant<ShipmentsModel>(
                    builder: (context, child, model) => model.isLoading
                        ? CircularProgressIndicator()
                        : RaisedButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            child: Text('Login'),
                            onPressed: () => _submit(model.login),
                          ),
                  )
                ],
              ),
            )
            // child: Image.asset('assets/images/logo.png'),
            ));
  }
}
