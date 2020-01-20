// ====变量声明====

// 1 var (网络部分资料有误)
void testLearning001() {
  // var 在声明时不确定值的类型的话，则与dynamic用法类似
  var x;
  x = true;
  x = 1;
  x = 'xxoo';


  // var 在声明时赋值，则类型确定，与String、int等用法类似
  var t = 'string type';
  t = 'xxoo';
  print(t);
  // 下面代码在dart中会报错，因为变量t的类型已经确定为String，
  // 类型一旦确定后则不能再更改其类型。
  //t = false;
}

// 2 dynamic和Object【联想 id、 NSObject】
void testLearning002() {
  // 相同点
  dynamic t = true;
  Object x = false;
  print(t.runtimeType);
  print(x.runtimeType);
  t = "hi world";
  x = 'Hello Object';
  print(t.runtimeType);
  print(x.runtimeType);
  //下面代码没有问题x
  t = 1000;
  x = 1000;
  print(t.runtimeType);
  print(x.runtimeType);

  // 不同点
  // 无警告
  //t.length;
  // 有警告  The getter 'length' is not defined for the class 'Object'
  //x.length;
}

// 3 final和const
void testLearning003() {
  // const 变量是一个编译时常量，final变量在第一次使用时被初始化
  //可以省略String这个类型声明
  final str = "hi world";
//final String str = "hi world";
  const str1 = "hi world";
//const String str1 = "hi world";


  final name = _getName();
  // 整不了
  //const cname = _getName();
}

String _getName() {
  return 'dyf';
}

/*
* var/dynamic/const/final 变量名称 = 赋值;
* 这种都是类型推导型赋值
* */