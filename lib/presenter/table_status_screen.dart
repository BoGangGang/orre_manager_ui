import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orre_manager/Model/login_data_model.dart';
import 'package:orre_manager/Model/restaurant_table_model.dart';
import 'package:orre_manager/provider/stomp_client_future_provider.dart';
import 'package:orre_manager/provider/table_provider.dart';
import 'package:orre_manager/widget/menu_bottom.dart';

class TableManagementScreen extends ConsumerWidget {
  final LoginData loginResponse;
  TableManagementScreen({required this.loginResponse});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stompClientAsyncValue = ref.watch(stompClientProvider);

    return stompClientAsyncValue.when(
      data: (stompClient) {
        return _TableManagementBody(loginData: loginResponse);
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

class _TableManagementBody extends ConsumerWidget {
  final LoginData loginData;
  late int storeCode;
  RestaurantTable? restaurantTable;
  bool isSubscribed = false;

  _TableManagementBody({required this.loginData});

  void subscribeProcess(WidgetRef ref, BuildContext context) {
    if (restaurantTable == null && !isSubscribed) {
      storeCode = loginData.storeCode;
      final restaurantTableNotifier = ref.read(tableProvider.notifier);
      restaurantTableNotifier.subscribeToLockTableData(storeCode);
      restaurantTableNotifier.subscribeToUnlockTableData(storeCode);
      restaurantTableNotifier.subscribeToTableData(storeCode);
      restaurantTableNotifier.sendStoreCode(storeCode);
      isSubscribed = true; // sendWaitingData가 한 번만 호출되도록 설정
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    restaurantTable = ref.watch(tableProvider);
    subscribeProcess(ref, context);

    if (restaurantTable == null) {
      return _LoadingScreen();
    }

    return Scaffold(
      bottomNavigationBar: MenuBottom(),
      appBar: AppBar(
        title: Text(
          '테이블 관리',
          style: TextStyle(
            fontFamily: 'Dovemayo_gothic',
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // '테이블 추가하기' 버튼 동작 정의
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF72AAD8)),
                    ),
                    child: Text(
                      '테이블 추가',
                      style: TextStyle(
                        fontFamily: 'Dovemayo_gothic',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // '테이블 삭제하기' 버튼 동작 정의
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF72AAD8))),
                    child: Text(
                      '테이블 삭제',
                      style: TextStyle(
                        fontFamily: 'Dovemayo_gothic',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // '테이블 병합하기' 버튼 동작 정의
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF72AAD8))),
                    child: Text(
                      '테이블 병합',
                      style: TextStyle(
                        fontFamily: 'Dovemayo_gothic',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20), // 버튼과 GridView 사이 간격 조절

            Expanded(
              child: Consumer(builder: (context, ref, child) {
                List<Seat> currentSeats = ref.watch(tableProvider)!.table;

                return LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return SizedBox(
                      width: constraints.maxWidth * 0.9,
                      height: constraints.maxWidth * 0.9,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 3 / 2, // 각 항목의 가로:세로 비율 설정
                        ),
                        itemCount: currentSeats.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              _showTableInfoPopup(
                                  ref, context, currentSeats[index]);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: currentSeats[index].tableStatus == 0
                                    ? Color(0xFFDFDFDF)
                                    : Color(0xFF72AAD8), // 사용 가능 여부에 따라 색상 변경
                              ),
                              child: Center(
                                child: Text(
                                  currentSeats[index].tableNumber.toString(),
                                  style: TextStyle(
                                    color: currentSeats[index].tableStatus == 0
                                        ? Color(0xFF72AAD8)
                                        : Color(0xFFE6F4FE),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  void _showTableInfoPopup(WidgetRef ref, BuildContext context, Seat table) {
    TextEditingController _temp_waitingNumber = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          title: Text(
            '테이블 정보',
            style: TextStyle(
              fontFamily: 'Dovemayo_gothic',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '테이블 번호: ${table.tableNumber}',
                style: TextStyle(
                  fontFamily: 'Dovemayo_gothic',
                  fontSize: 20,
                ),
              ),
              Text(
                '최대 착석 가능 수: ${table.maxPersonPerTable}',
                style: TextStyle(
                  fontFamily: 'Dovemayo_gothic',
                  fontSize: 20,
                ),
              ),
              Text(
                '테이블 상태: ${table.tableStatus == 0 ? '착석불가능' : '착석가능'}',
                style: TextStyle(
                  fontFamily: 'Dovemayo_gothic',
                  fontSize: 20,
                ),
              ),
              if (table.guestInfo != null) // 만약 guestInfo가 있다면 추가 정보 표시
                Text(
                  'Guest Info: ${table.guestInfo.toString()}',
                  style: TextStyle(
                    fontFamily: 'Dovemayo_gothic',
                    fontSize: 20,
                  ),
                ),
              SizedBox(height: 10),
              // 숫자를 입력받는 TextField 추가
              if (table.tableStatus == 0)
                TextField(
                  controller: _temp_waitingNumber,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: '웨이팅 번호를 입력하세요.', // 입력 필드의 라벨 텍스트
                    labelStyle: TextStyle(
                      fontFamily: 'Dovemayo_gothic',
                      fontSize: 22,
                    ),
                  ),
                ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      if (table.tableStatus == 0) {
                        //Unlock Process
                        int waitingNumber =
                            int.tryParse(_temp_waitingNumber.text) ??
                                0; // 입력된 값을 정수로 변환
                        ref.read(tableProvider.notifier).sendUnlockRequest(
                            loginData.storeCode,
                            table.tableNumber,
                            waitingNumber,
                            loginData.loginToken!);
                      } else {
                        ref.read(tableProvider.notifier).sendLockRequest(
                            loginData.storeCode,
                            table.tableNumber,
                            loginData.loginToken!);
                      }
                    },
                    child: Text(
                      table.tableStatus == 0 ? '테이블 언락' : '테이블 락',
                      style: TextStyle(
                          fontFamily: 'Dovemayo_gothic',
                          fontSize: 20,
                          color: Color(0xFF72AAD8)),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // 팝업 닫기
                      // ref.read(tableProvider.notifier).sendStoreCode(loginData.storeCode);
                    },
                    child: Text(
                      '닫기',
                      style: TextStyle(
                          fontFamily: 'Dovemayo_gothic',
                          fontSize: 20,
                          color: Color(0xFF72AAD8)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
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
      body: Center(
        child: Text('Error: $error'),
      ),
    );
  }
}
