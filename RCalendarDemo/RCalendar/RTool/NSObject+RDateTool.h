//
//  NSObject+RDateTool.h
//  RCalendarDemo
//
//  Created by 刘冉 on 2017/6/22.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (RDateTool)

/**
 * 传入一个日期返回这个日期的 NSDateComponents对象
 * @param date      当前的时间
 * @param calendar  当前日历
 */
-(NSDateComponents *)aCertainDateComponents:(NSDate *)date calendar:(NSCalendar*)calendar;

/**
 * 返回一个View，本类中当做item选中后背景View type是1的时候返回棕色，否则红色
 */
-(UIView *)returnsItemBackgroundView:(CGRect)Rect type:(NSInteger)isSelecd;

/*
 * 日期转字符串
 * @param date      需要转换的日期
 */
-(NSString * )theTargetDateConversionStr:(NSDate * )date;

/**
 * 字符串转date
 * @param str       需要转换的字符串
 */
-(NSDate* )theTargetStringConversionDate:(NSString *)str;

/**
 * 获取当月天数
 */
-(NSInteger)getCurrentMonthForDays;

/**
 * 获取当月1号是星期几
 * @param date      当月时间对象
 * @param number    传0计算当月，传非0计算其他月份
 * @param calendar  当前日历
 */
-(NSDate *)getAMonthframDate:(NSDate*)date months:(NSInteger)number calendar:(NSCalendar*)calendar;

/**
 * 获取某月一共有多少天
 * @param date      当月时间对象
 */
-(NSInteger)getNextNMonthForDays:(NSDate * )date;

/**
 * 获取某个月的1号是星期几
 * @param date      当前时间对象
 * @param calendar  当前日历对象
 */
-(NSInteger)getFirstDayWeekForMonth:(NSDate*)date calendar:(NSCalendar*)calendar;

@end
