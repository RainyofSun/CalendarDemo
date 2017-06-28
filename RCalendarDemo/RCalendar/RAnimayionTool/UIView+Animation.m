//
//  UIView+Animation.m
//  UIviewAnimation
//
//  Created by MS on 17/1/9.
//  Copyright © 2017年 MS. All rights reserved.
//

#import "UIView+Animation.h"
#define ANIMATIONWIDTH self.frame.size.width
#define ANIMATIONHEIGHT self.frame.size.height

float radiansForDegress(int degrees){
    return degrees * M_PI/180;
}
@implementation UIView (Animation)

#pragma mark - 位移
-(void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option{
    [self moveTo:destination duration:secs option:option delegate:nil callBack:nil];
}

-(void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callBack:(SEL)method{
    [UIView animateWithDuration:secs delay:0.0 options:option animations:^{
        self.frame = CGRectMake(destination.x, destination.y, ANIMATIONWIDTH, ANIMATIONHEIGHT);
    } completion:^(BOOL finished) {
        if (delegate != nil) {
#pragma mark - 处理编译器警告->performselector可能引起泄漏因为它是未知的
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector:method];
#pragma clang diagnostic pop
        }
    }];
}

-(void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapback{
    [self raceTo:destination withSnapBack:withSnapback delegate:nil callBack:nil];
}

-(void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapback delegate:(id)delegate callBack:(SEL)method{
    CGPoint stopPoint = destination;
    if (withSnapback) {
        // Determine our stop point, from which we will "snap back" to the final destination
        int diffx = destination.x - self.frame.origin.x;
        int diffy = destination.y - self.frame.origin.y;
        if (diffx < 0) {
            // Destination is to the left of current position
            stopPoint.x -= 10.0;
        }else if (diffx > 0){
            stopPoint.x += 10.0;
        }
        if (diffy < 0) {
            // Destination is to the left of current position
            stopPoint.y -= 10.0;
        }else if (diffy > 0){
            stopPoint.y += 10.0;
        }
    }
    //动画
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.frame = CGRectMake(stopPoint.x, stopPoint.y, ANIMATIONWIDTH, ANIMATIONHEIGHT);
    } completion:^(BOOL finished) {
        if (withSnapback) {
            [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.frame = CGRectMake(destination.x, destination.y, ANIMATIONWIDTH, ANIMATIONHEIGHT);
            } completion:^(BOOL finished) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [delegate performSelector:method];
#pragma clang diagnostic pop
            }];
        }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector:method];
#pragma clang diagnostic pop
        }
    }];
}

-(void)rotateWithCenterPoint:(CGPoint)point angle:(float)angle duration:(float)secs{
    CATransform3D tranform = CATransform3DIdentity;
    tranform = CATransform3DRotate(tranform, angle, 1.0, 1.0, 1.0);
    CALayer* layer = self.layer;
    //设置反转中心点
    layer.anchorPoint = point;
    layer.transform = tranform;
}

#pragma mark - 淡入淡出
-(void)sadeInDuration:(float)secs finish:(void (^)(void))finishBlock{
    self.alpha = 0.0;
    [UIView animateWithDuration:secs animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        if (finishBlock != nil) {
            finishBlock();
        }
    }];
}

-(void)sadeOutDuration:(float)secs finish:(void (^)(void))finishBlock{
    self.alpha = 1.0;
    [UIView animateWithDuration:secs animations:^{
        self.alpha = 0.1;
    } completion:^(BOOL finished) {
        if (finishBlock != nil) {
            finishBlock();
        }
    }];
}

#pragma mark - 形变
-(void)rotate:(int)degrees secs:(float)secs delegate:(id)delegate callBack:(SEL)method{
    [UIView animateWithDuration:secs delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.transform = CGAffineTransformRotate(self.transform, radiansForDegress(degrees));
    } completion:^(BOOL finished) {
        if (delegate != nil) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector:method];
#pragma clang diagnostic pop
        }
    }];
}

-(void)scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callBack:(SEL)method{
    [UIView animateWithDuration:secs delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.transform = CGAffineTransformScale(self.transform, scaleX, scaleY);
    } completion:^(BOOL finished) {
        if (delegate != nil) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector:method];
#pragma clang diagnostic pop
        }
    }];
}

-(void)spinClockwise:(float)secs{
    [UIView animateWithDuration:secs/4 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.transform = CGAffineTransformRotate(self.transform, radiansForDegress(90));
    } completion:^(BOOL finished) {
        [self spinClockwise:secs];
    }];
}

-(void)spinCounterClockwise:(float)secs{
    [UIView animateWithDuration:secs/4 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.transform = CGAffineTransformRotate(self.transform, radiansForDegress(270));
    } completion:^(BOOL finished) {
        [self spinCounterClockwise:secs];
    }];
}

#pragma mark - 过度动画
-(void)curlDown:(float)secs{
    [UIView transitionWithView:self duration:secs options:UIViewAnimationOptionTransitionCurlDown animations:^{
        [self setAlpha:1.0];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)curUpAndAway:(float)secs{
    [UIView transitionWithView:self duration:secs options:UIViewAnimationOptionTransitionCurlUp animations:^{
        [self setAlpha:0];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)drainAway:(float)secs{
    self.tag = 20;
    [NSTimer scheduledTimerWithTimeInterval:secs/50 target:self selector:@selector(drainTimer:) userInfo:nil repeats:YES];
}

-(void)drainTimer:(NSTimer*)timer{
    CGAffineTransform trans = CGAffineTransformRotate(CGAffineTransformScale(self.transform, 0.9, 0.9), 0.314);
    self.transform = trans;
    self.alpha = self.alpha* 0.98;
    self.tag = self.tag - 1;
    if (self.tag <= 0) {
        [timer invalidate];
        [self removeFromSuperview];
    }
}

#pragma mark - 动画效果
-(void)changeAlpha:(float)newAlpha secs:(float)secs{
    [UIView animateWithDuration:secs delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alpha = newAlpha;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)pulse:(float)secs continuously:(BOOL)continuously{
    [UIView animateWithDuration:secs/2 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        //Fade out , but not completely
        self.alpha = 0.3;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:secs/2 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            //fade in
            self.alpha = 1.0;
        } completion:^(BOOL finished) {
            if (continuously) {
                [self pulse:secs continuously:continuously];
            }
        }];
    }];
}

#pragma mark - add subView
-(void)addSubviewWithFadeanimation:(UIView *)subview{
    CGFloat finalalpha = subview.alpha;
    subview.alpha = 0.0;
    [UIView animateWithDuration:0.2 animations:^{
        subview.alpha = finalalpha;
    }];
}

#pragma mark - particle animation
-(void)particleAnimationImage:(NSString *)image{
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = self.bounds;
    [self.layer addSublayer:emitter];
    //发射模式
    emitter.renderMode = kCAEmitterLayerOutline;
    //动画的位置
    emitter.emitterPosition = self.center;
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    //设置图片
    cell.contents = (__bridge id)[UIImage imageNamed:image].CGImage;
    //设置粒子产生系数,默认是1.0 ->必须要设置 每秒某个点产生的cell的数量
    cell.birthRate = 20;
    //设置粒子的生命周期->在屏幕上显示时间的长短
    cell.lifetime = 2.0;
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
    //粒子透明度在生命周期内的改变速度
    cell.alphaSpeed = -0.4;
    //cell向屏幕右边飞行的速度
    cell.velocity = 50;
    //在右边什么范围内飞行
    cell.velocityRange = 50;
    //cell的角度扩散
    cell.emissionRange = M_PI * 2.0;
    emitter.emitterCells = @[cell];
}
@end

