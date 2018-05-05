//
//  FilterView.h
//  GPUImage_Camera
//
//  Created by weipeng.mao on 2018/5/4.
//  Copyright © 2018年 weipeng.mao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FilterViewDelegate<NSObject>
-(void)backSelectItem:(GPUImageFilter *)Filter;

@end

@interface FilterView : UIViewController
@property (nonatomic,weak)id<FilterViewDelegate>delegate;
@end
