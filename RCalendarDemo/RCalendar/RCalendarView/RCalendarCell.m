//
//  RCalendarCell.m
//  RCalendarDemo
//
//  Created by 刘冉 on 2017/6/22.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "RCalendarCell.h"
#import "Masonry.h"
#import "RColor.h"

static CGFloat cellHeight;

@interface RCalendarCell ()

@property (strong, nonatomic) UIImageView *tian;
@property (strong, nonatomic) UIImageView *ren;
@property (strong, nonatomic) UIImageView *di;

@end

@implementation RCalendarCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        cellHeight = CGRectGetHeight(self.contentView.bounds);
    }
    return self;
}

-(void)setDataSource:(RCalendarModel *)dataSource{
    if (dataSource.sign1.intValue != 0 || dataSource.sign2.intValue != 0 || dataSource.sign3.intValue != 0) {
        self.calenderLabel.textColor = RGBCOLOR(235, 54, 65);
    } else {
        self.calenderLabel.textColor = RGBCOLOR(109, 108, 129);
    }
    [dataSource.sign1 boolValue] ? [self.tian setHidden:NO] : [self.tian setHidden:YES];
    [dataSource.sign2 boolValue] ? [self.ren setHidden:NO] : [self.ren setHidden:YES];
    [dataSource.sign3 boolValue] ? [self.di setHidden:NO] : [self.di setHidden:YES];
}

-(void)layoutSubviews{
    
    [self.calenderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(cellHeight/2);
        make.leading.trailing.top.equalTo(self.contentView);
    }];
    
    [self.ren mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top).with.offset(2 + cellHeight/2);
        make.size.mas_equalTo(self.ren.image.size);
    }];
    
    [self.tian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(cellHeight/2);
        make.trailing.equalTo(self.ren.mas_leading);
        make.size.mas_equalTo(self.tian.image.size);
    }];
    
    [self.di mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(1 + cellHeight/2);
        make.leading.equalTo(self.ren.mas_trailing);
        make.size.mas_equalTo(self.di.image.size);
    }];
}

-(UILabel *)calenderLabel{
    if (!_calenderLabel) {
        _calenderLabel = [[UILabel alloc] init];
        _calenderLabel.font = [UIFont systemFontOfSize:12];
        _calenderLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_calenderLabel];
    }
    return _calenderLabel;
}

-(UIImageView *)tian{
    if (!_tian) {
        _tian = [[UIImageView alloc] initWithImage:CONTENTFILEIMAGE(@"sign_sky")];
        _tian.hidden = YES;
        [self.contentView addSubview:_tian];
    }
    return _tian;
}

-(UIImageView *)ren{
    if (!_ren) {
        _ren = [[UIImageView alloc] initWithImage:CONTENTFILEIMAGE(@"sign_person")];
        _ren.hidden = YES;
        [self.contentView addSubview:_ren];
    }
    return _ren;
}

-(UIImageView *)di{
    if (!_di) {
        _di = [[UIImageView alloc] initWithImage:CONTENTFILEIMAGE(@"sign_land")];
        _di.hidden = YES;
        [self.contentView addSubview:_di];
    }
    return _di;
}

@end
