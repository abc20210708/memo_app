import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memo_app/screens/edit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(), //애니메이션
        children: [
          Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: Text("MEMO", style: TextStyle(
                fontSize: 36, color: Colors.black87
              ),),
              )
            ],
          ),
          ...LoadMemo() ///... 반복
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => EditPage())
          );
        },
        tooltip: '메모를 추가하려면 클릭하세요',
        label: Text("메모 추가"),
        icon: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> LoadMemo() {
    List<Widget> memoList = [];
    memoList.add(Container(color: Colors.purpleAccent, height: 100,));
    return memoList;
  }
}