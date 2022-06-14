import 'package:example2/data/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class TodoWritePage extends StatefulWidget {
  final Todo todo;

  const TodoWritePage({Key? key, required this.todo}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TodoWritePageState();
  }
}

class _TodoWritePageState extends State<TodoWritePage> {
  // input 변경 위한 컨트롤러
  TextEditingController nameController = TextEditingController();
  TextEditingController memoController = TextEditingController();
  int colorIndex = 0;
  int ctIndex = 0;

// 이 위젯이 처음 생성될 때 발생해야하는 함수
  @override
  void initState() {
    super.initState();
    nameController.text = widget.todo.title;
    memoController.text = widget.todo.memo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 앱바 오른쪽에 액션 넣기
        actions: [
          TextButton(
              onPressed: () {
                // 페이지 저장시 사용
                widget.todo.title = nameController.text;
                widget.todo.memo = memoController.text;
                Navigator.of(context).pop(widget.todo);
              },
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: ListView.builder(
          itemBuilder: (ctx, index) {
            if (index == 0) {
              return Container(
                child: Text(
                  "Title",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              );
            } else if (index == 1) {
              return Container(
                child: TextField(
                  controller: nameController,
                ),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 1),
              );
            } else if (index == 2) {
              return InkWell(
                  onTap: () {
                    List<Color> colors = [
                      Color(0xFF80d3f4),
                      Color(0xFFa794fa),
                      Color(0xFFfb91d1),
                      Color(0xFFfb8a94),
                      Color(0xFFfebd9a),
                      Color(0xFF51e29d),
                      Color(0xFFFFFFFF),
                    ];
                    widget.todo.color = colors[colorIndex].value;
                    colorIndex++;
                    // 리스트를 계속 돌리기 위해 사용
                    setState(() {
                      colorIndex = colorIndex % colors.length;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "색상",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          // 상위 클래스의 변수에 접근하기 위해 widget이라는 메소드를 사용함!
                          color: Color(widget.todo.color),
                        )
                      ],
                    ),
                  ));
            } else if (index == 3) {
              return InkWell(
                  onTap: () {
                    List<String> category = ["공부", "운동", "취미"];
                    widget.todo.category = category[ctIndex];
                    setState(() {
                      ctIndex = ctIndex % category.length;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "카테고리",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(widget.todo.category)
                      ],
                    ),
                  ));
            } else if (index == 4) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(
                  "메모",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              );
            } else if (index == 5) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                child: TextField(
                  controller: memoController,
                  maxLines: 10,
                  minLines: 10,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                ),
              );
            }
            return Container();
          },
          itemCount: 6),
    );
  }
}
