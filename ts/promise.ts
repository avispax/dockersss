// https://typescript-jp.gitbook.io/deep-dive/future-javascript/promise
// # 非同期実験 : Promise
function ppppp(msg: string): Promise<any> {
  return new Promise((resolve, reject) => {
    // resolve rejectは Promiseで規定されているコンストラクタの必須要素。
    console.log("Promise Start");
    // resolveに値投入で、ステータスが「FULLFILL」となる。rejectは「REJECTED」。
    msg === "aaa" ? resolve("OK") : reject("reject");
    console.log("Promise end");
  });
}

console.log("before");
ppppp("aaa") // Promiseオブジェクトを返却されている。オブジェクトステータスは「PENDING」。これが見えるかどうかはわからん。デバッグ的な意味で。
  .then((res) => {
    // .then は FULLFILLになったときに呼ばれる。
    console.log(`${res} : aaaaaaaaaaaaaaaaaaaaaa`);
  })
  .catch((err) => {
    // .catch は REJECTED になったら呼ばれる。
    console.log(`${err} : nooooooooooooooooooooooooooooo`);
  });
console.log("after");

// PromiseのTIPS。いきなりresolveする。↓
Promise.resolve(100)
  .then((res) => {
    console.log(`the 1st value is ${res}`);
    return 123;
  })
  .then((res) => {
    console.log(`the 2nd value is ${res}`);
    throw new Error("error happened from 2nd.");
  })
  .then((res) => {
    console.log(`the 3rd value is ${res}`);
    return 456;
  })
  .catch((err) => {
    console.log(`error: ${err}!!!!`);
    return 789;
  });

// ### 並列制御フロー
// 1. 何らかのデータをサーバから読み込むことを再現する処理
function loadItem(id: number): Promise<{ id: number }> {
  return new Promise((resolve) => {
    console.log("loading item", id);
    setTimeout(() => {
      // サーバーからのレスポンス遅延を再現
      resolve({ id: id });
    }, 1000);
  });
}

// 実験. Promiseチェーンによる連結。逐次実行するので1秒 + 1秒 = 2秒かかる。まぁそれはそう。
let item1, item2;
loadItem(1)
  .then((res) => {
    item1 = res;
    return loadItem(2);
  })
  .then((res) => {
    item2 = res;
    console.log("22222222222 : done");
  }); // 全体で 2秒 かかる

// 実験2. 並列処理。配列により同時実施。1秒で終わる。
Promise.all([loadItem(1), loadItem(2)]).then((res) => {
  [item1, item2] = res;
  console.log("allllllllll : done");
}); // 全体で 1秒 かかる

// #### 並列制御2。最初に終わったやつが勝ち。
var task1 = new Promise(function (resolve, reject) {
  setTimeout(resolve, 1000, "one");
});
var task2 = new Promise(function (resolve, reject) {
  setTimeout(resolve, 2000, "two");
});

Promise.race([task1, task2]).then(function (value) {
  console.log(value); // "one"
  // 両方ともresolveされるが、task1の方が早く終わり、2はどっかで死ぬ。
});
