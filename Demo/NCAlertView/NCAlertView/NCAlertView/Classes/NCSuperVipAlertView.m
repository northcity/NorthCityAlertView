//
//  NCSuperVipAlertView.m
//  NCAlertView
//
//  Created by 2345 on 2019/7/30.
//  Copyright © 2019 chenxi. All rights reserved.
//

#import "NCSuperVipAlertView.h"
#import "NCAlertView.h"
#import "NcSuperVipCollectionViewCell.h"

@interface NCSuperVipAlertView ()<UICollectionViewDelegate,UICollectionViewDataSource>
{

    dispatch_source_t _timer;

}
@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, strong)UIBlurEffect *effectT;
@property (nonatomic, strong)UIVisualEffectView *effectViewT;
@property (nonatomic, strong)UIView *alertView;
@property (nonatomic, strong)CALayer *subLayer;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong)UIWindow *window;
@property (nonatomic, strong)UIButton *guanBiButton;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong)UIButton *yinsiBtn;
@property (nonatomic, strong)UIButton *fuwuBtn;
@property (nonatomic, strong)UIView *segmentView;
@property (nonatomic, strong)UILabel *showDaoJiShiLabel;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;


@property (nonatomic, strong) NSArray * imageNameArr;
@property (nonatomic, strong) NSArray * titleArr;
@property (nonatomic, strong) NSArray * contentArr;

@end

@implementation NCSuperVipAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
        _imageNameArr = @[@"mimabaohu2",@"沙漏",@"beedaefafeefe-2",@"云端",@"wuxian",@"huiyuan"];
        _titleArr = @[@"隐私保护",@"逆转时空",@"无广告",@"iCloud云同步",@"无限模式",@"高级功能"];
        _contentArr = @[@"开启密码保护，防止窥屏",@"无限的收到未来的信",@"清爽页面，享受自由",@"寄出的信保存iCloud，多设备共享",@"无限字数信纸模式",@"所有高级功能"];

    }
    return self;
}

- (void)createSubViews{

    _bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _bgView.alpha = 0.6;
    _bgView.backgroundColor = [UIColor clearColor];
    _bgView.userInteractionEnabled = YES;
    [self addSubview:_bgView];

    _effectT = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _effectViewT = [[UIVisualEffectView alloc] initWithEffect:_effectT];
    _effectViewT.frame = _bgView.frame;
    _effectViewT.alpha = 1.f;
    _effectViewT.userInteractionEnabled = YES;
    [self addSubview:_effectViewT];

    _alertView = [[UIView alloc]initWithFrame:CGRectMake(NC_kAUTOWIDTH(20), NC_PCTopBarHeight + NC_kAUTOWIDTH(30), SuperVIPAlert_Width, SuperVIPAlert_Width)];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.layer.cornerRadius = NC_kAUTOWIDTH(7);
    _alertView.center = self.window.center;
    _alertView.userInteractionEnabled = YES;
    [self addSubview:_alertView];

    _subLayer=[CALayer layer];
    CGRect fixframe = CGRectZero;
    _subLayer.frame = fixframe;
    _subLayer.cornerRadius = NC_kAUTOWIDTH(10);
    _subLayer.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
    _subLayer.masksToBounds = NO;
    _subLayer.shadowColor = [UIColor grayColor].CGColor;
    _subLayer.shadowOffset = CGSizeMake(0,0);
    _subLayer.shadowOpacity = 0.2f;
    _subLayer.shadowRadius = 10;
    _subLayer.hidden = YES;
    [self.layer insertSublayer:_subLayer below:self.alertView.layer];


//    _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(Alert_Width/2 - NC_kAUTOWIDTH(20), NC_kAUTOWIDTH(15), NC_kAUTOWIDTH(40), NC_kAUTOWIDTH(40))];
//    _iconImageView.backgroundColor = [UIColor clearColor];
//    [_alertView addSubview:_iconImageView];

    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(NC_kAUTOWIDTH(20), NC_kAUTOWIDTH(30), SuperVIPAlert_Width - NC_kAUTOWIDTH(40), NC_kAUTOWIDTH(30))];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:NC_kAUTOWIDTH(17)]];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.text = @"时间胶囊-超级会员";
    [_alertView addSubview:self.titleLabel];


    self.collectionView.frame = CGRectMake(NC_kAUTOWIDTH(25), CGRectGetMaxY(self.titleLabel.frame) + NC_kAUTOWIDTH(10), SuperVIPAlert_Width - NC_kAUTOWIDTH(50),SuperVIPAlert_Width - NC_kAUTOWIDTH(40));
//    self.collectionView.backgroundColor = [UIColor redColor];
    [_alertView addSubview:self.collectionView];


    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(NC_kAUTOWIDTH(20), CGRectGetMaxY(_titleLabel.frame) + NC_kAUTOWIDTH(0), Alert_Width - NC_kAUTOWIDTH(40), NC_kAUTOWIDTH(30))];
    [self.contentLabel setFont:[UIFont fontWithName:@"HeiTi SC" size:NC_kAUTOWIDTH(10)]];
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.text = @"我是标题";
    [_alertView addSubview:self.contentLabel];

    self.segmentView = [[UIView alloc]initWithFrame:CGRectMake(SuperVIPAlert_Width/2 - 0.25, CGRectGetMaxY(self.contentLabel.frame) + NC_kAUTOWIDTH(5), 0.5, NC_kAUTOWIDTH(30))];
    self.segmentView.backgroundColor = [UIColor blackColor];
    self.segmentView.alpha = 0.3;
    [_alertView addSubview:self.segmentView];

    self.yinsiBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.segmentView.frame) - NC_kAUTOWIDTH(80), CGRectGetMinY(self.contentLabel.frame) + NC_kAUTOWIDTH(5), NC_kAUTOWIDTH(80),NC_kAUTOWIDTH(30))];
    self.yinsiBtn.backgroundColor = [UIColor clearColor];
    [self.yinsiBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.yinsiBtn setTitle:NSLocalizedString(@"隐私政策" , nil) forState:UIControlStateNormal];
    self.yinsiBtn.titleLabel.font = [UIFont boldSystemFontOfSize:NC_kAUTOWIDTH(12)];
    [self.yinsiBtn addTarget:self action:@selector(yinSiZhengCeClick) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:self.yinsiBtn];

    self.fuwuBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.segmentView.frame) , CGRectGetMinY(self.contentLabel.frame) + NC_kAUTOWIDTH(5), NC_kAUTOWIDTH(80),NC_kAUTOWIDTH(30))];
    self.fuwuBtn.backgroundColor = [UIColor clearColor];
    [self.fuwuBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.fuwuBtn setTitle:NSLocalizedString(@"服务政策" , nil) forState:UIControlStateNormal];
    self.fuwuBtn.titleLabel.font = [UIFont boldSystemFontOfSize:NC_kAUTOWIDTH(12)];
    [self.fuwuBtn addTarget:self action:@selector(fuWuXieYiClick) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:self.fuwuBtn];

    self.knowButton = [[UIButton alloc]initWithFrame:CGRectMake(Alert_Width/2 - NC_kAUTOWIDTH(50), CGRectGetMinY(self.contentLabel.frame) + NC_kAUTOWIDTH(10), NC_kAUTOWIDTH(130),NC_kAUTOWIDTH(28))];
    self.knowButton.backgroundColor = [UIColor clearColor];
    [self.knowButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.knowButton setTitle:NSLocalizedString(@"￥6/月永久获取" , nil) forState:UIControlStateNormal];
    self.knowButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    self.knowButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    //    [self.knowButton addTarget:self action:@selector(writeAPaper) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:self.knowButton];
    self.knowButton.layer.cornerRadius = NC_kAUTOWIDTH(5);


    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.knowButton.frame;
    self.gradientLayer.colors = @[(id)NC_PNCColorWithHex(0xF5576C).CGColor, (id)NC_PNCColorWithHex(0xF093FB).CGColor];
    self.gradientLayer.locations = @[@(0),@(1)];
    self.gradientLayer.startPoint = CGPointMake(0, 0.5);
    self.gradientLayer.endPoint = CGPointMake(1, 0.5);
    self.gradientLayer.cornerRadius = NC_kAUTOWIDTH(5);
    [self.alertView.layer insertSublayer:self.gradientLayer below:self.knowButton.layer];

    self.showDaoJiShiLabel = [[UILabel alloc]initWithFrame:CGRectMake(NC_kAUTOWIDTH(20), CGRectGetMaxY(self.knowButton.frame), SuperVIPAlert_Width - NC_kAUTOWIDTH(40), NC_kAUTOWIDTH(30))];
    [self.showDaoJiShiLabel setFont:[UIFont fontWithName:@"HeiTi SC" size:10]];
    self.showDaoJiShiLabel.textAlignment = NSTextAlignmentCenter;
    self.showDaoJiShiLabel.numberOfLines = 0;
    self.showDaoJiShiLabel.textColor = [UIColor grayColor];
    self.showDaoJiShiLabel.text = @"2天 10:19:20";
    [_alertView addSubview:self.showDaoJiShiLabel];
}

- (void)showSuperVipAlertViewWithTitle:(NSString *)titleString
                               content:(NSString *)contentString
                               redText:(NSString *)redText
                            knowButton:(NSString *)knowBtnText
                           huiFuButton:(NSString *)huFuBtnText
                             imageName:(NSString *)imageName{

    self.window = [UIApplication sharedApplication].keyWindow;
    self.window.userInteractionEnabled = YES;
    [self.window addSubview:self];

    self.titleLabel.text = titleString;

    self.contentLabel.text = contentString;
    [self.contentLabel sizeToFit];

    CGFloat contentW = self.contentLabel.frame.size.width;
    CGFloat contentH = self.contentLabel.frame.size.height;

    self.contentLabel.frame = CGRectMake(ScreenWidth/2 - NC_kAUTOWIDTH(20) - contentW/2, CGRectGetMaxY(_collectionView.frame) + NC_kAUTOWIDTH(5), contentW, contentH);
    CGFloat AlertH = NC_kAUTOWIDTH(60) + SuperVIPAlert_Width - NC_kAUTOWIDTH(30) + self.contentLabel.frame.size.height + NC_kAUTOWIDTH(130);
    self.alertView.frame = CGRectMake((ScreenWidth - SuperVIPAlert_Width)/2, 0, SuperVIPAlert_Width, AlertH);
    _alertView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    _alertView.center = self.window.center;
    [UIView animateWithDuration:0.5f
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.3
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.alertView.transform = CGAffineTransformMakeScale(1, 1);
                     } completion:^(BOOL finished) {

                         CGRect fixframe =_alertView.layer.frame;
                         _subLayer.frame = fixframe;
                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                             _subLayer.hidden = NO;
                         });
                     }];

    self.segmentView.frame =CGRectMake((ScreenWidth -NC_kAUTOWIDTH(40))/2 - 0.5, CGRectGetMaxY(self.contentLabel.frame) + NC_kAUTOWIDTH(15), 0.5, NC_kAUTOWIDTH(20));

    self.yinsiBtn.frame = CGRectMake(CGRectGetMinX(self.segmentView.frame) - NC_kAUTOWIDTH(80), CGRectGetMaxY(self.contentLabel.frame) + NC_kAUTOWIDTH(10), NC_kAUTOWIDTH(80),NC_kAUTOWIDTH(30));

    self.fuwuBtn.frame = CGRectMake(CGRectGetMaxX(self.segmentView.frame) , CGRectGetMaxY(self.contentLabel.frame) + NC_kAUTOWIDTH(10), NC_kAUTOWIDTH(80),NC_kAUTOWIDTH(30));


    self.knowButton.frame = CGRectMake((ScreenWidth - NC_kAUTOWIDTH(40))/2 - NC_kAUTOWIDTH(60), CGRectGetMaxY(self.fuwuBtn.frame) + NC_kAUTOWIDTH(5), NC_kAUTOWIDTH(120),NC_kAUTOWIDTH(30));
    [self.knowButton setTitle:NSLocalizedString(knowBtnText , nil) forState:UIControlStateNormal];
    [self.knowButton addTarget:self action:@selector(knowBtnClick) forControlEvents:UIControlEventTouchUpInside];

    self.gradientLayer.frame = self.knowButton.frame;


    _knowIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(NC_kAUTOWIDTH(60)- NC_kAUTOWIDTH(20),0,NC_kAUTOWIDTH(40),NC_kAUTOWIDTH(30))];
    _knowIndicator.activityIndicatorViewStyle  = UIActivityIndicatorViewStyleWhite;
    [self.knowButton addSubview:_knowIndicator];

    _knowIndicator.transform = CGAffineTransformMakeScale(0.7,0.7);

    CALayer *knowLayer = [CALayer layer];
    CGRect fixframe = CGRectMake((ScreenWidth - NC_kAUTOWIDTH(40))/2 - NC_kAUTOWIDTH(50), CGRectGetMaxY(self.fuwuBtn.frame) + NC_kAUTOWIDTH(25), NC_kAUTOWIDTH(100), NC_kAUTOWIDTH(10));
    knowLayer.frame = fixframe;
    knowLayer.cornerRadius = NC_kAUTOWIDTH(10);
    knowLayer.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
    knowLayer.masksToBounds = NO;
    knowLayer.shadowColor = [UIColor grayColor].CGColor;
    knowLayer.shadowOffset = CGSizeMake(0,2);
    knowLayer.shadowOpacity = 0.7f;
    knowLayer.shadowRadius = 5;
    [self.alertView.layer insertSublayer:knowLayer below:self.gradientLayer];

    self.showDaoJiShiLabel.frame = CGRectMake(NC_kAUTOWIDTH(20), CGRectGetMaxY(self.knowButton.frame) + NC_kAUTOWIDTH(5), ScreenWidth - NC_kAUTOWIDTH(80), NC_kAUTOWIDTH(20));


    self.guanBiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.guanBiButton.frame = CGRectMake(ScreenWidth/2 - NC_kAUTOWIDTH(15), CGRectGetMaxY(_alertView.frame) + NC_kAUTOWIDTH(15), NC_kAUTOWIDTH(30), NC_kAUTOWIDTH(30));
    UIImage *buttonImage = [UIImage imageNamed:@"NCAlertViewBundle.bundle/guanbi"];
    [self.guanBiButton setImage:buttonImage forState:UIControlStateNormal];
    self.guanBiButton.backgroundColor = [UIColor clearColor];
    [self.guanBiButton addTarget:self action:@selector(guanBiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:self.guanBiButton];

    _huifuButton= [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_knowButton.frame), CGRectGetMinY(_knowButton.frame), NC_kAUTOWIDTH(70), NC_kAUTOWIDTH(30))];
    _huifuButton.backgroundColor = [UIColor clearColor];
    [_alertView addSubview:_huifuButton];
    [_huifuButton setTitle:NSLocalizedString(huFuBtnText , nil) forState:UIControlStateNormal];
    _huifuButton.titleLabel.font = [UIFont boldSystemFontOfSize:NC_kAUTOWIDTH(12)];
    [_huifuButton setTitleColor:NC_PNCColorWithHex(0x222222) forState:UIControlStateNormal];
    [_huifuButton addTarget:self action:@selector(huFuBtnCLick) forControlEvents:UIControlEventTouchUpInside];

    _huFuIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(NC_kAUTOWIDTH(35)- NC_kAUTOWIDTH(20),0,NC_kAUTOWIDTH(40),NC_kAUTOWIDTH(30))];
    _huFuIndicator.activityIndicatorViewStyle  = UIActivityIndicatorViewStyleGray;
    [self.huifuButton addSubview:_huFuIndicator];
    _huFuIndicator.transform = CGAffineTransformMakeScale(0.7,0.7);

    [self dealDaojiShi];
}

- (void)dealDaojiShi{
    // 倒计时的时间 测试数据
    NSString *deadlineStr = @"2019-08-12 12:00:00";
    // 当前时间的时间戳
    NSString *nowStr = [self getCurrentTimeyyyymmdd];
    // 计算时间差值
    NSInteger secondsCountDown = [self getDateDifferenceWithNowDateStr:nowStr deadlineStr:deadlineStr];

    __weak __typeof(self) weakSelf = self;

    if (_timer == nil) {
        __block NSInteger timeout = secondsCountDown; // 倒计时时间

        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC,  0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout <= 0){ //  当倒计时结束时做需要的操作: 关闭 活动到期不能提交
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakSelf.showDaoJiShiLabel.text = @"活动已结束";
                    });
                } else { // 倒计时重新计算 时/分/秒
                    NSInteger days = (int)(timeout/(3600*24));
                    NSInteger hours = (int)((timeout-days*24*3600)/3600);
                    NSInteger minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    NSInteger second = timeout - days*24*3600 - hours*3600 - minute*60;
                    NSString *strTime = [NSString stringWithFormat:@"限时优惠 %02ld : %02ld : %02ld", hours, minute, second];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (days == 0) {
                            weakSelf.showDaoJiShiLabel.text = strTime;
                        } else {
                            weakSelf.showDaoJiShiLabel.text = [NSString stringWithFormat:@"限时优惠 %ld天 %02ld : %02ld : %02ld", days, hours, minute, second];
                        }

                    });
                    timeout--; // 递减 倒计时-1(总时间以秒来计算)
                }
            });
            dispatch_resume(_timer);
        }
    }
}

/**
 *  获取时间差值  截止时间-当前时间
 *  nowDateStr : 当前时间
 *  deadlineStr : 截止时间
 *  @return 时间戳差值
 */
- (NSInteger)getDateDifferenceWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr {

    NSInteger timeDifference = 0;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy-MM-dd HH:mm:ss"];
    NSDate *nowDate = [formatter dateFromString:nowDateStr];
    NSDate *deadline = [formatter dateFromString:deadlineStr];
    NSTimeInterval oldTime = [nowDate timeIntervalSince1970];
    NSTimeInterval newTime = [deadline timeIntervalSince1970];
    timeDifference = newTime - oldTime;

    return timeDifference;
}

- (NSString *)getCurrentTimeyyyymmdd {
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dayStr = [formatDay stringFromDate:now];
    return dayStr;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake((ScreenWidth - NC_kAUTOWIDTH(90))/2 - NC_kAUTOWIDTH(2.5), (ScreenWidth - NC_kAUTOWIDTH(90))/3);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 2.5;

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.bounces = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [self.collectionView registerClass:[NcSuperVipCollectionViewCell class] forCellWithReuseIdentifier:@"GBGuessYouLikeCell"];
    }
    return _collectionView;
}

#pragma mark- 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageNameArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    NcSuperVipCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GBGuessYouLikeCell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor blueColor];
//    GBSimilarGoodsModel *model = self.guessYouLikeArray[indexPath.row];
//    [cell setCellWithModel:model];
    cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"NCAlertViewBundle.bundle/%@",_imageNameArr[indexPath.row]]];
    cell.titleLabel.text = _titleArr[indexPath.row];
    cell.priceLabel.text = _contentArr[indexPath.row];
    return cell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
// return  CGSizeMake((ScreenWidth - NC_kAUTOWIDTH(40))/2 - NC_kAUTOWIDTH(20), (ScreenWidth - NC_kAUTOWIDTH(40))/2);
//
//}

//// 设置整个组的缩进量是多少
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}

//// 设置最小行间距，也就是前一行与后一行的中间最小间隔
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return NC_kAUTOWIDTH(0);
//}


//点击cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (self.cellBlock) {
//        self.cellBlock(indexPath.row);
//        [GBEventHelper eventId:kGBEvent_xs_c];
//    }
}

- (void)knowBtnClick{
    [self showJuHua];
    if (self.woZhiDaoLeBlock) {
        self.woZhiDaoLeBlock();
    }
}

- (void)showJuHua{
    [self.knowButton setTitle:@"" forState:UIControlStateNormal];
    [_knowIndicator startAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}


- (void)huiFuShowJuHua{
    [self.huifuButton setTitle:@"" forState:UIControlStateNormal];
    [_huFuIndicator startAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)guanBiBtnClick{

    [self dismissAlertView];
    if (self.guanBiBlock) {
        self.guanBiBlock();
    }
}

- (void)huFuBtnCLick{
    [self huiFuShowJuHua];
    if (self.huFuBlock) {
        self.huFuBlock();
    }
}

- (void)yinSiZhengCeClick{
    if (self.openYinSiZhengCeBlock) {
        self.openYinSiZhengCeBlock();
    }
}

- (void)fuWuXieYiClick{
    if (self.openFuWuXieYiBlock) {
        self.openFuWuXieYiBlock();
    }
}

- (void)dismissAlertView{

    [self.subLayer removeFromSuperlayer];
    self.subLayer = nil;

    _alertView.transform = CGAffineTransformMakeScale(1,1);
    [UIView animateWithDuration:0.5f
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.3
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.alertView.transform = CGAffineTransformMakeScale(0.01, 0.01);
                         self.alertView.alpha = 0;
                         self.effectViewT.alpha = 0;
                         self.guanBiButton.alpha = 0;
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


@end
