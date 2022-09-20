import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:memo_app/database/memo.dart';
import 'package:memo_app/database/db.dart';

class ViewPage extends StatelessWidget {
  const ViewPage({Key? key,required this.id}) : super(key: key);

  final String id;
  //findMemo(id);

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
              onPressed: (){},
              icon: const Icon(Icons.edit)
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: LadBuilder()
      ),
    );

  }

  Future<List<Memo>> loadMemo(String id) async {
    DBHelper sd = DBHelper();
    return await sd.findMemo(id);
  }

  LadBuilder() {
   return FutureBuilder<List<Memo>>(
        future: loadMemo(id),
        builder: (BuildContext context, AsyncSnapshot<List<Memo>> snapshot) {
          if (snapshot.hasData == null) {
            return Container(
             child: Text("데이터를 불러올 수 없습니다."),
            );
          } else {
            Memo memo = snapshot.data![0];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(memo.title,
                style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold
                ),
                ),
                Text("메모 추가한 시간: " +memo.createTime.split('.')[0],
                  style: TextStyle(
                    fontSize: 11
                  ),
                  textAlign: TextAlign.end,
                ),
                Text("메모 수정 시간: "+memo.editTime.split('.')[0],
                  style: TextStyle(
                      fontSize: 11
                  ),
                  textAlign: TextAlign.end,
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                Expanded(
                    child: Text(memo.text)),
              ],
            );
          }
   },
   );
  }
}//class
