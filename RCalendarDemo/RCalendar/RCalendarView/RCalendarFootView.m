//
//  RCalendarFootView.m
//  RCalendarDemo
//
//  Created by 刘冉 on 2017/6/22.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "RCalendarFootView.h"
#import "Masonry.h"

@interface RCalendarFootView ()

@property (nonatomic,strong) UIImageView *bgImg;

@end

@implementation RCalendarFootView

-(void)layoutSubviews{
    [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.top.equalTo(self);
    }];
}

#pragma mark - getter
-(UIImageView *)bgImg{
    if (!_bgImg) {
        _bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"calendar_footer_bg"]];
        [self addSubview:_bgImg];
    }
    return _bgImg;
}

@end
