//
//  CameraTool.m
//  GPUImage_Camera
//
//  Created by weipeng.mao on 2018/5/4.
//  Copyright © 2018年 weipeng.mao. All rights reserved.
//

#import "CameraTool.h"

@implementation CameraTool

+ (void)animationWithcamera:(UIView *)view
{
    CATransition *shutterAnimation = [CATransition animation];
    shutterAnimation.delegate = self;
    shutterAnimation.duration = 0.5f;
    shutterAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    shutterAnimation.type = @"cameraIris";
    shutterAnimation.subtype = @"cameraIris";
    [view.layer addAnimation:shutterAnimation forKey:@"cameraIris"];
}

@end
