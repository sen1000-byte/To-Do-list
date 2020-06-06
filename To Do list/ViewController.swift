//
//  ViewController.swift
//  To Do list
//
//  Created by Chihiro Nishiwaki on 2020/05/23.
//  Copyright © 2020 Nishiwaki sen. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    var nameArray: [String?] = []
    var dateArray: [String?] = []
    var importanceArray: [Bool?] = []

    //スマホの保存場所から取り出し
    let saveData = UserDefaults.standard
    
    //表示させるのに必要な準備
    let screenSize = UIScreen.main.bounds.size
    var positionX: CGFloat = 0.0
    var positionY: CGFloat = -130
    
    //realmインスタンスなんかな？作った！
    let realm = try! Realm()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //！！！！！！！空白の時ように?? [] を付け加えてみたけれど、どう作用するかはわからない！！！！！！！！
        nameArray = (saveData.array(forKey: "name") ?? [""]) as [String]
        dateArray = (saveData.array(forKey: "date") ?? [""]) as [String]
        importanceArray = (saveData.array(forKey: "importance") ?? [false]) as [Bool]
        
        //残り時間を計算するための下準備、記入された日にち（文字）を日付として取得
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ja_JP")
        dateFormater.dateFormat = "yyyy/MM/dd HH:mm"
        
        //スクロールのインスタンス
        let scrollView = UIScrollView()
        //scrolViewの大きさ指定
        scrollView.frame = self.view.frame

        //ここの条件どうしたらいいんだろう？!!!!!!!!!!!!!!!!!!!!!!!!!!
        if nameArray[0] != "" && dateArray[0] != "" {
        //if nameArray.isEmpty != true{
            
            //繰り返しを利用して、それぞれのブロックを表示していくよ
            for i in 0 ..< nameArray.count {
                
                //スクロール領域の設定
                scrollView.contentSize = CGSize(width: Int(screenSize.width), height:200 + 130 * nameArray.count / 2 )

                
                //位置を偶数奇数で分ける
                if i % 2 == 0 {
                    positionY += 130
                    positionX = screenSize.width/2 - 180
                }else{
                    positionX = screenSize.width/2 + 10
                }
                let backgroundLabelX = positionX
                let buttomX = positionX + 130
                let labelsX = positionX + 10
                
                //背景ラベルの作成
                let backgroundLabel: UILabel!
                    backgroundLabel = UILabel(frame: CGRect(x: backgroundLabelX, y: positionY + 100, width: 180, height: 100))
                
                //ボタン用背景画像
                let checkimage: UIImage = UIImage(named: "check")!
                let checkimageview: UIImageView = UIImageView(image: checkimage)
                    checkimageview.frame = CGRect(x: buttomX, y: positionY + 165, width: 30, height: 30)

                //ボタンの作成
                let buttom = UIButton()
                buttom.frame = CGRect(x: buttomX, y: positionY + 165, width: 30, height: 30)
                buttom.tag = i
                buttom.addTarget(self, action: #selector(ViewController.buttomTapped(_:)), for: .touchUpInside)

                
                //nameをラベル作成
                let namelabel: UILabel =  UILabel(frame: CGRect(x: labelsX, y: positionY + 105, width: 160, height: 30))
                namelabel.text = nameArray[i]

                
                //日付をラベル作成
                let datelabel = UILabel(frame: CGRect(x: labelsX, y: positionY + 140, width: 150, height: 25))
                datelabel.text = dateArray[i]

                
                //残り時間の計算に入るよ
                //締切日を取得する
                let date = dateFormater.date(from: dateArray[i]!)!
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
                
                //残り時間ラベル作成
                let deadlinelabel = UILabel(frame: CGRect(x: labelsX, y: positionY + 170, width: 100, height: 25))
                deadlinelabel.text = (formatter.string(from: difference)!)

                //背景ラベルの色を変更する
                //時間さを単位「分」で数字として入手する
                let defferenceInt: Int = difference.minute!
                if defferenceInt <= 1440 || importanceArray[i]! == true {
                    backgroundLabel.backgroundColor = UIColor.red
                }else if defferenceInt <= 4320 {
                    backgroundLabel.backgroundColor = UIColor.yellow
                }else{
                    backgroundLabel.backgroundColor = UIColor.green
                }
                
                //背景ラベル表示
                scrollView.addSubview(backgroundLabel)
                //背景ラベルを後ろへ移動
                //self.view.sendSubviewToBack(backgroundLabel)
                //画像表示(scrillViewに追加)
                //self.view.addSubview(checkimageview)
                scrollView.addSubview(checkimageview)
                //ボタン表示(scrillViewに追加)
                scrollView.addSubview(buttom)
                //name表示
                //self.view.addSubview(namelabel)
                scrollView.addSubview(namelabel)
                //日付表示
                scrollView.addSubview(datelabel)
                //残り時間表示
                scrollView.addSubview(deadlinelabel)
                
            }
            
            //xcrollviewをviwのsubviewとして追加
            self.view.addSubview(scrollView)
            self.view.sendSubviewToBack(scrollView)
            


        }else{

        }
        
         print(Realm.Configuration.defaultConfiguration.fileURL!)

    }
    //保存ボタンが押された時の動作
    @objc func buttomTapped(_ sender : UIButton){
        //ボタンのtagを取得
        let buttomtag: Int = sender.tag
        
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
                                                newcompletedTask.name = self.nameArray[buttomtag]!
                                                newcompletedTask.date = self.dateArray[buttomtag]!
                                                newcompletedTask.importance = self.importanceArray[buttomtag]!
                                                newcompletedTask.submitDate = submitDate
                                                //Realmに書き込む！
                                                try! self.realm.write{
                                                    self.realm.add(newcompletedTask)
                                                }
                                                
                                                //それぞれの配列から削除
                                                self.nameArray.remove(at: buttomtag)
                                                self.dateArray.remove(at: buttomtag)
                                                self.importanceArray.remove(at: buttomtag)
                                                
                                                //要素を削除した配列ををUserDefaultに上書き保存
                                                self.saveData.set(self.nameArray, forKey: "name")
                                                self.saveData.set(self.dateArray, forKey: "date")
                                                self.saveData.set(self.importanceArray, forKey: "importance")
                                                
                                                //self.viewDidLoad()
                                                
                                                //self.performSegue(withIdentifier: "homeNavigationController", sender: nil)
                                                self.reset()
                                                
        })
        let checkAlertCancel = UIAlertAction(title: "Cancel",
                                             style: .cancel,
                                             handler: nil)
        checkAlert.addAction(checkAlertDefault)
        checkAlert.addAction(checkAlertCancel)
        present(checkAlert, animated: true, completion: nil)
    }
    
    func reset() {
        let navigationController = self.storyboard?.instantiateViewController(withIdentifier: "homeNavigationController") as! UINavigationController
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: false, completion: nil)
    }
    

    
    


    

}

