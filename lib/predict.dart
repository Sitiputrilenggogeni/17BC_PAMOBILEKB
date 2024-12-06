import 'package:flutter/material.dart';
import 'package:lenggo/controller/auth_controller.dart';
import 'package:lenggo/controller/controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Predict extends StatelessWidget {
  const Predict({super.key});

  @override
  Widget build(BuildContext context) {

    final predictionProvider = Provider.of<PredictionProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaf Health Prediction'),
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          
          // Tampilkan gambar yang dipilih
          predictionProvider.imageFile != null
              ? Image.memory(predictionProvider.imageFile!)
              : Container(
                  height: 200,
                  width: 200,
                  color: Colors.grey[200],
                  child: Icon(
                    Icons.image,
                    size: 100,
                    color: Colors.grey[400],
                  ),
                ),
          SizedBox(height: 16),

          // // Tombol untuk mengambil gambar dari kamera
          // ElevatedButton.icon(
          //   onPressed: () {
          //     predictionProvider.pickImage(ImageSource.camera);
          //   },
          //   icon: Icon(Icons.camera),
          //   label: Text('Take a Picture'),
          // ),
          // SizedBox(height: 16),

          // Tombol untuk memilih gambar dari galeri
          ElevatedButton.icon(
            onPressed: () {
              predictionProvider.pickImage(ImageSource.gallery);
            },
            icon: Icon(Icons.photo_library),
            label: Text('Choose from Gallery'),
          ),
          SizedBox(height: 16),

          // Tombol untuk mengirim gambar dan mendapatkan prediksi
          ElevatedButton.icon(
            onPressed: () {
              predictionProvider.predictImage(authProvider.token);
            },
            icon: Icon(Icons.upload_file),
            label: Text('Predict'),
          ),
          SizedBox(height: 16),

          // Tampilkan hasil prediksi
          if (predictionProvider.predictionMessage != null)
            Text(
              predictionProvider.predictionMessage!,
              // "This leaf is Healthy",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
        ],
        ),
      ),
    );
  }
}