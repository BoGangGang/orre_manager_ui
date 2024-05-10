import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/admin_login_provider.dart';
import '../provider/stomp_client_future_provider.dart';

class LoginScreenWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stompClientAsyncValue = ref.watch(stompClientProvider);

    return stompClientAsyncValue.when(
      data: (stompClient) {
        // stompClient가 준비되면 위젯을 반환합니다.
        return _LoginScreenBody(); // 별도의 위젯으로 분리
      },
      loading: () {
        // 로딩 중이면 로딩 스피너를 표시합니다.
        return _LoadingScreen();
      },
      error: (error, stackTrace) {
        // 에러가 발생하면 에러 메시지를 표시합니다.
        return _ErrorScreen(error);
      },
    );
  }
}

class _LoginScreenBody extends ConsumerWidget {
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

  void loginProcess(WidgetRef ref) {
    ref
        .read(loginProvider.notifier)
        .subscribeToLoginData(ref.context, _idController.text);
    ref
        .read(loginProvider.notifier)
        .sendLoginData(ref.context, _idController.text, _pwController.text);
    // ref.read(loginProvider.notifier).unSubscribeLoginData();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "로그인",
              style: TextStyle(
                fontFamily: 'Dovemayo_gothic',
                fontSize: 32,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: TextField(
                      controller: _idController,
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
                      controller: _pwController,
                      decoration: InputDecoration(
                        labelText: '비밀번호',
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
                  onPressed: () => loginProcess(ref),
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
                      color: Colors.white,
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

class _LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _ErrorScreen extends StatelessWidget {
  final dynamic error;

  _ErrorScreen(this.error);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Center(
        child: Text('Error: $error'),
      ),
    );
  }
}
