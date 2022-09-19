import 'package:flutter/material.dart';

class EditPage extends StatelessWidget {


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
              icon: const Icon(Icons.save)
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
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
}
