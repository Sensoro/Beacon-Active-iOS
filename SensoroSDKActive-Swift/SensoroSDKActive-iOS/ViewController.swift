//
//  ViewController.swift
//  SensoroSDKActive-iOS
//
//  Created by David Yang on 15/4/8.
//  Copyright (c) 2015年 Sensoro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var actionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Do any additional setup after loading the view, typically from a nib.
        if SENLocationManager.sharedInstance.started == true{
            actionButton.setTitle("结束监测", for: .normal);
        }else{
            actionButton.setTitle("启动监测", for: .normal);
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func star(_ sender: AnyObject) {
        
        if SENLocationManager.sharedInstance.started == false{
            actionButton.setTitle("结束监测", for: .normal);
            SENLocationManager.sharedInstance.startMonitor(relaunch: false);
        }else{
            actionButton.setTitle("启动监测", for: .normal);
            SENLocationManager.sharedInstance.stopMonitor();
        }
    }

    @IBAction func saveToAlbum(sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(image.image!,
                                       self,#selector(image(image:didFinishSavingWithError:contextInfo:)),nil);
    }
    
    //
    @objc func image(image : UIImage, didFinishSavingWithError error : NSError!, contextInfo info: UnsafeRawPointer) {
        if error == nil {
            let alert = UIAlertView(title: "提示", message: "保存成功", delegate: nil, cancelButtonTitle: "OK");
            alert.show();
        }else{
            let alert = UIAlertView(title: "提示", message: "保存失败", delegate: nil, cancelButtonTitle: "OK");
            alert.show();
        }
    }
}

