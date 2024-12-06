import 'package:flutter/material.dart';
import 'package:lenggo/controller/auth_controller.dart';
import 'package:provider/provider.dart';
import 'package:lenggo/my_home_page.dart';

// Halaman Sign Up
class SignUpPage extends StatelessWidget {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
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
                  'Sign Up Form',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
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
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
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
                    authProvider.registerProcess(context, usernameController.text, nameController.text, emailController.text, passwordController.text);
                  },
                  child: const Text('Sign Up'),
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
