// 异步支持

/*
Dart类库有非常多的返回Future或者Stream对象的函数。
这些函数被称为异步函数：
它们只会在设置好一些耗时操作之后返回，比如像 IO操作。而不是等到这个操作完成。

async和await关键词支持了异步编程，允许您写出和同步代码很像的异步代码。*/

/*======  Future  ======*/

/*
* Future与JavaScript中的Promise非常相似(iOS PromiseKit: https://github.com/mxcl/PromiseKit)，表示一个异步操作的最终完成（或失败）及其结果值的表示。
* 简单来说，它就是用于处理异步操作的，异步处理成功了就执行成功的操作，异步处理失败了就捕获错误或者停止后续操作。
* 一个Future只会对应一个结果，要么成功，要么失败。
* */

/*
* Future 的所有API的返回值仍然是一个Future对象，所以可以很方便的进行链式调用。
* */

/*
* Future.then
* */
void testLearning011() {
  print(DateTime.now());
  Future.delayed(Duration(seconds: 2),(){
    print(DateTime.now());
    return true;
  }).then((data){
    print(data);
  });
}
/*
Future.catchError
如果异步任务发生错误，我们可以在catchError中捕获错误，我们将上面示例改为：
*/
void testLearning012() {
  print('fuc statrt');
  Future.delayed(Duration(seconds: 2),(){
    //return "hi world!";
    throw AssertionError("Error");
  }).then((data){
    //执行成功会走到这里
    print("success");
  }).catchError((e){
    //执行失败会走到这里
    print(e);
  });
}
/*
类似的
then方法还有一个可选参数onError，我们也可以它来捕获异常
*/
void testLearning013() {
  print('fuc statrt');
  Future.delayed(Duration(seconds: 2), () {
    //return "hi world!";
    throw AssertionError("Error");
  }).then((data) {
    print("success");
  }, onError: (e) {
    print(e);
  });
}

/*
* Future.whenComplete
* 有些时候，我们会遇到无论异步任务执行成功或失败都需要做一些事的场景，
* 比如在网络请求前弹出加载对话框，在请求结束后关闭对话框。
* 这种场景，有两种方法，
* 第一种是分别在then或catch中关闭一下对话框，
* 第二种就是使用Future的whenComplete回调，
* 我们将上面示例改一下
* */

void testLearning014() {
  print('14 func start');
  Future.delayed(Duration(seconds: 2),(){
    return "hi world!";
    throw AssertionError("Error");
  }).then((data){
    //执行成功会走到这里
    print(data);
  }).catchError((e){
    //执行失败会走到这里
    print(e);
  }).whenComplete((){
    //无论成功或失败都会走到这里
    print('when complete');
  });
}

/*
* Future.wait [这里可以参考gcd、NSOpearationQueue]
* 有些时候，我们需要等待多个异步任务都执行结束后才进行一些操作，
* 比如我们有一个界面，需要先分别从两个网络接口获取数据，
* 获取成功后，我们需要将两个接口数据进行特定的处理后再显示到UI界面上，应该怎么做？
* 答案是Future.wait，
* 它接受一个Future数组参数，只有数组中所有Future都执行成功后，才会触发then的成功回调，
* 只要有一个Future执行失败，就会触发错误回调。
* */
void testLearning015() {
  print('15 func start');
  print(DateTime.now());
  Future.wait([
    // 2秒后返回结果
    Future.delayed(Duration(seconds: 2), () {
      return "hello";
    }),
    // 4秒后返回结果
    Future.delayed(Duration(seconds: 4), () {
      return " world";
    })
  ]).then((results){
    print(results[0]+results[1]);
    print(DateTime.now());
  }).catchError((e){
    print(e);
  });
}

/*
* Async/await （iOS原生目前没有想过概念）
* 相关第三方：PromiseKit、coobjc；对应JavaScript中的Promise、Generators
* Dart中的async/await 和JavaScript中的async/await功能和用法是一模一样的，
* */

/*
* 回调地狱(Callback Hell)
* 举例回顾iOS的：支付验证
* 实例演示
* 现在有个需求场景是用户先登录，登录成功后会获得用户ID，
* 然后通过用户ID，再去请求用户个人信息，
* 获取到用户个人信息后，为了使用方便，我们需要将其缓存在本地文件系统
* */
//先分别定义各个异步任务
Future<String> login(String userName, String pwd){
  //用户登录
  return Future.delayed(Duration(milliseconds: 200), (){
    print('login');
    return 'login';
  });
}
Future<String> getUserInfo(String id){
  //获取用户信息
  return Future.delayed(Duration(milliseconds: 200), (){
    print('getUserInfo');
    return 'getUserInfo';
  });
}
Future saveUserInfo(String userInfo){
  // 保存用户信息
  print('saveUserInfo');
  return Future.delayed(Duration(milliseconds: 200), (){
    return 'saveUserInfo completed';
  });
}
/*
* 业务逻辑中有大量异步依赖的情况，将会出现上面这种在回调里面套回调的情况，
* 过多的嵌套会导致的代码可读性下降以及出错率提高，并且非常难维护，这个问题被形象的称为
* 回调地狱（Callback Hell）
* */
void testLearning016() {
  login("alice","******").then((id){
    //登录成功后通过，id获取用户信息
    getUserInfo(id).then((userInfo){
      //获取用户信息后保存
      saveUserInfo(userInfo).then((data){
        //保存用户信息，接下来执行其它操作
          print(data);
      });
    });
  });
}

/*
* 解决回调地狱的两大神器正是
* ECMAScript6引入了Promise，
* 以及ECMAScript7中引入的async/await。
* 而在Dart中几乎是完全平移了JavaScript中的这两者：
* Future相当于Promise，而async/await连名字都没改
* */

/*
* 使用Future消除Callback Hell
* */
void testLearning017() {
  login("alice","******").then((id){
    return getUserInfo(id);
  }).then((userInfo){
    return saveUserInfo(userInfo);
  }).then((e){
    //执行接下来的操作
    print(e);
  }).catchError((e){
    //错误处理
    print(e);
  });
}

/*
* 使用async/await消除callback hell
*
* 无论是在JavaScript还是Dart中，async/await都只是一个语法糖，
* 编译器或解释器最终都会将其转化为一个Promise（Future）的调用链
* */
void testLearning018() async {
  try{
    String id = await login("alice","******");
    String userInfo = await getUserInfo(id);
    String res = await saveUserInfo(userInfo);
    print(res);
    //执行接下来的操作
  } catch(e){
    //错误处理
    print(e);
  }
}