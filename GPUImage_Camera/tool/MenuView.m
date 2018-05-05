//
//  MenuView.m
//  GPUImage_Camera
//
//  Created by weipeng.mao on 2018/5/4.
//  Copyright © 2018年 weipeng.mao. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:255/255. green:255/255. blue:255/255. alpha:0.5];
        for (int i = 0; i < 4; i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(i*(frame.size.width/4), 0, frame.size.width/4, frame.size.height);
            button.tag = i;
            button.imageView.contentMode = UIViewContentModeScaleAspectFit;
            
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
            if (i == 0)
            {
                [button setImage:[UIImage imageNamed:@"filter"] forState:UIControlStateNormal];
            }
            else if (i == 1)
            {
                [button setImage:[UIImage imageNamed:@"flash_off"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"flash_on"] forState:UIControlStateSelected];
                
            }
            else if (i == 3)
            {
                
                [button setImage:[UIImage imageNamed:@"camera_back"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"camera_front"] forState:UIControlStateSelected];
            }
            
            
        }
        
    }
    return self;
}

-(void)buttonClick:(UIButton *)sender
{
    if (sender.tag == 1)
    {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if (![device hasTorch]) {
            NSLog(@"no torch");
        }else{
            [device lockForConfiguration:nil];
            if (!sender.selected)
            {
                [device setTorchMode: AVCaptureTorchModeOn];
            }
            else
            {
                [device setTorchMode: AVCaptureTorchModeOff];
            } [device unlockForConfiguration];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(MenuSelectIndex:)])
    {
        [self.delegate MenuSelectIndex:sender.tag];
    }
    
    sender.selected = !sender.selected;
}




@end
