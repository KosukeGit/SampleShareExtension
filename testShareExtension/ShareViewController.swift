//
//  ShareViewController.swift
//  testShareExtension
//
//  Created by x13089xx on 2017/01/08.
//  Copyright © 2017年 Kosuke Nakamura. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {
    
    // App Groups
    let suiteName: String = "group.[自分のBundle Identifier].SampleShareExtension"
    let keyName: String = "shareData"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // titleName
        self.title = "テスト"
        
        // color
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor(red:1.0, green:0.75, blue:0.5, alpha:1.0)
        
        // postName
        let controller: UIViewController = self.navigationController!.viewControllers.first!
        controller.navigationItem.rightBarButtonItem!.title = "保存"
    }
    
    /**
     * 文字入力されていないとPostを無効にする
     */
    override func isContentValid() -> Bool {
        self.charactersRemaining = self.contentText.characters.count as NSNumber!
        
        let canPost: Bool = self.contentText.characters.count > 0
        if canPost {
            return true
        }
        
        return false
    }
    
    /**
     * Postを押した後の処理
     */
    override func didSelectPost() {
        let extensionItem: NSExtensionItem = self.extensionContext?.inputItems.first as! NSExtensionItem
        let itemProvider = extensionItem.attachments?.first as! NSItemProvider
        
        let puclicURL = String(kUTTypeURL)  // "public.url"
        
        // shareExtension で NSURL を取得
        if itemProvider.hasItemConformingToTypeIdentifier(puclicURL) {
            itemProvider.loadItem(forTypeIdentifier: puclicURL, options: nil, completionHandler: { (item, error) in
                // NSURLを取得する
                if let url: NSURL = item as? NSURL {
                    // ----------
                    // 保存処理
                    // ----------
                    let sharedDefaults: UserDefaults = UserDefaults(suiteName: self.suiteName)!
                    sharedDefaults.set(url.absoluteString!, forKey: self.keyName)  // そのページのURL保存
                    sharedDefaults.synchronize()
                }
                self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
            })
        }
    }
    
    /*/**
     * Postを押した後の処理
     */
    override func didSelectPost() {
        let extensionItem: NSExtensionItem = self.extensionContext?.inputItems.first as! NSExtensionItem
        let itemProvider = extensionItem.attachments?.first as! NSItemProvider
        
        let puclicURL = String(kUTTypeURL)  // "public.url"
        
        // shareExtension で NSURL を取得
        if itemProvider.hasItemConformingToTypeIdentifier(puclicURL) {
            itemProvider.loadPreviewImage(options: nil, completionHandler: { (item, error) in
                // 画像を取得する
                if let image = item as? UIImage {
                    // ----------
                    // 保存処理
                    // ----------
                    let sharedDefaults: UserDefaults = UserDefaults(suiteName: self.suiteName)!
                    sharedDefaults.set(UIImagePNGRepresentation(image), forKey: self.keyName)  // そのページの画像をPNGで保存
                    sharedDefaults.synchronize()
                }
                self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
            })
        }
    }*/
    
    /*/**
     * Postを押した後の処理
     */
    override func didSelectPost() {
        let extensionItem: NSExtensionItem = self.extensionContext?.inputItems.first as! NSExtensionItem
        let itemProvider = extensionItem.attachments?.first as! NSItemProvider
        
        let publicPDF = String(kUTTypePDF)  // "public.pdf"
        
        // shareExtension で NSURL を取得
        if itemProvider.hasItemConformingToTypeIdentifier(publicPDF) {
            itemProvider.loadItem(forTypeIdentifier: publicPDF, options: nil, completionHandler: { (item, error) in
                // NSURLを取得する
                if let url: NSURL = item as? NSURL {
                    do {
                        // NSData に変換する
                        let data: NSData = try NSData(contentsOf: url as URL)
                        print(data)
                        // ----------
                        // 保存処理
                        // ----------
                        let sharedDefaults: UserDefaults = UserDefaults(suiteName: self.suiteName)!
                        sharedDefaults.set(data, forKey: self.keyName)  // NSDataで保存
                        sharedDefaults.synchronize()
                        
                        print("save ok")
                    } catch {
                        print("erorr")
                    }
                }
                self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
            })
        }
    }*/
    
    /**
     * 追加項目のリスト管理
     */
    override func configurationItems() -> [Any]! {
        return []
    }
    
}
