import 'package:flutter/material.dart';
import 'package:flutter_vendor/utils/routes.dart'; // Assuming this imports your routing logic

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Vendor App',
          style: TextStyle(color: Colors.white, fontSize: 20), // Adjusted size
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0.0, // Remove app bar shadow
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Hero image or animation
              Hero(
                tag: 'landing_image', // Optional hero tag for animations
                child: Image.asset(
                  'assets/images/landing1.png', // Replace with your image path
                  width: double.infinity, // Make image responsive
                  height: 200,
                  fit: BoxFit.cover, // Adjust image fit as needed
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Select One:',
                style: TextStyle(
                  fontSize: 20, // Adjusted size
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              _buildFeaturedComboBox(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedComboBox(BuildContext context) {
    List<String> categories = ['Pen', 'Pencil', 'Books'];
    String selectedCategory = categories.first;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // Adjust shadow position
          ),
        ],
      ),
      child: DropdownButton<String>(
        value: selectedCategory,
        icon: Icon(Icons.arrow_drop_down, color: Colors.blue[900]),
        iconSize: 36,
        elevation: 16,
        style: TextStyle(fontSize: 16, color: Colors.black), // Adjusted size
        onChanged: (String? newCategory) {
          if (newCategory == 'Pen') {
            Navigator.pushNamed(context, MyRoutes.loginRoute1);
          } else if (newCategory == 'Pencil') {
            Navigator.pushNamed(context, MyRoutes.loginRoute2);
          } else if (newCategory == 'Books') {
            Navigator.pushNamed(context, MyRoutes.loginRoute3);
          }
        },
        items: categories.map((String category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(
              category,
              style: TextStyle(fontSize: 16), // Adjusted size
            ),
          );
        }).toList(),
      ),
    );
  }
}
