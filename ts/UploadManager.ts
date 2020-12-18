class UploadManager {
  // 疑似シングルトン : アップロード処理中は一つだけ存在するが、処理が終わったら不要なインスタンスになるので破棄できるようなクラス。

  private static instance: UploadManager; // 自身。シングルトンなのでこれが重要。

  private maxParallelNum: number = 0; // なんパラレルでのアップロードが可能か、最大アップロード可能パラレル件数。

  private uploadGroup: { [key: string]: Item[] } = {};
  private currentUploadGroupNum: number = 0;
  private currentItemPosition: number = 0;

  private uploading: boolean = false;
  private constructor() {
    // ここでAWSにアップロード通信情報を問い合わせる。
    // 個別にuploadidを問い合わせているのとは別口です。
  } // コンストラクタ

  static getInstance() {
    // 定番の。
    if (!UploadManager.instance) {
      UploadManager.instance = new UploadManager();
    }

    return UploadManager.instance;
  }

  // アップロード対象となるアイテム一覧の追加。一つの配列の塊で渡す。
  setUploadGrup(items: Item[]) {
    this.uploadGroup["yyyymmdd"] = items;
    //['yyyymmdd':[Item1,Item2,Item3]]のような連想配列となる。
  }

  // 開始の指示。もう開始済みなら何もしないとかな感じか？
  startUpload() {
    if (this.uploading) {
      return true;
    }

    this.uploading = true;

    this.doUpload();
  }

  // 実際にアップロードのあれこれをしているメソッド。ここはスレッドで実施される。
  async doUpload() {
    while (true) {
      await this.isValidUpload();

      // 次の投入対象のオブジェクトを取得する
      let item: Item = this.getNext();

      try {
        await this.GigaCC_DBOperation(item);
      } catch (e) {
        break;
      }
      await AWS_Multipart_Upload(item);
    }
  }

  private GigaCC_DBOperation(item: Item) {
      return new Promise.resolve("aaa");
  }

  private getNext() {
    // 配列を走査するなり、そもそも不要だったりで、とにかく次を返却する。

    return this.uploadGroup[this.currentUploadGroupNum].slice()[
      this.currentItemPosition
    ];
  }

  private isValidUpload() {
    // アップロード対象が存在して、さらにアップロード回線が空いている場合、true
    return true;
  }
}

class Item {
  Item(s: string) {}

  // method
  public DBPush() {
    // GigaCCの論理ファイル・フォルダDBとかを綺麗にする感じのリクエスト
    this.execDB("GET /files/").then("next");

    // AWS登録

    // NGなら
    this.execDB("DELETE /files/id=xxx");
  }
}

//アップロードマネージャを取得（疑似シングルトン的な）
const manager: UploadManager = UploadManager.getInstance();

let items: Item[] = [];

// マネージャーにアイテム群を登録。アイテムは、画面に対してファイルやフォルダをアップロードしたときに生成している、なんというか1レコードのこと。
manager.setUploadGrup(items);

// マネージャー実行
manager.startUpload();
