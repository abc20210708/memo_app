import 'package:flutter/material.dart';
import 'package:memo_app/database/db.dart';
import 'package:memo_app/database/memo.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method

class EditPage extends StatelessWidget {

  String title = "";
  String text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.delete)
          ),
          IconButton(
              onPressed: saveDB,
              icon: const Icon(Icons.save)
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              onChanged: (String title){this.title = title;},//변경된 것을 저장
              style: TextStyle(fontSize: 30,
              fontWeight: FontWeight.bold),
              keyboardType: TextInputType.multiline,
              //maxLines: 3,
              //obscureText: true,
              decoration: InputDecoration(
                //border: OutlineInputBorder(),
                hintText: "제목을 적어주세요",
              ),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            TextField(
              onChanged: (String text){this.text = text;},
              //obscureText: true,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                //border: OutlineInputBorder(),
                hintText: "내용을 적어주세요",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveDB() async {
    DBHelper sd = DBHelper();

    var fido = Memo(
        id: StrSha512(DateTime.now().toString()),
        title: this.title,
        text: this.text,
        createTime: DateTime.now().toString(),
        editTime: DateTime.now().toString());

    await sd.insertMemo(fido);

    print(await sd.memos());

   // print(await sd.memos());
  }

  String StrSha512(String text) {
    var bytes = utf8.encode(text); // data being hashed

    var digest = sha512.convert(bytes);

    return digest.toString();
  }
}
