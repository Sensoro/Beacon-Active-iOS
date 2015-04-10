//
//  ViewController.m
//  SensoroSDKActive-ObjC
//
//  Created by skyming on 15/4/10.
//  Copyright (c) 2015年 Sensoro. All rights reserved.
//

#import "ViewController.h"
#import "SENLocationManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([SENLocationManager sharedInstance].started) {
        [_actionButton setTitle:@"结束检测" forState:UIControlStateNormal];
    }else{
        [_actionButton setTitle:@"启动检测" forState:UIControlStateNormal];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)startMonitor:(id)sender {
    
    if (![SENLocationManager sharedInstance].started) {
        [_actionButton setTitle:@"结束检测" forState:UIControlStateNormal];
        [[SENLocationManager sharedInstance]startMonitor:false];
    }else{
        [_actionButton setTitle:@"启动检测" forState:UIControlStateNormal];
        [[SENLocationManager sharedInstance]stopMonitor];
    }
    
}

- (IBAction)saveToAlbum:(id)sender {
    UIImageWriteToSavedPhotosAlbum(_image.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    
}

@end
