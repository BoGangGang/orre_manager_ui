import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WaitingAddingScreen(),
    );
  }
}

class WaitingAddingScreen extends StatelessWidget {
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
          SizedBox(height: 20),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: TextField(
                      // controller: 여기다가 이름 입력 컨트롤러 필요하면 사용
                      decoration: InputDecoration(
                        labelText: '이름',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Color(0xFF77AAD8),
                            width: 3.0,
                          ),
                        ),
                        labelStyle: TextStyle(
                          fontFamily: 'Dovemayo_gothic',
                          fontSize: 20,
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * 0.9),
                SizedBox(height: 20),
                Container(
                    child: TextField(
                      // controller: 여기다가 전화번호 입력 컨토롤러 필요하면 사용
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: '전화번호',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Color(0xFF77AAD8),
                            width: 3.0,
                          ),
                        ),
                        labelStyle: TextStyle(
                          fontFamily: 'Dovemayo_gothic',
                          fontSize: 20,
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * 0.9),
                SizedBox(height: 20),
                Container(
                    child: TextField(
                      // controller: 여기다가 인원수 입력 컨트롤러 필요하면 사용
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: '인원 수',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Color(0xFF77AAD8),
                            width: 3.0,
                          ),
                        ),
                        labelStyle: TextStyle(
                          fontFamily: 'Dovemayo_gothic',
                          fontSize: 20,
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * 0.9),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // 여기에 웨이팅 성공 어쩌구, 서버단에다가 보내는 거 등등
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
                    "웨이팅 하기",
                    style: TextStyle(
                      fontFamily: 'Dovemayo_gothic',
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20),
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
