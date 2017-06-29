//
//  RCalendarModel.h
//  RCalendarDemo
//
//  Created by 刘冉 on 2017/6/22.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCalendarModel : NSObject

/**sign1*/
@property (nonatomic,copy) NSString *sign1;
/**sign2*/
@property (nonatomic,copy) NSString *sign2;
/**sign3*/
@property (nonatomic,copy) NSString *sign3;

+(instancetype)loadWithDict:(NSDictionary*)dict;
-(instancetype)initWithDataSource:(NSDictionary*)dict;

@end
