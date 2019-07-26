//
//  ViewController.m
//  NCAlertView
//
//  Created by 2345 on 2019/7/26.
//  Copyright © 2019 chenxi. All rights reserved.
//

#import "ViewController.h"
#import "NCAlertView/NCAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        NCAlertView *ncView = [[NCAlertView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//        [ncView showAlertViewWithTitle:@"我是弹框" content:@"斯科拉基多拉时间段可拉拉时间段可拉伸机拉时间段可拉伸机拉时间段可拉伸机拉时间段可拉伸机拉时间段可拉伸机拉时间段可拉伸机拉时间段可拉伸机拉时间段可拉伸机拉时间段可拉伸机拉时间段可拉伸机伸机案例看手机点开链接阿斯利康的三大塑料袋阿喀琉斯多久啊时间到了" redText:@"斯科拉"];

        [ncView showHuifuAlertViewWithTitle:@"我是谁呢" content:@"刷卡机大手大脚拉克丝间段可拉伸机拉时间段可拉伸机拉时间段可拉伸机拉时间段可拉伸机拉时间段可拉伸机拉时间段可拉伸机拉时间段可拉伸机拉时间段可拉伸机拉时间段可拉伸机伸机案例看手机点开链接阿斯利康的三大塑料袋阿间段可拉伸机拉时建档立卡所经历的昂克赛拉的接口拉三季度" redText:@"利康的三大" knowButton:@"我知道了" huiFuButton:@"观看视频" imageName:@"huiyuan1"];
    });

}


@end
