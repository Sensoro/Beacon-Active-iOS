//
//  ViewController.swift
//  BeaconActive-Swift
//
//  Created by David Yang on 15/4/3.
//  Copyright (c) 2015年 Sensoro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var actionButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if SENLocationManager.sharedInstance.started == true{
            actionButton.setTitle("结束监测", for: .normal);
        }else{
            actionButton.setTitle("启动监测", for: .normal);
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        //UIApplication.sharedApplication().applicationIconBadgeNumber = 0;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //46D06053-9FAD-483B-B704-E576735CE1A3

    @IBAction func startMonitor(_ sender: AnyObject) {
        
        if SENLocationManager.sharedInstance.started == false{
            actionButton.setTitle("结束监测", for: .normal);
            SENLocationManager.sharedInstance.startMonitor(relaunch: false);
        }else{
            actionButton.setTitle("启动监测", for: .normal);
            SENLocationManager.sharedInstance.stopMonitor();
        }
    }
    
    @IBAction func saveToAlbum(sender: AnyObject) {
//        UIImageWriteToSavedPhotosAlbum(image.image!,
//            self,"image:didFinishSavingWithError:contextInfo:",nil);
    }

    //
    func image(image : UIImage, didFinishSavingWithError error : NSError!, contextInfo info: UnsafeRawPointer) {
        if error == nil {
            let alert = UIAlertView(title: "提示", message: "保存成功", delegate: nil, cancelButtonTitle: "OK");
            alert.show();
        }else{
            let alert = UIAlertView(title: "提示", message: "保存失败", delegate: nil, cancelButtonTitle: "OK");
            alert.show();
        }
    }
}

