// https://typescript-jp.gitbook.io/deep-dive/future-javascript/generators
// # generator 実験

// # その1 : 基本形
function* infiniteSequence() {
  let n = 0;
  while (n < 3) {
    yield n++;
  }
}
// var it = infiniteSequence();
// for (var i = 0; i < 5; i++) {
//   console.log(it.next());
// }

// ## ジェネレータ関数の外部制御
function* generator(n:number) {
  console.log("■■Execution started");
  yield 0;  // yield は いったんここで関数が終わります。
  console.log("■■■Execution resumed");
  yield 1;
  console.log(`■■■■ : ${n} Execution resumed`);
}

// サンプル通り。
// let it = generator(123);
// console.log("■Starting iteration"); // これはジェネレータ関数の本体の前に実行されます
// console.log(it.next()); // { value: 0, done: false }
// console.log(it.next()); // { value: 1, done: false }
// console.log(it.next()); // { value: undefined, done: true }

// ## iterator.next(valueToInject)の例
function* ggg() {
    console.log("ggg start");
    var aaa = yield 'foo';
    console.log(aaa); // 11111
}

function* ccc() {
    // 関数の中身は行けるか → いけた。
    console.log("ccccccccccccccc");
    return 'myCCC';
}

const it = ggg();
// 最初に`yield`された値を取得するまで実行する
const foo = it.next();
console.log(foo.value); // foo
// `bar`を注入して処理を再開する
const nextThing = it.next(ccc().next().value);
