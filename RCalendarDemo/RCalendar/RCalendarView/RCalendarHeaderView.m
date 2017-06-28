//
//  RCalendarHeaderView.m
//  RCalendarDemo
//
//  Created by 刘冉 on 2017/6/22.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "RCalendarHeaderView.h"
#import "RColor.h"
#import "Masonry.h"

#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
static CGFloat labelW;

@interface RCalendarHeaderView ()

/**星期数组*/
@property (nonatomic,strong) NSArray *weekArray;
/**背景色*/
@property (nonatomic,strong) UIImageView *bgImg;
/**返回按钮*/
@property (nonatomic,strong) UIButton *cancel;

@end

@implementation RCalendarHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self ceartHeaderView];
    }
    return self;
}

-(void)layoutSubviews{
    [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.equalTo(self);
        make.height.mas_equalTo(60);
    }];
    
    [self.month mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bgImg);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
    [self.cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.top.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
}

#pragma mark - 外部接口暴露修改颜色的方法
-(void)changeStatusWeek:(NSInteger)index{
    self.weekLabel = (RWeekLabel*)[self viewWithTag:index];
    self.weekLabel.textColor = RGBCOLOR(235, 54, 65);
    self.weekLabel.sepLine.backgroundColor = RGBCOLOR(235, 54, 65);
}

#pragma mark - 取消日历按钮
-(void)cancelCalendar:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(cancelCalendar:)]) {
        [self.delegate cancelCalendar:self];
    }
}

-(void)ceartHeaderView{
    _weekArray = [NSArray arrayWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六", nil];
    labelW = (self.frame.size.width - 20) / 7;
    for (int index = 0; index < 7; index++) {
        self.weekLabel = [[RWeekLabel alloc] initWithFrame:CGRectMake(10 + index * labelW, 60, labelW, self.frame.size.height - 65)];
        self.weekLabel.text = _weekArray[index];
        self.weekLabel.tag = index;
        [self addSubview:self.weekLabel];
    }
}

#pragma mark - getter
-(UIImageView *)bgImg{
    if (!_bgImg) {
        _bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"calendar_header_bg"]];
        [self addSubview:_bgImg];
    }
    return _bgImg;
}

-(UILabel *)month{
    if (!_month) {
        _month = [[UILabel alloc] init];
        _month.font = [UIFont systemFontOfSize:16];
        _month.textColor = [UIColor whiteColor];
        _month.textAlignment = NSTextAlignmentCenter;
        [self.bgImg addSubview:_month];
    }
    return _month;
}

-(UIButton *)cancel{
    if (!_cancel) {
        _cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancel setImage:CONTENTFILEIMAGE(@"close") forState:UIControlStateNormal];
        _cancel.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        [_cancel addTarget:self action:@selector(cancelCalendar:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancel];
    }
    return _cancel;
}

@end
