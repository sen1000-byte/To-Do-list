//
//  completedTasks.swift
//  To Do list
//
//  Created by Chihiro Nishiwaki on 2020/06/01.
//  Copyright © 2020 Nishiwaki sen. All rights reserved.
//

import Foundation
import RealmSwift

class completedTasks: Object {
    //Realmの　completedTasks という名前のところに、名前、締め切り日、提出日、重要度が保存できる場所を作った
    @objc dynamic var name: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var submitDate: String = ""
    @objc dynamic var importance : Bool = false
}

