//
//  NCAlertView.h
//  NCAlertView
//
//  Created by 2345 on 2019/7/26.
//  Copyright © 2019 chenxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NCAlertView : UIView

@property (nonatomic, copy)dispatch_block_t woZhiDaoLeBlock;
@property (nonatomic, copy)dispatch_block_t guanBiBlock;
@property (nonatomic, copy)dispatch_block_t huFuBlock;

- (void)showAlertViewWithTitle:(NSString *)titleString
                       content:(NSString *)contentString
                       redText:(NSString *)redText
                    knowButton:(NSString *)knowBtnText
                     imageName:(NSString *)imageName;

- (void)showDaiXXXAlertViewWithTitle:(NSString *)titleString
                             content:(NSString *)contentString
                             redText:(NSString *)redText
                          knowButton:(NSString *)knowBtnText
                           imageName:(NSString *)imageName;

- (void)showHuifuAlertViewWithTitle:(NSString *)titleString
                            content:(NSString *)contentString
                            redText:(NSString *)redText
                         knowButton:(NSString *)knowBtnText
                        huiFuButton:(NSString *)huFuBtnText
                          imageName:(NSString *)imageName;
- (void)dismissAlertView;

@end

