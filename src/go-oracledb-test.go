package main

import (
    "database/sql"
    "fmt"

    _ "github.com/mattn/go-oci8"
)

func getDSN() string {
    return "admin/nsfan824u789Fjfoijoj3098j@tutorial1_low" // user/name@host:port/sid
}

func testSelect(db *sql.DB) error {
    rows, err := db.Query("SELECT EMPNO,EMPNAME,GENDER_F FROM emp")
    if err != nil {
        return err
    }

    defer rows.Close()

    for rows.Next() {
        var empno string
        var empname string
        var gender_f int
        rows.Scan(&empno, &empname, &gender_f)
        fmt.Printf("empno:%s empname:%s, gender:%d\n", empno, empname, gender_f)
    }

    return nil
}

func main() {
    db, err := sql.Open("oci8", getDSN())
    if err != nil {
        fmt.Println(err)
        return
    }

    defer db.Close()

    if err = testSelect(db); err != nil {
        fmt.Println(err)
        return
    }
}
