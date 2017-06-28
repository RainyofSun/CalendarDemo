//
//  RDateTool.h
//  YXDayUp
//
//  Created by 刘冉 on 2017/6/26.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDateTool : NSObject

/**
 * 判断当前时间是否在一段时间内
 */
+ (BOOL)isBetweenFromHour:(NSInteger)fromHour FromMinute:(NSInteger)fromMin toHour:(NSInteger)toHour toMinute:(NSInteger)toMin;

/*
 * 日期转字符串
 * @param type      0 取当天时间 1后一天时间 -1前一天时间
 */
+ (NSString * )theTargetDateConversionStr:(int)dateType;
@end
