import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orre_manager/provider/call_button_provider.dart';
import 'package:orre_manager/provider/waiting_timer_provider.dart';
import '../provider/waiting_provider.dart';

class CallIconButton extends ConsumerWidget {
  final int waitingNumber;
  final int storeCode;
  final int minutesToAdd;
  final WidgetRef ref;

  CallIconButton({
    required this.waitingNumber,
    required this.storeCode,
    required this.minutesToAdd,
    Key? key,
    required this.ref,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPressed = ref.watch(callButtonProvider(waitingNumber));

    return Row(
      children: [
        isPressed
            ? TimerWidget(minutesToAdd: minutesToAdd)
            : IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Color(0xFF72AAD8),
                ),
                iconSize: 30,
                onPressed: () {
                  ref
                      .read(callButtonProvider(waitingNumber).notifier)
                      .pressButton(); // 상태 변경
                  ref.read(waitingProvider.notifier).sendCallRequest(
                        context,
                        waitingNumber,
                        storeCode,
                        minutesToAdd,
                      );
                },
              ),
      ],
    );
  }
}
