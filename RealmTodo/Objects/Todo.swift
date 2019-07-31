//
//  Todo.swift
//  RealmTodo
//
//  Created by 堀川浩二 on 2019/07/30.
//  Copyright © 2019 堀川浩二. All rights reserved.
//

import RealmSwift

class Todo: Object {
    
    // ID （連番）･･･ぜっていにかぶらないデータにする
    @objc dynamic var id: Int = 0
    
    // タイトル
    @objc dynamic var title: String = ""
    
    //　登録日時
    @objc dynamic var date: Date = Date()
    
    
}
