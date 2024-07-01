import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taste_guide/presentation/viewmodels/user_viewmodel.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      Provider.of<UserViewModel>(context, listen: false)
          .login(_emailController.text, _passwordController.text)
          .then((_) {
        if (Provider.of<UserViewModel>(context, listen: false).isLoggedIn) {
          Navigator.pushReplacementNamed(context, '/list');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Username/Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username/email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Consumer<UserViewModel>(
                  builder: (context, viewModel, child) {
                    return Column(
                      children: [
                        if (viewModel.errorMessage.isNotEmpty)
                          Text(
                            viewModel.errorMessage,
                            style: TextStyle(color: Colors.red),
                          ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _login,
                          child: viewModel.isLoading
                              ? CircularProgressIndicator()
                              : Text('Login'),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text('Don\'t have an account? Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}