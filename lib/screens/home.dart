import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memo_app/screens/edit.dart';
import 'package:memo_app/database/db.dart';
import 'package:memo_app/database/memo.dart';

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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
            child: Text(
              "MEMO",
              style: TextStyle(fontSize: 36, color: Colors.black87),
            ),
          ),
          Expanded(child: memoBuilder())
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => EditPage()));
        },
        tooltip: '메모를 추가하려면 클릭하세요',
        label: Text("메모 추가"),
        icon: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> LoadMemo() {
    List<Widget> memoList = [];
    memoList.add(Container(
      color: Colors.purpleAccent,
      height: 100,
    ));
    return memoList;
  }

  Future<List<Memo>> loadMemo() async {
    DBHelper sd = DBHelper();
    return await sd.memos();
  }

  Widget memoBuilder() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          return Container(child: Text("메모를 지금 바로 추가해 보세요!"),);
        }
        return ListView.builder(
          itemCount: projectSnap.data!.length,
          itemBuilder: (context, index) {
            Memo memo = projectSnap.data![index];
            return Column(
              children: <Widget>[
                Text(memo.title),
                Text(memo.text),
                Text(memo.editTime),
                // Widget to display the list of project
              ],
            );
          },
        );
      },
      future: loadMemo(),
    );
  }



}
