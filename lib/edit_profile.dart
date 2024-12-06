import 'package:flutter/material.dart';
import 'package:lenggo/controller/auth_controller.dart';
import 'package:provider/provider.dart';

// Halaman Sign Up
class EditProfilePage extends StatelessWidget {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController aboutMeController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    nameController.text = authProvider.profileName!;
    if(authProvider.profileAboutMe != null){
      aboutMeController.text = authProvider.profileAboutMe!;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Profile',
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
                  'Update Profile Form',
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
                
                TextField(
                  controller: aboutMeController,
                  decoration: const InputDecoration(
                    labelText: 'About Me',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 40),
                
                ElevatedButton(
                  onPressed: () {
                    authProvider.editProcess(context, authProvider.profileId!, nameController.text, aboutMeController.text);
                  },
                  child: const Text('Update Profile'),
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
