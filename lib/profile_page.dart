import 'package:flutter/material.dart';
import 'package:lenggo/controller/auth_controller.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(80),
              ),
            ),
            const SizedBox(height: 16.0),
            
            Text(
              authProvider.profileName!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            
            Text(
              authProvider.profileEmail!,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16.0),

            if( authProvider.profileAboutMe != null )
              Text(
                authProvider.profileAboutMe!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),

            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/edit-profile");
              },
              child: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (value) {
          if (value == 0) {
            Navigator.pushNamed(context, "/home");
          } else if (value == 1) {
            Navigator.pushNamed(context, "/predict");
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Predict",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
