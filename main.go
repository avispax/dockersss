package main

import (
	"database/sql"
	"dbsample/models"
	"fmt"
	"log"

	_ "github.com/go-sql-driver/mysql"
)

func insert(db *sql.DB) {

	// データを挿入する
	article1 := models.Article{
		Title:    "insert test",
		Contents: "Can I insert data correctry?",
		UserName: "saki",
	}
	const sqlStr1 = `
	insert into articles (title, contents, username, nice, created_at) values (?, ?, ?, 0, now())
	`

	result, err := db.Exec(sqlStr1, article1.Title, article1.Contents, article1.UserName)
	if err != nil {
		log.Fatal(err)
		return
	}
	fmt.Println(result.LastInsertId())
	fmt.Println(result.RowsAffected())

}

func selectData(db *sql.DB) {
	// データを取得する。
	articleID := 2
	const sqlStr2 = `select * from articles where article_id = ?;`
	row := db.QueryRow(sqlStr2, articleID)
	if err := row.Err(); err != nil {
		log.Fatal(err)
	}

	log.Println("select query")

	var article2 models.Article
	var createdTime sql.NullTime

	err := row.Scan(&article2.ID, &article2.Title, &article2.Contents, &article2.UserName, &article2.NiceNum, &createdTime)
	if err != nil {
		log.Fatal(err)
	}

	log.Println("scan end")

	if createdTime.Valid {
		article2.CreatedAt = createdTime.Time
	}

	fmt.Printf("%+v\n", article2)
}

func main() {
	dbUser := "docker"
	dbPassword := "docker"
	dbDatabase := "test_db"
	dbConn := fmt.Sprintf("%s:%s@tcp(127.0.0.1:3306)/%s?parseTime=true", dbUser, dbPassword, dbDatabase)

	db, err := sql.Open("mysql", dbConn)
	if err != nil {
		fmt.Println(err)
	}

	defer db.Close()

	log.Println("DB - open")

	// 接続確認コード
	// if err := db.Ping(); err != nil {
	// 	fmt.Println(err)
	// } else {
	// 	fmt.Println("Connect DB!!!")
	// }

	// データを挿入する
	// insert(db)

	// データを取得する。
	selectData(db)

	// ここからトランザクションを試す。（p.172）
	// トランザクションの開始
	tx, err := db.Begin()
	if err != nil {
		log.Fatal(err)
	}

	article_id := 1 // 1つ目の投稿
	const sqlGetNice = `
		select nice from articles where article_id = ?;
	`

	row := tx.QueryRow(sqlGetNice, article_id)
	if err := row.Err(); err != nil {
		// 失敗したらRollback
		fmt.Println(err)
		tx.Rollback()
		return
	}

	// 変数 nice_num にいいねの数を読み込み
	var nice_num int
	err = row.Scan(&nice_num)

	if err != nil {
		fmt.Println(err)
		tx.Rollback()
		return
	}

	// いいね数を +1 する
	const sqlUpdateNiceNum = `update articles set nice = ? where article_id = ?`
	_, err = tx.Exec(sqlUpdateNiceNum, nice_num+1, article_id)
	if err != nil {
		fmt.Println(err)
		tx.Rollback()
		return
	}

	tx.Commit()

	log.Println("END")
}
