//
//  MenuView.h
//  GPUImage_Camera
//
//  Created by weipeng.mao on 2018/5/4.
//  Copyright © 2018年 weipeng.mao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MenuViewDelegate<NSObject>
-(void)MenuSelectIndex:(NSInteger)index;
@end

@interface MenuView : UIView
@property (nonatomic, assign)BOOL hidde;
@property (nonatomic, weak)id<MenuViewDelegate>delegate;
@end
