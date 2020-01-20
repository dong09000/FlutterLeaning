// 函数

/*
*
* Dart是一种真正的面向对象的语言，所以即使是函数也是对象，并且有一个类型Function。
* 这意味着函数可以赋值给变量或作为参数传递给其他函数，这是函数式编程的典型特征。*/

// 1、函数声明
var _nobleGases = ['dyf', 'gyc', 'sr'];

bool isNoble(int atomicNumber) {
  return _nobleGases[atomicNumber] != null;
}

// Dart函数声明如果没有显式声明返回值类型时会默认当做dynamic处理，注意，函数返回值没有类型推断

//isNoble(int atomicNumber) {
//  return _nobleGases[atomicNumber] != null;
//}

typedef bool CALLBACK(); // 实际上就是 CALLBACK 必须是 返回值为 bool的函数，用来测试两种 isNoble 的区别
void testLearning004(CALLBACK cb) {
  print(cb());
}


// 2.对于只包含一个表达式的函数，可以使用简写语法
//bool isNoble(int atomicNumber) => _nobleGases[atomicNumber] != null;
void testLearning005(int printNum) => print(printNum);

// 3.函数可以作为变量（它是对象，当然能了, 类似block变量 ）
var testLearning006 = (str) {
  print(str);
};

// 4.可做参数（同上）
void testLearning007(var callback) {
  callback();
}

// 5.可选位置参数 nullable
// 包装一组函数参数，用[]标记为可选的位置参数，并放在参数列表的最后面：
void testLearning008(String from, String msg, [String device]) {
  var result = '$from said $msg';
  if (device != null && device.length > 0) {
    result = '$result with a $device';
  }
  print(result);
}
// 可选参数是否可以放前面？ 否
void testLearning009(String from, String msg, [String device, String heihei]) {
  var result = '$from said $msg';
  if (device != null && device.length > 0) {
    result = '$result with a $device';
  }
  print(result);
}

// 6.可选的命名参数
// 定义函数时，使用{param1, param2, …}，放在参数列表的最后面，用于指定命名参数。例如:
void testLearning010({bool bold = false, bool hidden}) {
  // 调用函数时，可以使用指定命名参数
  // 例如 testLearning010(bold: true, hidden: false);
  print(bold);
  print(hidden);
}

// 注意：不能同时使用可选的位置参数和可选的命名参数 （中括号[]与大括号{}互斥）