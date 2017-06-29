//
//  RCalendarView.h
//  RCalendarDemo
//
//  Created by 刘冉 on 2017/6/22.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RCalendarViewDelegate <NSObject>

/**取消按钮*/
-(void)calendarHidden:(id)sender;

@end

@interface RCalendarView : UIView

/**delegate*/
@property (nonatomic,weak) id<RCalendarViewDelegate> delegate;

/**
 * 获取日历界面
 */
+(instancetype)loadingCalendarView:(id<RCalendarViewDelegate>)delegate superView:(UIView*)superView;

/**
 * 获取签到数据,刷新日历UI
 * @param   dataDic  NSDictionary  签到数据
 */
-(void)refreshCalendarData:(NSMutableArray*)dataDic;

/**
 * 释放内存
 */
-(void)releaseCalendarMemory;

@end
