//
//  UIButton+Custom.h
//  GPUImage_Camera
//
//  Created by weipeng.mao on 2018/5/4.
//  Copyright © 2018年 weipeng.mao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Custom)
@property (nonatomic, assign) NSTimeInterval custom_acceptEventInterval;// 重复点击间隔
@property (nonatomic,strong) void (^callBack)(void);
@end
