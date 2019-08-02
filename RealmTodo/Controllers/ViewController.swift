//
//  ViewController.swift
//  RealmTodo
//
//  Created by 堀川浩二 on 2019/07/30.
//  Copyright © 2019 堀川浩二. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var todos:[Todo] = []
    
    

    fileprivate func reloadTableView() {
        //Realmに接続
        let realm = try! Realm()
        
        //Todoの一覧を取得する(reversedは)
        todos = realm.objects(Todo.self).reversed()
        
        //画面の更新
        tableView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    //画面が表示されるたびに実行
    override func viewWillAppear(_ animated: Bool) {
        reloadTableView()
    }
    
    

    @IBAction func didClickAddBtn(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toNext", sender: nil)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
        
        //セルに矢印をつける
        cell .accessoryType = .disclosureIndicator
        
        return cell
    }
    
    //矢印付きののセルがクリックされたときの処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //クリックされたTodoを取得する
        let todo = todos[indexPath.row]
        performSegue(withIdentifier: "toNext", sender: todo)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "noNext" {
            //次の画面のcontrollerを取得する
            let inputVC = segue.destination as! InputViewController
            
            //次の画面に選択されたTodoを設定
            inputVC.todo = sender as? Todo
        }
    }
}
