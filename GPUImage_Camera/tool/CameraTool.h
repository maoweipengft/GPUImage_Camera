//
//  CameraTool.h
//  GPUImage_Camera
//
//  Created by weipeng.mao on 2018/5/4.
//  Copyright © 2018年 weipeng.mao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CameraTool : NSObject<CAAnimationDelegate>

/**
 * 拍照动画
 */
+(void)animationWithcamera:(UIView *)view;

@end
