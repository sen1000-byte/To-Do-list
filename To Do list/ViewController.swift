//
//  ViewController.swift
//  To Do list
//
//  Created by Chihiro Nishiwaki on 2020/05/23.
//  Copyright © 2020 Nishiwaki sen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var namelabel1: UILabel!
    @IBOutlet var datelabel1: UILabel!
    @IBOutlet var deadlinelabel1: UILabel!
    @IBOutlet var namelabel2: UILabel!
    @IBOutlet var datelabel2: UILabel!
    @IBOutlet var fusen1: UILabel!
    
    
    var nameArray: [String?] = []
    var dateArray: [String?] = []
    var importanceArray: [Bool?] = []
    //スマホの保存場所から取り出し
    let saveData = UserDefaults.standard
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //！！！！！！！空白の時ように?? [] を付け加えてみたけれど、どう作用するかはわからない！！！！！！！！
        nameArray = (saveData.array(forKey: "name") ?? [""]) as [String]
        dateArray = (saveData.array(forKey: "date") ?? [""]) as [String]
        importanceArray = (saveData.array(forKey: "importance") ?? [false]) as [Bool]
        
        //残り時間を計算する
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ja_JP")
        dateFormater.dateFormat = "yyyy/MM/dd HH:mm"

        if dateArray[0] != "" {
            //締切日を取得する
            let date = dateFormater.date(from: dateArray[0]!)!
            let currentDate = Date()
            //差を計算する
            let cal = Calendar(identifier: .gregorian)
            let difference = cal.dateComponents([.minute], from: currentDate, to: date)
            // 書式を設定する
            let formatter = DateComponentsFormatter()
            // 表示単位を指定
            formatter.unitsStyle = .abbreviated
            // 表示する時間単位を指定
            formatter.allowedUnits = [.hour, .minute]
            deadlinelabel1.text = (formatter.string(from: difference)!)
            
            //色変化をする
            let defferenceInt: Int = difference.minute!
            if defferenceInt <= 1440 || importanceArray[0]! == true {
                fusen1.backgroundColor = UIColor.red
            }else if defferenceInt <= 4320 {
                fusen1.backgroundColor = UIColor.yellow
            }else{
                fusen1.backgroundColor = UIColor.green
            }
            
            
        }else{
            deadlinelabel1.text = ""
            fusen1.backgroundColor = UIColor.blue
        }
        
        
        
        
        //１つ目のふせんコーナー
        if nameArray[0] != "" && dateArray[0] != "" {
            
            namelabel1.text = nameArray[0]
            datelabel1.text = dateArray[0]
        }else {
            namelabel1.text = ""
            datelabel1.text = ""
        }
        //2つ目のふせんコーナー
        if nameArray.count >= 2 && dateArray.count >= 2 {
            namelabel2.text = nameArray[1]
            datelabel2.text = dateArray[1]
        }else {
            namelabel2.text = ""
            datelabel2.text = ""
        }

    }
    
    


    

}

