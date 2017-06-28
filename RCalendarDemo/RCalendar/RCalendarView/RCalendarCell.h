//
//  RCalendarCell.h
//  RCalendarDemo
//
//  Created by 刘冉 on 2017/6/22.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCalendarModel.h"

@interface RCalendarCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *calenderLabel;
/**数据源*/
@property (nonatomic,strong) RCalendarModel *dataSource;

@end
