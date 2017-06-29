//
//  RCalendarModel.m
//  RCalendarDemo
//
//  Created by 刘冉 on 2017/6/22.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "RCalendarModel.h"

@implementation RCalendarModel

+(instancetype)loadWithDict:(NSDictionary *)dict{
    return [[RCalendarModel alloc] initWithDataSource:dict];
}

-(instancetype)initWithDataSource:(NSDictionary *)dict{
    if (self = [super init]) {
        self.sign1 = dict[@"sign1"];
        self.sign2 = dict[@"sign2"];
        self.sign3 = dict[@"sign3"];
    }
    return self;
}

@end
