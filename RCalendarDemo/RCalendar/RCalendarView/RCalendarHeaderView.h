//
//  RCalendarHeaderView.h
//  RCalendarDemo
//
//  Created by 刘冉 on 2017/6/22.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWeekLabel.h"

@protocol RCalendarHeaderViewDelegate <NSObject>

/**取消按钮*/
-(void)cancelCalendar:(id)sender;

@end

@interface RCalendarHeaderView : UICollectionReusableView

/**代理*/
@property (nonatomic,weak) id<RCalendarHeaderViewDelegate> delegate;
/**星期label*/
@property (nonatomic,strong) RWeekLabel *weekLabel;
/**月份*/
@property (nonatomic,strong) UILabel *month;

/**
 * 外部改变星期颜色的方法
 */
-(void)changeStatusWeek:(NSInteger)index;

@end
