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
            actionButton.setTitle("结束监测", forState: .Normal);
        }else{
            actionButton.setTitle("启动监测", forState: .Normal);
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startMonitor(sender: AnyObject) {
        
        if SENLocationManager.sharedInstance.started == false{
            actionButton.setTitle("结束监测", forState: .Normal);
            SENLocationManager.sharedInstance.startMonitor(false);
        }else{
            actionButton.setTitle("启动监测", forState: .Normal);
            SENLocationManager.sharedInstance.stopMonitor();
        }
    }

    @IBAction func saveToAlbum(sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(image.image,
            self,"image:didFinishSavingWithError:contextInfo:",nil);
    }
    
    //
    func image(image : UIImage, didFinishSavingWithError error : NSError!, contextInfo info: UnsafePointer<Void>) {
        if error == nil {
            let alert = UIAlertView(title: "提示", message: "保存成功", delegate: nil, cancelButtonTitle: "OK");
            alert.show();
        }else{
            let alert = UIAlertView(title: "提示", message: "保存失败", delegate: nil, cancelButtonTitle: "OK");
            alert.show();
        }
    }
}

