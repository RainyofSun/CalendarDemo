//
//  RCountDownLabel.m
//  OpenCVDemo
//
//  Created by 刘冉 on 2017/6/24.
//  Copyright © 2017年 刘冉. All rights reserved.
/*
 思路：进入房间后开启定时器1（退出房间需停止定时器1），判断当前时间是否处于签到的3个时间段。如果在这3个时间段，则对应的改变按钮上边的文字。如果不在签到的时间段，则开启订制label内部的定时器2（倒计时结束之后定时器的销毁内部处理,退出房间时若倒计时未结束需要销毁定时器），同时传入对应的再次签到的时间（17:00 8:00）。在label内部封装的方法内计算当前时间到再次签到时间的时间差，赋值给label内部的时、分、秒3个变量，执行定时器2.当3个变量同时等于0时，销毁定时器2.
 注：计算时间差的方法有一些特殊。只可以顺时计算00-24时的时间差值。逆时计算是有误差如计算22点到早上8点的时间差，差值为14.此处做特殊处理，首先判断当前时间在不在22:00-24:00内，如果在则计算当前时间到24:00时的差值，计算出之后再加上8小时；不在直接计算当前时间到8:00的差值
 */

#import "RCountDownImg.h"
#import "Masonry.h"
#import "RDateTool.h"

#define KScreenHeight   [UIScreen mainScreen].bounds.size.height
@interface RCountDownImg ()

/**时*/
@property (nonatomic,assign) int hour;
/**分*/
@property (nonatomic,assign) int minute;
/**秒*/
@property (nonatomic,assign) int second;
/**内部倒计时是否开启*/
@property (nonatomic,assign) BOOL isTurnOnTimer;
/**倒计时定时器*/
@property (nonatomic,strong) dispatch_source_t _Nullable timer;

@end

@implementation RCountDownImg

+(instancetype)loadCountDownLabelWithSuperView:(UIView *)superView{
    RCountDownImg* countImg = [[RCountDownImg alloc] init];
    countImg.layer.cornerRadius = 30;
    countImg.layer.masksToBounds = YES;
    countImg.image = [UIImage imageNamed:@"sign_bg"];
    countImg.userInteractionEnabled = YES;
    countImg.isTurnOnTimer = NO;
    [superView addSubview:countImg];
    [countImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.trailing.equalTo(superView.mas_trailing).with.offset(30);
        make.bottom.equalTo(superView.mas_bottom).with.offset(-KScreenHeight/3);
    }];
    return countImg;
}

-(instancetype)init{
    if (self = [super init]) {
        [self addSubview:self.countDownLabel];
        [self.countDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.equalTo(self);
        }];
    }
    return self;
}

#pragma mark - 开启倒计时定时器
-(void)startTimer:(NSString*)signTime{
    self.isTurnOnTimer = YES;
    //获取当前时间
    NSDate* currentDate = [NSDate date];
    //创建日期格式
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate* oldDate = [formater dateFromString:signTime];
    NSTimeInterval time = [oldDate timeIntervalSinceDate:currentDate];
    
    self.hour = ((int)time) % (3600*24) / 3600;
    self.minute = ((int)time) % (3600*24) % 3600/60;
    self.second = ((int)time) % (3600*24) % 3600 % 60;
    
    __weak typeof(&*self) weakSelf = self;
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 1 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
        weakSelf.second --;
        if (weakSelf.second == -1) {
            weakSelf.second = 59;
            weakSelf.minute -- ;
            if (weakSelf.minute == -1) {
                weakSelf.minute = 59;
                weakSelf.hour --;
            }
        }
        weakSelf.countDownLabel.text = [NSString stringWithFormat:@"倒计时 %d:%d:%d",weakSelf.hour,weakSelf.minute,weakSelf.second];
        weakSelf.countDownLabel.font = [UIFont systemFontOfSize:10];
        if (weakSelf.hour == 0 && weakSelf.minute == 0 && weakSelf.second == 0) {
            dispatch_cancel(self.timer);
            self.timer = nil;
            self.isTurnOnTimer = NO;
            if ([[signTime substringWithRange:NSMakeRange(11, 8)] isEqualToString:@"17:00:00"]) {
                weakSelf.countDownLabel.text = @"晚签";
            } else {
                weakSelf.countDownLabel.text = @"早签";
            }
        }
    });
    dispatch_resume(self.timer);
}

-(void)cancelTimer{
    if (self.isTurnOnTimer) {
        dispatch_cancel(self.timer);
        self.timer = nil;
    } else {
        NSLog(@"定时器未开启");
    }
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview];
}

-(void)dealloc{
    NSLog(@"countImg delloc");
}

#pragma mark - gettre
-(UILabel *)countDownLabel{
    if (!_countDownLabel) {
        _countDownLabel = [[UILabel alloc] init];
        _countDownLabel.textAlignment = NSTextAlignmentCenter;
        _countDownLabel.numberOfLines = 0;
        _countDownLabel.textColor = [UIColor whiteColor];
    }
    return _countDownLabel;
}

@end
