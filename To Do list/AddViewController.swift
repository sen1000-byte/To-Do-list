//
//  AddViewController.swift
//  To Do list
//
//  Created by Chihiro Nishiwaki on 2020/05/23.
//  Copyright © 2020 Nishiwaki sen. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet var name: UITextField!

    
    let saveData = UserDefaults.standard
    
    var nameArray: [String] = []
    var dateArray: [Int] = []
    var importanceArray: [Bool] = []
    
    //この追加ページに来たときに毎回一番最初に発動されるfunc
    override func viewDidLoad() {
        super.viewDidLoad()
        //もしも中身が入ってたら（空じゃなかったら）、スマホの保存場所から取り出して,それぞれの配列に代入する
        if saveData.array(forKey: "name") != nil {
            nameArray = saveData.array(forKey: "name") as! [String]
        }
        if saveData.array(forKey: "date") != nil {
            dateArray = saveData.array(forKey: "date") as! [Int]
        }
        if saveData.array(forKey: "importance") != nil {
            importanceArray = saveData.array(forKey: "importance") as! [Bool]
        }
        // Do any additional setup after loading the view.
    }
    
    
    
    //保存ボタンが押されたときに発動
    @IBAction func saveList() {
        //空でないかチェック！！これだとスペースが入ってたら大丈夫になっちゃう！！
        if name.text != "" {
            nameArray.append(String(name.text!))
            saveData.set(nameArray, forKey: "name")
            name.text = ""
            performSegue(withIdentifier: "toViewController", sender: nil)
        }else{
            let alert = UIAlertController(title: "エラー", message: "項目を全て埋めてください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
