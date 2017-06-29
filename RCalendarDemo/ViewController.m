//
//  ViewController.m
//  RCalendarDemo
//
//  Created by 刘冉 on 2017/6/22.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "ViewController.h"
#import "RCalendarView.h"
#import "RCountDownImg.h"
#import <Masonry.h>
#import "UIView+Animation.h"

@interface ViewController ()<RCalendarViewDelegate>

/**日历*/
@property (nonatomic,strong) RCalendarView *calendarView;
/**倒计时按钮*/
@property (nonatomic,strong) RCountDownImg *signImg;
/**sign1*/
@property (nonatomic,copy) NSString *sign1;
/**sign2*/
@property (nonatomic,copy) NSString *sign2;
/**sign3*/
@property (nonatomic,copy) NSString *sign3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self calendarView];
    [self signImg];
}

#pragma mark - 按钮点击
-(void)tapSign:(UIGestureRecognizer*)sender{
    if (!self.calendarView.hidden) {
        return;
    }
    [self.signImg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.view.mas_trailing).with.offset(-15);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
    self.calendarView.hidden = NO;
    [self.calendarView curlDown:1];
    [self.calendarView refreshCalendarData:[self creatRandomData]];
}

#pragma mark - 生成随机数据
-(NSMutableArray*)creatRandomData{
    NSMutableArray* dataSource = [NSMutableArray array];
    for (int i = 0; i < 30; i++) {
        self.sign1 = [NSString stringWithFormat:@"%u",arc4random()%2];
        self.sign2 = [NSString stringWithFormat:@"%u",arc4random()%2];
        self.sign3 = [NSString stringWithFormat:@"%u",arc4random()%2];
        NSDictionary* dict = @{@"sign1":self.sign1,
                               @"sign2":self.sign2,
                               @"sign3":self.sign3};
        [dataSource addObject:dict];
    }
    
    return dataSource;
}

#pragma mark - RCalendarViewDelegate
-(void)calendarHidden:(id)sender{
    [self.signImg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.view.mas_trailing).with.offset(30);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
    self.calendarView.hidden = YES;
    [self.calendarView curUpAndAway:1];
}

-(RCalendarView *)calendarView{
    if (!_calendarView) {
        _calendarView = [RCalendarView loadingCalendarView:self superView:self.view];
        _calendarView.hidden = YES;
    }
    return _calendarView;
}

-(RCountDownImg *)signImg{
    if (!_signImg) {
        _signImg = [RCountDownImg loadCountDownLabelWithSuperView:self.view];
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSign:)];
        tap.numberOfTapsRequired = 1;
        [_signImg addGestureRecognizer:tap];
    }
    return _signImg;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
