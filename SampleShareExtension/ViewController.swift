//
//  ViewController.swift
//  SampleShareExtension
//
//  Created by x13089xx on 2017/01/08.
//  Copyright © 2017年 Kosuke Nakamura. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIDocumentInteractionControllerDelegate {
    
    // App Groups
    let suiteName: String = "group.[自分のBundle Identifier].SampleShareExtension"
    let keyName: String = "shareData"
    
    // UIImageView
    @IBOutlet weak var imageView: UIImageView!
    
    // UIDocumentInteractionController
    var documentInteractionController: UIDocumentInteractionController?
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
     * データを取得する
     */
    @IBAction func importButton(_ sender: UIButton) {
        // --------------------
        // データの読み込み（URL）
        // --------------------
        let sharedDefaults: UserDefaults = UserDefaults(suiteName: self.suiteName)!
        if let url = sharedDefaults.object(forKey: self.keyName) as? String {
            // Safari を起動してそのURLに飛ぶ
            UIApplication.shared.open(URL(string: url)!)
            // データの削除
            //sharedDefaults.removeObject(forKey: self.keyName)
        }
        
        /*// --------------------
        // データの読み込み（image）
        // --------------------
        let sharedDefaults: UserDefaults = UserDefaults(suiteName: self.suiteName)!
        if let sharedData = sharedDefaults.object(forKey: self.keyName) {
            let image: UIImage = UIImage(data: sharedData as! Data)!
            self.imageView.image = image
            // データの削除
            sharedDefaults.removeObject(forKey: self.keyName)
        }*/
        
        /*// --------------------
        // データの読み込み（PDF）
        // --------------------
        let sharedDefaults: UserDefaults = UserDefaults(suiteName: self.suiteName)!
        if let sharedData = sharedDefaults.data(forKey: self.keyName) {
            // DocumentDirectory参照パス
            let documentsPath: NSString = NSSearchPathForDirectoriesInDomains(
                FileManager.SearchPathDirectory.documentDirectory,
                FileManager.SearchPathDomainMask.userDomainMask, true).first! as NSString
            
            let filename: String = "test.pdf"
            let filePath = documentsPath.appendingPathComponent(filename)
            // ------------------------------
            // WriteToFile を用いた保存処理
            // ------------------------------
            let success = (try? sharedData.write(to: URL(fileURLWithPath: filePath), options: [.atomic])) != nil
            // 確認
            if success {
                print("Save OK")
            } else {
                print("Save Error")
            }
            
            // NSData を NSURL に変換する
            let pdfFileURL: NSURL = NSURL(fileURLWithPath: filePath)
            
            // ------------------------------
            // 別アプリにPDFデータをImportする
            // ------------------------------
            documentInteractionController = UIDocumentInteractionController(url: pdfFileURL as URL)
            documentInteractionController?.delegate = self
            if !(documentInteractionController?.presentOpenInMenu(from: self.view.frame, in: self.view, animated: true))! {
                // 送信失敗
                let alert = UIAlertController(title: "Error", message: "not found application", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            // データの削除
            //sharedDefaults.removeObject(forKey: self.keyName)
            // ディレクトリ内の test.pdf 削除
            //let fileManager = FileManager.default
            //try! fileManager.removeItem(atPath: filePath)
        }*/
    }

    /**
     * データを削除する
     */
    @IBAction func deleteButton(_ sender: UIButton) {
        let sharedDefaults: UserDefaults = UserDefaults(suiteName: self.suiteName)!
        // データの削除
        sharedDefaults.removeObject(forKey: self.keyName)
        
        // ディレクトリ内の test.pdf 削除
        //let fileManager = FileManager.default
        //try! fileManager.removeItem(atPath: filePath)
    }
    
    /**
     * ドキュメントディレクトリを参照するメソッド
     */
    func getDocumentsDirectory() -> NSString {
        let documentsPath: NSString = NSSearchPathForDirectoriesInDomains(
            FileManager.SearchPathDirectory.documentDirectory,
            FileManager.SearchPathDomainMask.userDomainMask, true).first! as NSString
        return documentsPath
    }
    

}

