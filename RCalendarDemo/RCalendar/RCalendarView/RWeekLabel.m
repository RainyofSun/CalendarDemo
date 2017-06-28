//
//  RWeekLabel.m
//  OpenCVDemo
//
//  Created by 刘冉 on 2017/6/26.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "RWeekLabel.h"
#import "Masonry.h"
#import "RColor.h"

@implementation RWeekLabel

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = RGBCOLOR(109, 108, 129);
        self.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

-(void)layoutSubviews{
    [self.sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - getter
-(UIView *)sepLine{
    if (!_sepLine) {
        _sepLine = [[UIView alloc] init];
        _sepLine.backgroundColor = RGBCOLOR(226, 226, 226);
        [self addSubview:_sepLine];
    }
    return _sepLine;
}

@end
