//
//  MainTableViewController.swift
//  To Do list
//
//  Created by Chihiro Nishiwaki on 2020/06/17.
//  Copyright © 2020 Nishiwaki sen. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"

class MainCollectionViewController: UICollectionViewController {
    
    //ラベル系配列
    var nameArray: [String] = []
    var dateArray: [String] = []
    var importanceArray: [Bool] = []
    
    //色系配列
    var colorArray: [String] = []
    var redArray: [CGFloat] = []
    var greenArray: [CGFloat] = []
    var blueArray: [CGFloat] = []

    //スマホの保存場所から取り出し
    let saveData = UserDefaults.standard
    
    //表示させるのに必要な準備
    let screenSize = UIScreen.main.bounds.size
    //var carryDate: DateFormatter
    let dateFormater = DateFormatter()
    
    //realmインスタンスなんかな？作った！
    let realm = try! Realm()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //レイアウト設定
        let layout = UICollectionViewFlowLayout()
        //cellの大きさ
        layout.itemSize = CGSize(width: self.view.bounds.width / 2 - 80, height: self.view.bounds.width / 2 - 100)
        collectionView.collectionViewLayout = layout
        //余白
        layout.sectionInset = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        //横間隔の最小値
        layout.minimumInteritemSpacing = 15
        //縦間隔の最小値
        layout.minimumLineSpacing = 15

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //！！！！！！！空白の時ように?? [] を付け加えてみたけれど、どう作用するかはわからない！！！！！！！！
        //nameArray = (saveData.array(forKey: "name") ?? [""]) as [String]
        //dateArray = (saveData.array(forKey: "date") ?? [""]) as [String]
        //importanceArray = (saveData.array(forKey: "importance") ?? [false]) as [Bool]
        saveData.register(defaults: ["name": [""],
                                     "date": [""],
                                     "importance": [false]])
        
        nameArray = saveData.array(forKey: "name") as! [String]
        dateArray = saveData.array(forKey: "date") as! [String]
        importanceArray = saveData.array(forKey: "importance") as! [Bool]
        
        //色関係：Userdefaultの初期設定
        saveData.register(defaults: ["color": ["white", "red", "yellow", "green"],
                                     "red": [1.0, 1.0, 1.0, 0.0],
                                     "green": [1.0, 0.0, 0.94, 0.53],
                                     "blue": [1.0, 0.0, 0.0, 0.2]] )
        //色関係:色取得
        redArray = saveData.array(forKey: "red") as! [CGFloat]
        greenArray = saveData.array(forKey: "green") as! [CGFloat]
        blueArray = saveData.array(forKey: "blue") as! [CGFloat]
        
        //残り時間を計算するための下準備、記入された日にち（文字）を日付として取得
        //let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ja_JP")
        dateFormater.dateFormat = "yyyy/MM/dd HH:mm"
        
        //背景の色を設定
        self.collectionView.backgroundColor = UIColor(red: redArray[0], green: greenArray[0], blue: blueArray[0], alpha: 1.0)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if nameArray.isEmpty == true || nameArray[0] == "" {
            return 0
        }else{
            return nameArray.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "taskCell", for: indexPath) as! MainCollectionViewCell

        
        //残り時間の計算に入るよ
        //締切日を取得する
        let date = dateFormater.date(from: dateArray[indexPath.item])!
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
        
        //ラベルにに文字入れる

        cell.nameLabel.text = nameArray[indexPath.item]
        cell.dateLabel.text = dateArray[indexPath.item]
        cell.deadlineLabel.text = (formatter.string(from: difference)!)
        
        //cell背景の色を変更する
        //時間さを単位「分」で数字として入手する
        let defferenceInt: Int = difference.minute!
        if defferenceInt <= 1440 || importanceArray[indexPath.item] == true {
            cell.backgroundColor = UIColor(red: redArray[1], green: greenArray[1], blue: blueArray[1], alpha: 1.0)
        }else if defferenceInt <= 4320 {
            cell.backgroundColor = UIColor(red: redArray[2], green: greenArray[2], blue: blueArray[2], alpha: 1.0)
        }else{
            cell.backgroundColor = UIColor(red: redArray[3], green: greenArray[3], blue: blueArray[3], alpha: 1.0)

        }
        
        
        // Configure the cell
    
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //確認アラート表示　はい(ページ移動、保存）、キャンセル（何も）
        let checkAlert = UIAlertController(title: "確認",
                                            message: "このタスクを完了にしていいですか",
                                            preferredStyle: .alert)
        let checkAlertDefault = UIAlertAction(title: "Yes",
                                                style: .default,
                                                handler: {
                                                    (action: UIAlertAction!) -> Void in
                                                //押された時間の取得
                                                let tappedDate = Date()
                                                let tappedDateFormatter = DateFormatter()
                                                tappedDateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
                                                let submitDate = tappedDateFormatter.string(from: tappedDate)
                                                
                                                //Realmに保存するよ
                                                //newcompletedTask　という保存するボックスを作る
                                                let newcompletedTask = completedTasks()
                                                //Realmの各要素に追加してく
                                                newcompletedTask.name = self.nameArray[indexPath.item]
                                                newcompletedTask.date = self.dateArray[indexPath.item]
                                                newcompletedTask.importance = self.importanceArray[indexPath.item]
                                                newcompletedTask.submitDate = submitDate
                                                //Realmに書き込む！
                                                try! self.realm.write{
                                                    self.realm.add(newcompletedTask)
                                                }
                                                
                                                //それぞれの配列から削除
                                                self.nameArray.remove(at: indexPath.item)
                                                self.dateArray.remove(at: indexPath.item)
                                                self.importanceArray.remove(at: indexPath.item)
                                            
                                                //要素を削除した配列ををUserDefaultに上書き保存
                                                self.saveData.set(self.nameArray, forKey: "name")
                                                self.saveData.set(self.dateArray, forKey: "date")
                                                self.saveData.set(self.importanceArray, forKey: "importance")
                                                
                                                //更新
                                                self.collectionView.reloadData()
                                                    
        })
        let checkAlertCancel = UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: nil)
        checkAlert.addAction(checkAlertDefault)
        checkAlert.addAction(checkAlertCancel)
        present(checkAlert, animated: true, completion: nil)
        
        
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
