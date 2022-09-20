// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memo_app/screens/write.dart';
import 'package:memo_app/database/db.dart';
import 'package:memo_app/database/memo.dart';
import 'package:memo_app/screens/view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String deleteId = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5, top: 40, bottom: 20),
            child: Container(
              child: Text(
                "MEMO",
                style: TextStyle(fontSize: 36, color: Colors.black87),
              ),
              alignment: Alignment.centerLeft,
            ),
          ),
          Expanded(child: memoBuilder(context))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => WritePage()));
        },
        tooltip: '메모를 추가하려면 클릭하세요',
        label: Text("메모 추가"),
        icon: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  Future<List<Memo>> loadMemo() async {
    DBHelper sd = DBHelper();
    return await sd.memos();
  }

  Future<void> deleteMemo(String id) async {
    DBHelper sd = DBHelper();
    return sd.deleteMemo(id);
  }

  void showAlertDialog(BuildContext context) async {
     await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('삭제 경고'),
          content: Text('정말 삭제하시겠습니까?\n삭제된 메모는 복구되지 않습니다.'),
          actions: <Widget>[
            TextButton(
              child: Text('삭제'),
              onPressed: () {
                Navigator.pop(context, "삭제");
                setState(() {
                  deleteMemo(deleteId);
                });
                deleteId = "";
              },
            ),
            TextButton(
              child: Text('취소'),
              onPressed: () {
                deleteId = "";
                Navigator.pop(context, "취소");
              },
            ),
          ],
        );
      },
    );
  }

  Widget memoBuilder(BuildContext parentContext) {
    return FutureBuilder<List<Memo>>(
      future: loadMemo(),
      builder: (BuildContext context,AsyncSnapshot snap) {
        if (!snap.hasData) {
          return Container(
            alignment: Alignment.center,
            child: Text('"메모 추가"버튼을 눌러\n 새로운 메모를 추가해보세요!',
            style: TextStyle(
              fontSize: 15, color: Colors.blueGrey,
            ),
              textAlign: TextAlign.center,
            ),
          );
        }
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: snap.data!.length,
          itemBuilder: (context, index) {
            Memo memo = snap.data![index];
            return InkWell(
              onTap: (){
                Navigator.push(
                    parentContext,
                    CupertinoPageRoute(
                        builder: (context) => ViewPage(id: memo.id)));
              },
              onLongPress: (){
               setState(() {
                 deleteId = memo.id;
                 showAlertDialog(parentContext);
                 print("memo.id : "+ memo.id);
                 //deleteMemo(memo.id);
               });
              },
              child: Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.all(5),
                alignment: Alignment.center,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(memo.title ,
                        style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold
                        ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(memo.text,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("최종수정시간 : " + memo.editTime.split('.')[0],
                        style: TextStyle(fontSize: 11),
                        textAlign: TextAlign.end,),
                      ],
                    ),
                    // Widget to display the list of project
                  ],
                ),
              ),
            );
          },
        );
      },
     // future: loadMemo(),
    );
  }



}
