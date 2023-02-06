import 'package:flutter/material.dart';

class CheckingPage extends StatelessWidget {
  const CheckingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ),
            SizedBox(
              height: 10,
            ),
            Text('ກຳລັງກວດຊອບ... ຂໍ້ມູນຈາກ Server')
          ],
        ),
      ),
    );
  }
}
