//
//  NcSuperVipCollectionViewCell.m
//  NCAlertView
//
//  Created by 2345 on 2019/7/30.
//  Copyright © 2019 chenxi. All rights reserved.
//

#import "NcSuperVipCollectionViewCell.h"
#import "NCAlertView.h"

@implementation NcSuperVipCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.priceLabel];
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/2 - NC_kAUTOWIDTH(17.5), NC_kAUTOWIDTH(15), NC_kAUTOWIDTH(35), NC_kAUTOWIDTH(35))];
//        _iconImageView.layer.cornerRadius = 5;
//        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.backgroundColor = [UIColor clearColor];

    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_iconImageView.frame) + NC_kAUTOWIDTH(2), self.contentView.frame.size.width, NC_kAUTOWIDTH(20))];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:NC_kAUTOWIDTH(13)];
        _titleLabel.text = @"充氮酱板鸭62...";
    }
    return _titleLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame) + NC_kAUTOWIDTH(2), self.contentView.frame.size.width, NC_kAUTOWIDTH(20))];
        _priceLabel.textColor = [UIColor grayColor];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.font = [UIFont systemFontOfSize:NC_kAUTOWIDTH(11)];
        _priceLabel.text = @"券后 ￥68.0";
        _priceLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _priceLabel;
}

//- (void)setCellWithModel:(GBSimilarGoodsModel *)model {
//    
//}

- (void)setCell{
    
}
@end
