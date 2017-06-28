//
//  RColor.h
//  RCalendarDemo
//
//  Created by 刘冉 on 2017/6/28.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#ifndef RColor_h
#define RColor_h

#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#pragma mark - 获取图片路径
#define IMAGEPATH(name)         [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name]
#define CONTENTFILEIMAGE(name)  [UIImage imageWithContentsOfFile:IMAGEPATH(name)]

#endif /* RColor_h */
