//
//  UIView+Animation.h
//  UIviewAnimation
//
//  Created by MS on 17/1/9.
//  Copyright © 2017年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
float radiansForDegress (int degress);

@interface UIView (Animation)
//位移
-(void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;
-(void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callBack:(SEL)method;
-(void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapback;
-(void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapback delegate:(id)delegate callBack:(SEL)method;

//3D旋转
-(void)rotateWithCenterPoint:(CGPoint)point angle:(float)angle duration:(float)secs;
/**
 *  淡入
 */
-(void)sadeInDuration:(float)secs finish:(void(^)(void))finishBlock;
/**
 *  淡出
 */
-(void)sadeOutDuration:(float)secs finish:(void(^)(void))finishBlock;

//形变
/**
 * 旋转
 */
-(void)rotate:(int)degrees secs:(float)secs delegate:(id)delegate callBack:(SEL)method;

/**
 * 缩放
 */
-(void)scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callBack:(SEL)method;

/**
 * 顺时针旋转
 * @param secs 动画执行时间
 */
-(void)spinClockwise:(float)secs;

/**
 * 逆时针旋转
 * @param secs 动画执行时间
 */
-(void)spinCounterClockwise:(float)secs;

/**
 * 反翻页效果
 * @param secs 动画执行时间
 */
-(void)curlDown:(float)secs;

/**
 * 视图翻页后消失
 * @param secs 动画执行时间
 */
-(void)curUpAndAway:(float)secs;

/**
 * 旋转缩放到最后一点消失
 * @param secs 动画执行时间
 */
-(void)drainAway:(float)secs;

/**
 * 将视图改变到一定透明度
 * @param newAlpha 透明度
 * @param secs 动画执行时间
 */
-(void)changeAlpha:(float)newAlpha secs:(float)secs;

/**
 * 改变透明度结束动画后还原
 * @param secs 动画执行时间
 * @param continuously 是否循环
 */
-(void)pulse:(float)secs continuously:(BOOL)continuously;

/**
 * 以渐变方式添加子控件
 * @param subview 需要添加的子控件
 */
-(void)addSubviewWithFadeanimation:(UIView*)subview;

/**
 * 粒子动画
 * @param image 动画图片
 */
-(void)particleAnimationImage:(NSString*)image;

@end
