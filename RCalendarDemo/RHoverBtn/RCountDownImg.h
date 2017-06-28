//
//  RCountDownLabel.h
//  OpenCVDemo
//
//  Created by 刘冉 on 2017/6/24.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCountDownImg : UIImageView
/**倒计时label*/
@property (nonatomic,strong) UILabel * _Nullable countDownLabel;

/**
 * 加载实例label
 */
+(nullable instancetype)loadCountDownLabelWithSuperView:(UIView*_Nullable)superView;
/**
 * 开启倒计时label内部的计时器
 */
-(void)startTimer:(NSString*_Nullable)signTime;
/**
 * 外部销毁定时器、释放内存的接口
 */
-(void)cancelTimer;

@end
