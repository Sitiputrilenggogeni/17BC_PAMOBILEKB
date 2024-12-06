import 'package:flutter/material.dart';
import 'package:lenggo/controller/auth_controller.dart';
import 'package:provider/provider.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 1000,
            height: 1000,
            child: Image.asset(
              'assets/logo2.png',
              fit: BoxFit.contain,
            ), // Gambar logo
          ),
        ),
        actions:
        !authProvider.isLoggedIn
            ?
        [] : [
          ElevatedButton(
            onPressed: () {
              authProvider.logout();

              if (authProvider.isLoggedIn) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const MyHomePage()),
                  (route) => false, // Remove all previous routes
                );
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Logout Success')),
              );
            },
            child: const Text(
              'Sign Out',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 50),
              const Text(
                'Selamat Datang di Hijau Daun',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/fore.jpg',
                width: 800,
                height: 300,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20), // Jarak antara gambar dan deskripsi
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  ' Klasifikasi Penyakit Daun Mangga ',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          if(!authProvider.isLoggedIn) {
            if (value == 1) {
              Navigator.pushNamed(context, "/register");
            } else if (value == 2) {
              Navigator.pushNamed(context, "/login");
            }
          } else {
            if (value == 1) {
              Navigator.pushNamed(context, "/predict");
            } else if (value == 2) {
              Navigator.pushNamed(context, "/profile");
            }
          }
        },
        items: 
        !authProvider.isLoggedIn
            ?
        const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: "Register",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: "Sign In",
          ),
        ]
        :
        const [
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
