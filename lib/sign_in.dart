import 'package:flutter/material.dart';
import 'package:lenggo/controller/auth_controller.dart';
import 'package:provider/provider.dart';


// Halaman Sign Up
class SignInPage extends StatelessWidget {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  // const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign In',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<AuthProvider>(
        builder: (context, provider, child) {
          if (authProvider.isLoadingProcess) {
            return Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    authProvider.loginProcess(context, usernameController.text, passwordController.text);
                  },
                  child: const Text('Sign In'),
                ),

                const SizedBox(height: 20),
                if (authProvider.errorMessage != null)
                  Text(
                    authProvider.errorMessage!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
            
              ],
            ),
          );
        }
      )
    );
  }
}
