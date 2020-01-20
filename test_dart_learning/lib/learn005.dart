import 'package:flutter/material.dart';

/* 让 helloworld 的样式更好看 */
Center betterHelloWorld() {
  return Center(
    child: Text(
      'Hello World',
      textDirection: TextDirection.ltr,
      style: TextStyle(fontSize: 36),
    ),
  );
}

/* 添加app风格的整体布局 */
MaterialApp getAppStyleWidget() {
  return MaterialApp(
    title: '安卓用的',
    home: Scaffold(
      appBar: AppBar(
        title: Text("导航栏标题"),
      ),
      body: Center(
        child: Text(
          "Hello World",
          textDirection: TextDirection.ltr,
          style: TextStyle(fontSize: 36),
        ),
      ),
    ),
  );
}

/* 更复杂一些的页面 */
MaterialApp getMoreComplicatedAppStyleWidget() {
  return MaterialApp(
    title: '安卓用的',
    home: Scaffold(
      appBar: AppBar(
        title: Text("导航栏标题"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Hello World",
              textDirection: TextDirection.ltr,
              style: TextStyle(fontSize: 36),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Checkbox(
                    value: true,
                    onChanged: (value) => print("Hello World")),
                Text(
                  "同意协议",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(fontSize: 20),
                )
              ],
            )

        ]
        )
      ),
    ),
  );
}

/* StatelessWidget创建我们自己的Widget */
class MyStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 返回我们的Widget要渲染的Widget，比如一个Text Widget
    return getMoreComplicatedAppStyleWidget();
  }
}