import 'package:example2/data/todo.dart';
import 'package:example2/util.dart';
import 'package:example2/write.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Todo> todos = [
    Todo(
      title: "패스트 캠퍼스 강의 듣기",
      memo: "앱개발 입문 강의 듣기",
      color: Colors.redAccent.value,
      done: 0,
      category: "공부",
      date: 202206006,
    ),
    Todo(
      title: "패스트 캠퍼스 강의 듣기2",
      memo: "앱개발 입문 강의 듣기2",
      color: Colors.blue.value,
      done: 1,
      category: "공부",
      date: 202206006,
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Todo todo = await Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => TodoWritePage(
                      todo: Todo(
                    title: "",
                    color: 0,
                    memo: "",
                    done: 0,
                    category: "",
                    date: Util.getFormatTime(DateTime.now()),
                  ))));
          setState(() {
            todos.add(todo);
          });
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, idx) {
          if (idx == 0) {
            return Container(
              child: Text("오늘하루",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            );
          } else if (idx == 1) {
            // filter 처리 함수 => where
            List<Todo> undone = todos.where((t) {
              return t.done == 0;
            }).toList();
            return Container(
              child: Column(
                  children: List.generate(undone.length, (index) {
                Todo t = undone[index];
                return InkWell(
                  child: TodoCardWidget(t: t),
                  onTap: () {
                    setState(() {
                      if (t.done == 0) {
                        t.done = 1;
                      } else {
                        t.done = 0;
                      }
                    });
                  },
                  onLongPress: () async {
                    Todo todo = await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (ctx) => TodoWritePage(todo: t)));
                    setState(() {});
                  },
                );
              })),
            );
          } else if (idx == 2) {
            return Container(
              child: Text("완료된 하루",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            );
          } else if (idx == 3) {
            List<Todo> done = todos.where((t) {
              return t.done == 1;
            }).toList();
            return Container(
              child: Column(
                  children: List.generate(done.length, (index) {
                Todo t = done[index];
                return InkWell(
                  child: TodoCardWidget(t: t),
                  onTap: () {
                    setState(() {
                      if (t.done == 0) {
                        t.done = 1;
                      } else {
                        t.done = 0;
                      }
                    });
                  },
                  onLongPress: () async {
                    Todo todo = await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (ctx) => TodoWritePage(todo: t)));
                    setState(() {});
                  },
                );
              })),
            );
          }
          return Container();
        },
        itemCount: 4,
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.today), label: "오늘"),
        BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined), label: "기록"),
        BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "더 보기"),
      ]),
    );
  }
}

class TodoCardWidget extends StatelessWidget {
  final Todo t;
  TodoCardWidget({Key? key, required this.t}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color(t.color), borderRadius: BorderRadius.circular(16)),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.title,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(t.done == 0 ? "미완료" : "완료",
                  style: TextStyle(color: Colors.white))
            ],
          ),
          Container(
            height: 12,
          ),
          Text(t.memo)
        ]));
  }
}
