import 'package:flutter/material.dart';
import 'login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartScreen(),
    );
  }
}

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            "assets/images/waveform/wave_shadow.png",
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Image.asset(
            "assets/images/waveform/wave.png",
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                Text(
                  "가 오 리",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Dovemayo_gothic',
                    fontSize: 64,
                    color: Color(0xFF72AAD8),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.25,
                    backgroundColor: Color(0xFFE6F4FE),
                    backgroundImage:
                        AssetImage("assets/images/logo/gaorre.png"),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "원격 줄서기 원격 주문 서비스",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Dovemayo_gothic',
                    fontSize: 24,
                    color: Color(0xFF72AAD8),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreenWidget()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF72AAD8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.9, 60),
                  ),
                  child: Text(
                    "로그인",
                    style: TextStyle(
                      fontFamily: 'Dovemayo_gothic',
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 20,
              color: Color(0xFF72AAD8),
            ),
          ),
        ],
      ),
    );
  }
}
