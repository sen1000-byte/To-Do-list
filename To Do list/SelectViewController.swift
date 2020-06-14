//
//  SelectViewController.swift
//  To Do list
//
//  Created by Chihiro Nishiwaki on 2020/06/07.
//  Copyright © 2020 Nishiwaki sen. All rights reserved.
//

import UIKit

class SelectViewController: UIViewController {

    var selectNumber: Int = 0
    
    //背景ラベル（簡略化のため泣）！！！！！！！！！！！！！！！！！！
    @IBOutlet var backgroundColor: UIButton!
    @IBOutlet var oneDayColor: UIButton!
    @IBOutlet var threeDayColor: UIButton!
    @IBOutlet var moreDaysColor: UIButton!
    
    //色系配列
    var colorArray: [String] = []
    var redArray: [CGFloat] = []
    var greenArray: [CGFloat] = []
    var blueArray: [CGFloat] = []
    
    //スマホの保存場所から取り出し
    let saveData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //色関係：Userdefaultの初期設定
        saveData.register(defaults: ["color": ["white", "red", "yellow", "green"],
                                     "red": [1.0, 1.0, 1.0, 0.0],
                                     "green": [1.0, 0.0, 0.94, 0.53],
                                     "blue": [1.0, 0.0, 0.0, 0.2]] )
        //色関係:色取得
        redArray = saveData.array(forKey: "red") as! [CGFloat]
        greenArray = saveData.array(forKey: "green") as! [CGFloat]
        blueArray = saveData.array(forKey: "blue") as! [CGFloat]
        
        backgroundColor.backgroundColor = UIColor(red: redArray[0], green: greenArray[0], blue: blueArray[0], alpha: 1.0)
        oneDayColor.backgroundColor = UIColor(red: redArray[1], green: greenArray[1], blue: blueArray[1], alpha: 1.0)
        threeDayColor.backgroundColor = UIColor(red: redArray[2], green: greenArray[2], blue: blueArray[2], alpha: 1.0)
        moreDaysColor.backgroundColor = UIColor(red: redArray[3], green: greenArray[3], blue: blueArray[3], alpha: 1.0)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func background() {
        selectNumber = 0
        performSegue(withIdentifier: "ToColorCollectionView", sender: self)
    }
    
    @IBAction func oneDay() {
        selectNumber = 1
        performSegue(withIdentifier: "ToColorCollectionView", sender: self)
    }
    
    @IBAction func threeDays() {
        selectNumber = 2
        performSegue(withIdentifier: "ToColorCollectionView", sender: self)
    }
    
    @IBAction func manyDays() {
        selectNumber = 3
        performSegue(withIdentifier: "ToColorCollectionView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToColorCollectionView" {
            let nextcvc = segue.destination as! ColorCollectionViewController
            nextcvc.receiveSelectNumber = selectNumber
        }
    }
    
    @IBAction func cancle () {
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
