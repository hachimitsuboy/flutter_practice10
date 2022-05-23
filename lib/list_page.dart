import 'package:flutter/material.dart';
import 'package:secure_storage/home_page.dart';

class userInfo {
  final String userName;
  final String passWord;

  userInfo({
    required this.userName,
    required this.passWord,
  });
}

class ListPage extends StatefulWidget {
  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<userInfo> listStorage = [];

  void _getRepository() async {
    final storageAll = await storage.readAll();

    setState(() {
      listStorage = storageAll.entries
          .map((e) => userInfo(userName: e.key, passWord: e.value))
          .toList();
      print(listStorage.length);
    });
  }

  @override
  void initState() {
    super.initState();
    _getRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("リスト一覧"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: listStorage.length,
          itemBuilder: (context, int index) {
            return InkWell(
              onLongPress: () async {
                await storage.delete(key: listStorage[index].userName);
                _getRepository();
              },
              child: Card(
                elevation: 18,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  leading: const Icon(Icons.key),
                  title: Text(listStorage[index].userName),
                  subtitle: Text(listStorage[index].passWord),
                ),
              ),
            );
          }),
    );
  }
}
