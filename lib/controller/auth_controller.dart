import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lenggo/my_home_page.dart';
import 'package:lenggo/profile_page.dart';

class AuthProvider with ChangeNotifier {
  String? _name;
  String? _username;
  String? _password;
  String? _email;
  String? _errorMessage;
  String? _token;
  
  bool _isLoggedIn = false;

  bool _isLoadingProcess = false;

  int? _profileId;
  String? _profileName;
  String? _profileEmail;
  String? _profileUsername;
  String? _profileAboutMe;

  bool get isLoadingProcess => _isLoadingProcess;

  bool get isLoggedIn => _isLoggedIn;
  String? get name => _name;
  String? get username => _username;
  String? get email => _email;
  String? get password => _password;
  String? get errorMessage => _errorMessage;
  String? get token => _token;

  int? get profileId => _profileId;
  String? get profileName => _profileName;
  String? get profileEmail => _profileEmail;
  String? get profileUsername => _profileUsername;
  String? get profileAboutMe => _profileAboutMe;

  Future<void> editProcess(BuildContext context, int intUserId, String strName, String strAboutMe) async {
    _isLoadingProcess = true;
    notifyListeners();

    final requestPayload = {
      'user_id': intUserId,
      'name': strName,
      'about_me': strAboutMe,
    };

    final jsonPayload = jsonEncode(requestPayload);

    final url = Uri.parse('http://localhost:8000/api/edit-profile'); // Ganti dengan URL API kamu
    final request = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonPayload,
    );
    
    try {
      final data = jsonDecode(request.body);
      if (request.statusCode == 200) {
        _profileName = data['name'];
        _profileAboutMe = data['about_me'];

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const ProfilePage()),
          (route) => false, // Remove all previous routes
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Update Profile Success')),
        );
      } else {
        _errorMessage = data['error'];
      }

    } catch (e) {
      print(e);
    } finally {
      _isLoadingProcess = false;
      notifyListeners();
    }    
  }

  Future<void> registerProcess(BuildContext context, String strUsername, String strName, String strEmail, String strPassword) async {
    _isLoadingProcess = true;
    notifyListeners();

    final requestPayload = {
      'name': strName,
      'username': strUsername,
      'email': strEmail,
      'password': strPassword,
    };

    final jsonPayload = jsonEncode(requestPayload);

    final url = Uri.parse('http://localhost:8000/api/register'); // Ganti dengan URL API kamu
    final request = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonPayload,
    );
    
    try {
      final data = jsonDecode(request.body);
      if (request.statusCode == 201) {
        _token = data['csrf_token'];
        _profileId = data['id'];
        _profileName = data['name'];
        _profileUsername = data['username'];
        _profileEmail = data['email'];
        _profileAboutMe = data['about_me'];

        _isLoggedIn = true;
        _errorMessage = "";

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MyHomePage()),
          (route) => false, // Remove all previous routes
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Success')),
        );
      } else {
        _errorMessage = data['error'];
      }

    } catch (e) {
      print(e);
    } finally {
      _isLoadingProcess = false;
      notifyListeners();
    }
  }

  Future<void> loginProcess(BuildContext context, String strUsername, String strPassword) async {
    _isLoadingProcess = true;
    

    final requestPayload = {
      'username': strUsername,
      'password': strPassword,
    };

    final jsonPayload = jsonEncode(requestPayload);

    final url = Uri.parse('http://localhost:8000/api/login'); // Ganti dengan URL API kamu
    final request = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonPayload,
    );
    
    try {
      final data = jsonDecode(request.body);
      if (request.statusCode == 200) {
        if (data['csrf_token'] != null) {
          _token = data['csrf_token'];
          _profileId = data['id'];
          _profileName = data['name'];
          _profileUsername = data['username'];
          _profileEmail = data['email'];
          _profileAboutMe = data['about_me'];

          _isLoggedIn = true;

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const MyHomePage()),
            (route) => false, // Remove all previous routes
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login Success')),
          );
        }
      } else {
        _errorMessage = data['error'];
      }
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      _isLoadingProcess = false;
      notifyListeners();
    }
  }

  // Fungsi untuk menghapus gambar dan prediksi
  void logout() {
    _username = null;
    _email = null;
    _token = null;

    _isLoggedIn = false;

    _profileName = null;
    _profileUsername = null;
    _profileEmail = null;
    _profileAboutMe = null;

    notifyListeners();
  }
}