//
//  NCAlertView.m
//  NCAlertView
//
//  Created by 2345 on 2019/7/26.
//  Copyright © 2019 chenxi. All rights reserved.
//

#import "NCAlertView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define NC_KAUTOSIZE(_wid,_hei)   CGSizeMake(_wid * ScreenWidth / 375.0, _hei * ScreenHeight / 667.0)
#define NC_kAUTOWIDTH(_wid)  _wid * ScreenWidth / 375.0
#define NC_kAUTOHEIGHT(_hei)      ((CGRectGetHeight([[UIScreen mainScreen] bounds]) >=812.0f)? (YES):(NO) ? _hei * 1 : _hei * ScreenHeight / 667.0)
#define NC_PNCColor(r,g,b) NC_PNCColorRGBA(r,g,b,1.0)
#define NC_PNCColorRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#ifndef PNCisIPHONEX
#define PNCisIPHONEX  ((CGRectGetHeight([[UIScreen mainScreen] bounds]) >=812.0f)? (YES):(NO))
#endif

#ifndef PNCisIPAD
#define PNCisIPAD  ([[UIDevice currentDevice].model isEqualToString:@"iPad"]? (YES):(NO))
#endif

#define Alert_Width NC_kAUTOWIDTH(260)


@interface NCAlertView ()
@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, strong)UIBlurEffect *effectT;
@property (nonatomic, strong)UIVisualEffectView *effectViewT;
@property (nonatomic, strong)UIView *alertView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong)UIWindow *window;
@property (nonatomic, strong)UIButton *knowButton;
@property (nonatomic, strong)UIButton *guanBiButton;
@property (nonatomic, strong)UIButton *huifuButton;
@property (nonatomic, strong)UIImageView * iconImageView;
@end

@implementation NCAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{

    _bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _bgView.alpha = 0.6;
    _bgView.backgroundColor = [UIColor blackColor];
    _bgView.userInteractionEnabled = YES;
    [self addSubview:_bgView];

    _effectT = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _effectViewT = [[UIVisualEffectView alloc] initWithEffect:_effectT];
    _effectViewT.frame = _bgView.frame;
    _effectViewT.alpha = 1.f;
    _effectViewT.userInteractionEnabled = YES;
    [self addSubview:_effectViewT];

    _alertView = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth - Alert_Width)/2, 0, Alert_Width, NC_kAUTOWIDTH(180))];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.layer.cornerRadius = NC_kAUTOWIDTH(7);
    _alertView.center = self.window.center;
    _alertView.userInteractionEnabled = YES;
    [self addSubview:_alertView];

    _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(Alert_Width/2 - NC_kAUTOWIDTH(20), NC_kAUTOWIDTH(15), NC_kAUTOWIDTH(40), NC_kAUTOWIDTH(40))];
    _iconImageView.backgroundColor = [UIColor clearColor];
    [_alertView addSubview:_iconImageView];

    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(NC_kAUTOWIDTH(20), CGRectGetMaxY(_iconImageView.frame) + NC_kAUTOWIDTH(5), Alert_Width - NC_kAUTOWIDTH(40), NC_kAUTOWIDTH(30))];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:NC_kAUTOWIDTH(16)]];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.text = @"我是标题";
    [_alertView addSubview:self.titleLabel];

    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(NC_kAUTOWIDTH(20), CGRectGetMaxY(_titleLabel.frame) + NC_kAUTOWIDTH(5), Alert_Width - NC_kAUTOWIDTH(40), NC_kAUTOWIDTH(30))];
    [self.contentLabel setFont:[UIFont boldSystemFontOfSize:NC_kAUTOWIDTH(13)]];
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.text = @"我是标题";
    [_alertView addSubview:self.contentLabel];

    self.knowButton = [[UIButton alloc]initWithFrame:CGRectMake(Alert_Width/2 - NC_kAUTOWIDTH(50), CGRectGetMinY(self.contentLabel.frame) + NC_kAUTOWIDTH(10), NC_kAUTOWIDTH(100),NC_kAUTOWIDTH(40))];
    self.knowButton.backgroundColor = [UIColor clearColor];
    [self.knowButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.knowButton setTitle:NSLocalizedString(@"立即体验" , nil) forState:UIControlStateNormal];
    self.knowButton.titleLabel.font = [UIFont boldSystemFontOfSize:NC_kAUTOWIDTH(16)];
//    [self.knowButton addTarget:self action:@selector(writeAPaper) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:self.knowButton];

}

- (void)showAlertViewWithTitle:(NSString *)titleString
                       content:(NSString *)contentString
                       redText:(NSString *)redText
                    knowButton:(NSString *)knowBtnText
                     imageName:(NSString *)imageName{
    
    self.window = [UIApplication sharedApplication].keyWindow;
    self.window.userInteractionEnabled = YES;
    [self.window addSubview:self];

    _alertView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.5f
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.3
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.alertView.transform = CGAffineTransformMakeScale(1, 1);
                     } completion:nil];


    _iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"NCAlertViewBundle.bundle/%@",imageName]];


    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:contentString];
    UIFont *boldFont = [UIFont boldSystemFontOfSize:NC_kAUTOWIDTH(14)];
    UIFont *normalFont = [UIFont fontWithName:@"HeiTi SC" size:NC_kAUTOWIDTH(14)];
    NSRange range = [contentString rangeOfString:redText];
    [attrString addAttribute:NSFontAttributeName value:normalFont range:NSMakeRange(0, contentString.length)];//设置Text这四个字母的字体为粗体
    [attrString addAttribute:NSFontAttributeName value:boldFont range:NSMakeRange(range.location, range.length)];//设置Text这四个字母的字体为粗体
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(range.location, range.length)];
    self.contentLabel.attributedText = attrString;
    [self.contentLabel sizeToFit];

    CGFloat contentW = self.contentLabel.frame.size.width;
    CGFloat contentH = self.contentLabel.frame.size.height;

    self.contentLabel.frame = CGRectMake(Alert_Width/2 - contentW/2, CGRectGetMaxY(_titleLabel.frame) + NC_kAUTOWIDTH(5), contentW, contentH);
    CGFloat AlertH = NC_kAUTOWIDTH(55) + NC_kAUTOWIDTH(35) + self.contentLabel.frame.size.height + NC_kAUTOWIDTH(50);
    self.alertView.frame = CGRectMake((ScreenWidth - Alert_Width)/2, 0, Alert_Width, AlertH);
    self.alertView.center =  self.window.center;

    self.knowButton.frame = CGRectMake(Alert_Width/2 - NC_kAUTOWIDTH(50), CGRectGetMaxY(self.contentLabel.frame), NC_kAUTOWIDTH(100),NC_kAUTOWIDTH(40));
    [self.knowButton setTitle:NSLocalizedString(knowBtnText , nil) forState:UIControlStateNormal];
    [self.knowButton addTarget:self action:@selector(knowBtnClick) forControlEvents:UIControlEventTouchUpInside];

}

- (void)showDaiXXXAlertViewWithTitle:(NSString *)titleString
                       content:(NSString *)contentString
                       redText:(NSString *)redText
                    knowButton:(NSString *)knowBtnText
                           imageName:(NSString *)imageName{
    self.window = [UIApplication sharedApplication].keyWindow;
    self.window.userInteractionEnabled = YES;
    [self.window addSubview:self];

    _alertView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.5f
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.3
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.alertView.transform = CGAffineTransformMakeScale(1, 1);
                     } completion:nil];


    _iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"NCAlertViewBundle.bundle/%@",imageName]];



    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:contentString];
    UIFont *boldFont = [UIFont boldSystemFontOfSize:NC_kAUTOWIDTH(14)];
    UIFont *normalFont = [UIFont fontWithName:@"HeiTi SC" size:NC_kAUTOWIDTH(14)];
    NSRange range = [contentString rangeOfString:redText];
    [attrString addAttribute:NSFontAttributeName value:normalFont range:NSMakeRange(0, contentString.length)];//设置Text这四个字母的字体为粗体
    [attrString addAttribute:NSFontAttributeName value:boldFont range:NSMakeRange(range.location, range.length)];//设置Text这四个字母的字体为粗体
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(range.location, range.length)];
    self.contentLabel.attributedText = attrString;
    [self.contentLabel sizeToFit];

    CGFloat contentW = self.contentLabel.frame.size.width;
    CGFloat contentH = self.contentLabel.frame.size.height;

    self.contentLabel.frame = CGRectMake(Alert_Width/2 - contentW/2, CGRectGetMaxY(_titleLabel.frame) + NC_kAUTOWIDTH(5), contentW, contentH);
    CGFloat AlertH = NC_kAUTOWIDTH(55) + NC_kAUTOWIDTH(35) + self.contentLabel.frame.size.height + NC_kAUTOWIDTH(50);
    self.alertView.frame = CGRectMake((ScreenWidth - Alert_Width)/2, 0, Alert_Width, AlertH);
    self.alertView.center =  self.window.center;

    self.knowButton.frame = CGRectMake(Alert_Width/2 - NC_kAUTOWIDTH(50), CGRectGetMaxY(self.contentLabel.frame), NC_kAUTOWIDTH(100),NC_kAUTOWIDTH(40));
    [self.knowButton setTitle:NSLocalizedString(knowBtnText , nil) forState:UIControlStateNormal];
    [self.knowButton addTarget:self action:@selector(knowBtnClick) forControlEvents:UIControlEventTouchUpInside];


    self.guanBiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.guanBiButton.frame = CGRectMake(ScreenWidth/2 - NC_kAUTOWIDTH(15), CGRectGetMaxY(_alertView.frame) + NC_kAUTOWIDTH(15), NC_kAUTOWIDTH(30), NC_kAUTOWIDTH(30));
    UIImage *buttonImage = [UIImage imageNamed:@"NCAlertViewBundle.bundle/guanbi"];
    [self.guanBiButton setImage:buttonImage forState:UIControlStateNormal];
    self.guanBiButton.backgroundColor = [UIColor clearColor];
    [self.guanBiButton addTarget:self action:@selector(guanBiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:self.guanBiButton];
}


- (void)showHuifuAlertViewWithTitle:(NSString *)titleString
                             content:(NSString *)contentString
                             redText:(NSString *)redText
                         knowButton:(NSString *)knowBtnText
                        huiFuButton:(NSString *)huFuBtnText
                            imageName:(NSString *)imageName{

    self.window = [UIApplication sharedApplication].keyWindow;
    self.window.userInteractionEnabled = YES;
    [self.window addSubview:self];

    _alertView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.5f
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.3
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.alertView.transform = CGAffineTransformMakeScale(1, 1);
                     } completion:nil];


    _iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"NCAlertViewBundle.bundle/%@",imageName]];

    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:contentString];
    UIFont *boldFont = [UIFont boldSystemFontOfSize:NC_kAUTOWIDTH(14)];
    UIFont *normalFont = [UIFont fontWithName:@"HeiTi SC" size:NC_kAUTOWIDTH(14)];
    NSRange range = [contentString rangeOfString:redText];
    [attrString addAttribute:NSFontAttributeName value:normalFont range:NSMakeRange(0, contentString.length)];//设置Text这四个字母的字体为粗体
    [attrString addAttribute:NSFontAttributeName value:boldFont range:NSMakeRange(range.location, range.length)];//设置Text这四个字母的字体为粗体
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(range.location, range.length)];
    self.contentLabel.attributedText = attrString;
    [self.contentLabel sizeToFit];

    CGFloat contentW = self.contentLabel.frame.size.width;
    CGFloat contentH = self.contentLabel.frame.size.height;

    self.contentLabel.frame = CGRectMake(Alert_Width/2 - contentW/2, CGRectGetMaxY(_titleLabel.frame) + NC_kAUTOWIDTH(5), contentW, contentH);
    CGFloat AlertH = NC_kAUTOWIDTH(55) + NC_kAUTOWIDTH(35) + self.contentLabel.frame.size.height + NC_kAUTOWIDTH(50);
    self.alertView.frame = CGRectMake((ScreenWidth - Alert_Width)/2, 0, Alert_Width, AlertH);
    self.alertView.center =  self.window.center;

    self.knowButton.frame = CGRectMake(Alert_Width/2 - NC_kAUTOWIDTH(50), CGRectGetMaxY(self.contentLabel.frame), NC_kAUTOWIDTH(100),NC_kAUTOWIDTH(40));
    [self.knowButton setTitle:NSLocalizedString(knowBtnText , nil) forState:UIControlStateNormal];
    [self.knowButton addTarget:self action:@selector(knowBtnClick) forControlEvents:UIControlEventTouchUpInside];

    self.guanBiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.guanBiButton.frame = CGRectMake(ScreenWidth/2 - NC_kAUTOWIDTH(15), CGRectGetMaxY(_alertView.frame) + NC_kAUTOWIDTH(15), NC_kAUTOWIDTH(30), NC_kAUTOWIDTH(30));
    UIImage *buttonImage = [UIImage imageNamed:@"NCAlertViewBundle.bundle/guanbi"];
    [self.guanBiButton setImage:buttonImage forState:UIControlStateNormal];
    self.guanBiButton.backgroundColor = [UIColor clearColor];
    [self.guanBiButton addTarget:self action:@selector(guanBiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:self.guanBiButton];

    _huifuButton= [[UIButton alloc]initWithFrame:CGRectMake(Alert_Width - NC_kAUTOWIDTH(90), NC_kAUTOWIDTH(15), NC_kAUTOWIDTH(80), NC_kAUTOWIDTH(40))];
    _huifuButton.backgroundColor = [UIColor clearColor];
    [_alertView addSubview:_huifuButton];
    [_huifuButton setTitle:NSLocalizedString(huFuBtnText , nil) forState:UIControlStateNormal];
    _huifuButton.titleLabel.font = [UIFont boldSystemFontOfSize:NC_kAUTOWIDTH(12)];
    [_huifuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_huifuButton addTarget:self action:@selector(huFuBtnCLick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dismissAlertView{

    _alertView.transform = CGAffineTransformMakeScale(1,1);
    [UIView animateWithDuration:0.5f
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.3
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.alertView.transform = CGAffineTransformMakeScale(0.01, 0.01);
                         self.alertView.alpha = 0;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         [self.bgView removeFromSuperview];
                         [self.alertView removeFromSuperview];
                         [self.guanBiButton removeFromSuperview];
                         self.guanBiButton = nil;
                         self.bgView = nil;
                         self.alertView = nil;
                     }];
}

- (void)knowBtnClick{
    if (self.woZhiDaoLeBlock) {
        self.woZhiDaoLeBlock();
    }
}

- (void)guanBiBtnClick{

    [self dismissAlertView];
    if (self.guanBiBlock) {
        self.guanBiBlock();
    }
}

- (void)huFuBtnCLick{
    if (self.huFuBlock) {
        self.huFuBlock();
    }
}
@end

