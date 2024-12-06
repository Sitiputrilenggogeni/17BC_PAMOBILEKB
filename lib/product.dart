import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  const Product({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Jumlah kolom
          childAspectRatio: 0.75, // Rasio tinggi dan lebar item
        ),
        itemCount: 3, // Jumlah item yang akan ditampilkan
        itemBuilder: (context, index) {
          // Daftar gambar produk
          List<String> productImages = [
            'assets/jambu.jpg',
            'assets/sirih.jpg',
            'assets/jeruknipis.jpg',
          ];

          // Daftar nama produk
          List<String> productNames = [
            'Daun Jambu',
            'Daun Sirih',
            'Daun Jeruk Nipis',
          ];

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Gambar produk dari asset
                Image.asset(
                  productImages[index], // Path ke asset gambar
                  height: 500, // Tinggi gambar
                  width: 500, // Lebar gambar
                  fit: BoxFit.cover, // Penyesuaian ukuran gambar
                ),
                const SizedBox(height: 8.0),
                Text(
                  productNames[index],
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 4.0),
                Text(
                  '\$${(index + 1) * 10}', // Harga produk (contoh harga)
                  style: const TextStyle(fontSize: 14.0, color: Colors.green),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (value) {
          if (value == 0) {
            Navigator.pushNamed(context, "/home");
          } else if (value == 2) {
            Navigator.pushNamed(context, "/profile");
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Product",
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
