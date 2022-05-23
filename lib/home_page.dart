import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:secure_storage/list_page.dart';

// Create Storage

final storage = new FlutterSecureStorage();

class HomePage extends StatelessWidget {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("入力画面"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: userNameController,
                maxLines: 1,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "UserName",
                ),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: passwordController,
                maxLines: 1,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "PassWord",
                ),
              ),
            ),
            const SizedBox(height: 100),
            SizedBox(
              width: 240,
              child: ElevatedButton(
                  onPressed: () async {
                    final key = userNameController.text;
                    final value = passwordController.text;
                    if (key.isNotEmpty && value.isNotEmpty) {
                      //画面遷移
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ListPage()));

                      //登録
                      storage.write(key: key, value: value);
                      final mapStorage = await storage.readAll();
                      print(mapStorage.toString());
                    }
                  },
                  child: const Text(
                    "入力完了",
                    style: TextStyle(fontSize: 14),
                  )),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 240,
              child: ElevatedButton(
                  onPressed: () async {
                    //画面遷移
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => ListPage()));
                  },
                  child: const Text(
                    "一覧画面へ",
                    style: TextStyle(fontSize: 14),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
