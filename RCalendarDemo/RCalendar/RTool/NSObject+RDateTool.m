//
//  NSObject+RDateTool.m
//  RCalendarDemo
//
//  Created by 刘冉 on 2017/6/22.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "NSObject+RDateTool.h"

static NSDictionary* dataSource;

@implementation NSObject (RDateTool)

/**
 * 传入一个日期返回这个日期的 NSDateComponents对象
 */
-(NSDateComponents *)aCertainDateComponents:(NSDate *)date calendar:(NSCalendar *)calendar{
    NSCalendarUnit _dayInfoUnits  = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:_dayInfoUnits fromDate:date];
    return components;
}

/**
 * 返回一个View，本类中当做item选中后背景View type是1的时候返回棕色，否则红色
 */
-(UIView *)returnsItemBackgroundView:(CGRect)Rect type:(NSInteger)isSelecd{
    CGFloat itemW = ([[UIScreen mainScreen] bounds].size.width - 3) / 7;
    UIView * view =[[UIView alloc]initWithFrame:CGRectMake(0,0, itemW, itemW)];
    view.center = CGPointMake(Rect.origin.x/2, Rect.origin.y/2);
    if (isSelecd == 1) {
        view.backgroundColor = [[UIColor brownColor]colorWithAlphaComponent:0.7];
    }else view.backgroundColor = [[UIColor yellowColor]colorWithAlphaComponent:0.5];
    view.layer.cornerRadius = itemW /2;
    return view;
}

/*
 * 日期转字符串
 * date : 需要转换的日期
 */
-(NSString * )theTargetDateConversionStr:(NSDate * )date{
    dataSource = @{@"01":@"一月",@"02":@"二月",@"03":@"三月",@"04":@"四月",@"05":@"五月",@"06":@"六月",
                   @"07":@"七月",@"08":@"八月",@"09":@"九月",@"10":@"十月",@"11":@"十一月",@"12":@"十二月"};
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式,这里可以设置成自己需要的格式
    NSString *currentDateStr = [[dateFormat stringFromDate:date] substringWithRange:NSMakeRange(5, 2)];
    return dataSource[currentDateStr];
}

/**
 * 字符串转date
 */
-(NSDate* )theTargetStringConversionDate:(NSString *)str{
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:str];
    return date;
}

/*
 *  获取当前月天数
 */
-(NSInteger)getCurrentMonthForDays{
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSRange range = [currentCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    NSUInteger numberOfDaysInMonth = range.length;
    NSLog(@"nsrange = %@----- %ld",NSStringFromRange(range),(unsigned long)range.location);
    return numberOfDaysInMonth;
}

/*
 *  date :当前时间
 *  number:当前月之后几个个月的1号date
 */
-(NSDate *)getAMonthframDate:(NSDate*)date months:(NSInteger)number calendar:(NSCalendar *)calendar{
    
    NSCalendarUnit _dayInfoUnits  = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:_dayInfoUnits fromDate:date];
    components.day = 1;
    if (number!=0) {
        components.month += number;
    }
    NSDate * nextMonthDate =[calendar dateFromComponents:components];
    return nextMonthDate;
}

/*
 * 获取某个月一共多少天
 * date 要获取的月份的date
 */
-(NSInteger)getNextNMonthForDays:(NSDate * )date{
    NSInteger monthNum =[[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    //     = (NSInteger)[date YHBaseNumberOfDaysInCurrentMonth];
    return monthNum;
}

/**
 *  获取某个月的1号是星期几
 *  date 目标月的date
 **/
-(NSInteger)getFirstDayWeekForMonth:(NSDate*)date calendar:(NSCalendar *)calendar{
    // NSDateComponent 可以获得日期的详细信息，即日期的组成
    //WeekDay 表示周里面的天 1代表周日 2代表周一 7代表周六
    NSDateComponents *comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitWeekday) fromDate:date];
    //    NSLog(@"comps是这个样子的:%@",comps);
    NSInteger weekday = [comps weekday];
    weekday--;
    NSLog(@"[comps weekday] = %ld",(long)weekday);
    if (weekday == 7) {
        return 0;
    }else return weekday;
}

@end
