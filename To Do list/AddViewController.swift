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
    var dateArray: [String] = []
    var importanceArray: [Bool] = []
    
    //日時入力
    //UItextFieldに紐付け
    @IBOutlet weak var dateField: UITextField!
    //UIDatePickerを定義するための関数
    var datePicker: UIDatePicker = UIDatePicker()
    
    //この追加ページに来たときに毎回一番最初に発動されるfunc
    override func viewDidLoad() {
        super.viewDidLoad()
        //もしも中身が入ってたら（空じゃなかったら）、スマホの保存場所から取り出して,それぞれの配列に代入する
        if saveData.array(forKey: "name") != nil {
            nameArray = saveData.array(forKey: "name") as! [String]
        }
        if saveData.array(forKey: "date") != nil {
            dateArray = saveData.array(forKey: "date") as! [String]
        }
        if saveData.array(forKey: "importance") != nil {
            importanceArray = saveData.array(forKey: "importance") as! [Bool]
        }
        
        //ピッカー設定!!！！！日付に関してよくわかってへんよ！！！！！！！！！！！
        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        dateField.inputView = datePicker
        
        //決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spaceItem, doneItem], animated: true)
        
        //インプットビュー設定UITexfieldへ代入
        dateField.inputView = datePicker
        dateField.inputAccessoryView = toolbar
        
    }
    
    //UIDatePickerのDaneで発動
    @objc func done() {
        dateField.endEditing(true)
        
        //日付フォーマット
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:MM"
        
        dateField.text = "\(formatter.string(from: datePicker.date))"
    }
    
    //スイッチボタン
    var importance: Bool! = true
    @IBOutlet var output: UILabel!
    @IBAction func onoffswitch(_ sender: UISwitch){
        if sender.isOn {
            output.text = "重要"
            importance = true
        }else {
            output.text = "重要でない"
            importance = false
        }
    }
    
    
    //保存ボタンが押されたときに発動
    @IBAction func saveList() {
        //空でないかチェック！！！！！これだとスペースが入ってたら大丈夫になっちゃう！！！！！
        if name.text != "" && dateField.text != ""{
            if nameArray[0] == "" {
                nameArray[0] = String(name.text!)
                dateArray[0] = String(dateField.text!)
                importanceArray[0] = Bool(importance!)
            }else{
                nameArray.append(String(name.text!))
                dateArray.append(String(dateField.text!))
                importanceArray.append(Bool(importance!))
            }
            saveData.set(nameArray, forKey: "name")
            saveData.set(dateArray, forKey: "date")
            saveData.set(importanceArray, forKey: "importance")
            name.text = ""
            dateField.text = ""
            importance = true
            self.dismiss(animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "エラー", message: "項目を全て埋めてください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
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
