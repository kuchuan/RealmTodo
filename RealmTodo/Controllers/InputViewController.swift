//
//  InputViewController.swift
//  RealmTodo
//
//  Created by 堀川浩二 on 2019/08/02.
//  Copyright © 2019 堀川浩二. All rights reserved.
//

import UIKit
import RealmSwift

class InputViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var button: UIButton!
    
    //前の画面から渡されてきたTodoを受け取る
    var todo: Todo? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(todo)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if todo == nil {
            //新規追加の場合
            button.setTitle("追加", for: .normal)
        } else {
            // 編集の場合
            button.setTitle("更新", for: .normal)
            textField.text = todo?.title
        }
        
    }
    
    
    fileprivate func createNewTodo(_ text: String) {
        //Realmに接続
        let realm = try! Realm()
        //空文字でなければ、データを登録する
        let todo = Todo()
        
        //最大のIDを取得
        //        let id = (realm.objects(Todo.self).max(ofProperty: "id") as Int? ?? 0) + 1 //【三項演算子】これは難しいし、仕事場では怒られる。
        
        //一般的な方法
        //最大のIDを取得
        let id = getMaxId()
        todo.id = id
        todo.title = text
        todo.date = Date()
        
        //作成したTodoを登録する
        try! realm.write {
            realm.add(todo)
        }
    }
    
    fileprivate func updateTodo(_ text: String) {
        //更新
        let realm = try! Realm()
        
        try! realm.write {
            todo?.title = text
        }
    }
    
    @IBAction func didClickBT(_ sender: UIButton) {
        
        //空文字かチェックする（guard let構文ここから）
        guard let text = textField.text else {
            //text.Field.textがnilの場合
            //ボタンがクリックされたときの処理を中断
            return//以降の処理はｓ実行されない
        }//（guard let構文ここまで）
        
        if text.isEmpty {
            //textField.textが空文字の場合
            //ボタンがクリックされたときの処理をちゅづあん
            return //以降のボタンの処理は実行されない
            
        }
        
        
        if todo == nil {
            //新規タスクを追加
            createNewTodo(text)
        } else {
            updateTodo(text)
        }

        
        //前の画面に戻る
        //navigationControllerの持っている履歴から、一つ前の画面に戻る
        navigationController?.popViewController(animated: true)
        
        
    }
    
    
    //最大のIDを取得するメソッド
    func getMaxId() -> Int {
        //Realmに接続
        let realm = try! Realm()
        
        // Todoのシートから最大のIDを取得する(asはInt型に変える?はnilを許容する）
        let id = realm.objects(Todo.self).max(ofProperty: "id") as Int?
        
        if id == nil {
            //最大IDがnil存在しない場合は、1を返す
            return 1
        } else {
            return id! + 1
        }
        
    }

}
