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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        //Realmに接続
        let realm = try! Realm()
    
        //Todoの一覧を取得する(reversedは)
        todos = realm.objects(Todo.self).reversed()
        
        //画面の更新
        tableView.reloadData()
        
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
        
        return cell
    }
    
    
}
