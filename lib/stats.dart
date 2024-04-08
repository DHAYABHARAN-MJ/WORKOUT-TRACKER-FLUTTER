import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "FitPath",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xff4B4B87),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: Color(0xffA3A3CC),
        unselectedIconTheme: IconThemeData(color: Color(0xffA3A3CC)),
        selectedItemColor: Color(0xff6161A8),
        selectedIconTheme: IconThemeData(
          color: Color(0xff484884),
        ),
        selectedLabelStyle: TextStyle(
          color: Color(0xff6161A8),
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            label: 'Exercise',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: [
            StatsGridCard(
              title: "PushUps",
              imagePath: 'assets/pushups.gif',
            ),
            StatsGridCard(
              title: "Plank",
              imagePath: 'assets/body-saw-plank.gif',
            ),
            StatsGridCard(
              title: "Squats",
              imagePath: 'assets/bodyweight-squat-2.gif',
            ),
            StatsGridCard(
              title: "Biceps Curl",
              imagePath: 'assets/bicepscurl.gif',
            ),
          ],
        ),
      ),
    );
  }
}

class StatsGridCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const StatsGridCard({
    Key? key,
    required this.title,
    required this.imagePath,
  }) : super(key: key);

  void _fetchExerciseDetails() async {
    try {
      final response = await http.get(Uri.parse('https://exercisedb.p.rapidapi.com/exercises/targetList'), headers: {
        'X-RapidAPI-Key': '37f53e8678mshf15f3eea2ad8484p153cf7jsn5d6406c64035',
        'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com'
      });

      if (response.statusCode == 200) {
        print(response.body);
        // Parse the response data and handle accordingly
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 100,
            height: 100,
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 15),
          ElevatedButton(
            onPressed: _fetchExerciseDetails,
            child: Text(
              'Details',
              style: TextStyle(fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              onPrimary: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
