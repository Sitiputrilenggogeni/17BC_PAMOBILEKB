import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class PredictionProvider with ChangeNotifier {
  Uint8List? imageFile;
  String? predictionMessage;
  final ImagePicker _picker = ImagePicker();

  // Fungsi untuk mengambil gambar dari galeri atau kamera
  Future<void> pickImage(ImageSource source) async {
    // final pickedFile = await _picker.pickImage(source: source);
    // if (pickedFile != null) {
    //   imageFile = XFile(pickedFile.path);
    //   notifyListeners();
    // }
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      imageFile = bytes;
      notifyListeners();
    }
  }

  // Fungsi untuk mengirim gambar ke API dan mendapatkan prediksi
  Future<void> predictImage(token) async {
    if (imageFile == null) return;

    final url = Uri.parse('http://localhost:8000/api/predict-image'); // Ganti dengan URL API kamu
    final request = http.MultipartRequest('POST', url)
      // ..files.add(await http.MultipartFile.fromPath('image', imageFile!.path));  // Pastikan field image sesuai
      ..files.add(await http.MultipartFile.fromBytes('image', imageFile!, filename: 'image.jpg'));  // Pastikan field image sesuai
    // (Optional) Tambahkan header jika API memerlukannya
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'X-CSRFToken': token,
    });

    try {
      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      print('Response status: ${response.statusCode}');
      print('Response body: $responseData');
      if (response.statusCode == 200) {
        final data = jsonDecode(responseData);
        
        if (data['prediction'] != null && data['prediction'].isNotEmpty) {
          // Mengambil hasil prediksi pertama
          String prediction = data['prediction'];
          predictionMessage = 'Leaf Prediction: $prediction';
        } else {
          predictionMessage = 'Prediction failed';
        }
      } else {
        // Jika error, tampilkan pesan error
        predictionMessage = 'Error ${response.statusCode}: $responseData';
      }
      notifyListeners();
    } catch (e) {
      predictionMessage = 'Error: $e';
      notifyListeners();
    }
  }

  // Fungsi untuk menghapus gambar dan prediksi
  void clear() {
    imageFile = null;
    predictionMessage = null;
    notifyListeners();
  }
}