//
//  ColorCollectionViewController.swift
//  To Do list
//
//  Created by Chihiro Nishiwaki on 2020/06/07.
//  Copyright © 2020 Nishiwaki sen. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ColorCollectionViewController: UICollectionViewController {
    
    //色情報
    let colorData: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "10", "11", "12", "13"]
    let redData: [Int] = [255, 255, 196, 255, 255, 119, 255, 245, 223, 145, 226, 159, 35, 150, 40, 20, 183, 25, 45, 160, 23, 127, 189, 41, 255, 255, 78, 250, 240, 186, 138, 77, 25]
    let greenData: [Int] = [56, 173, 69, 173, 214, 46, 250, 245, 210, 255, 255, 176, 255, 206, 183, 255, 255, 114, 45, 196, 148, 0, 178, 52, 56, 198, 14, 250, 240, 184, 148, 77, 25]
    let blueData: [Int] = [56, 173, 54, 96, 165, 37, 86, 193, 151, 35, 198, 131, 145, 180, 141, 255, 255, 120, 230, 255, 172, 255, 255, 98, 255, 255, 46, 250, 240, 189, 155, 77, 25]
    
    //色つなぎ変数
    var color: String!
    var red: CGFloat!
    var green: CGFloat!
    var blue: CGFloat!

    //Userdefaults保存用配列
    var colorArray: [String] = []
    var redArray: [CGFloat] = []
    var greenArray: [CGFloat] = []
    var blueArray: [CGFloat] = []
    
    //Userdefalts読み込み
    let saveData = UserDefaults.standard
    
    //SelectViewControllerから渡されるデータを入れる変数
    var receiveSelectNumber: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SelectViewControllerからのデータ受け取り

        
        
        //色関係：Userdefaultの初期設定
        saveData.register(defaults: ["color": ["white", "red", "yellow", "green"],
                                     "red": [1.0, 1.0, 1.0, 0.0],
                                     "green": [1.0, 0.0, 0.94, 0.53],
                                     "blue": [1.0, 0.0, 0.0, 0.2]] )
        //Userdefaltsから取り出し
        colorArray = saveData.array(forKey: "color") as! [String]
        redArray = saveData.array(forKey: "red") as! [CGFloat]
        greenArray = saveData.array(forKey: "green") as! [CGFloat]
        blueArray = saveData.array(forKey: "blue") as! [CGFloat]
        
        //レイアウト設定
        let layout = UICollectionViewFlowLayout()
        //cellの大きさ
        layout.itemSize = CGSize(width: self.view.bounds.width / 3 - 30, height: self.view.bounds.width / 3 - 20)
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
        
        //画面背景色の指定
        self.collectionView.backgroundColor = UIColor(red: redArray[0], green: greenArray[0], blue: blueArray[0], alpha: 1.0)
        

        // Do any additional setup after loading the view.
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

    //セルの数を返す関数
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return colorData.count
    }

    //cellに情報を入れていく関数
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as! ColorCollectionViewCell
        
        //colorcircleのラベル背景色を設定
        cell.colorcircle.backgroundColor = UIColor(red: CGFloat(redData[indexPath.item]) / 255.0, green: CGFloat(greenData[indexPath.item]) / 255.0, blue: CGFloat(blueData[indexPath.item]) / 255.0, alpha: 1.0)
        //ラベル角丸
        cell.colorcircle.layer.cornerRadius = self.view.bounds.width / 3 - 60
        
        //nameのテキスト設定
        cell.name.text = colorData[indexPath.item]
        
        //背景色白
        cell.backgroundColor = UIColor.white

        // Configure the cell"
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        color = colorData[indexPath.item]
        red = CGFloat(redData[indexPath.item]) / 255.0
        green = CGFloat(greenData[indexPath.item]) / 255.0
        blue = CGFloat(blueData[indexPath.item]) / 255.0
        
        //前画面で押したのに沿ったindentを更新してあげよう！！！！！！！！！！！！！！！！！！！！
        colorArray[receiveSelectNumber] = color
        redArray[receiveSelectNumber] = red
        greenArray[receiveSelectNumber] = green
        blueArray[receiveSelectNumber] = blue
        
        //UserDefaultsに保存
        saveData.set(colorArray, forKey: "color")
        saveData.set(redArray, forKey: "red")
        saveData.set(greenArray, forKey: "green")
        saveData.set(blueArray, forKey: "blue")
        
        //ひとつ前に戻る
        self.navigationController?.popViewController(animated: true)

        
        
        //同じstororyboard内ですよ〜
        //let storyboard: UIStoryboard = self.storyboard!
        //ここで移動先のstoryboardを選択
        //let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
        //実際に移動するコード
        //self.present(viewController, animated: false, completion: nil)
        


        
        
    }
    
    //戻るボタン
    @IBAction func cancle () {
        //ひとつ前に戻る
        self.navigationController?.popViewController(animated: true)
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
