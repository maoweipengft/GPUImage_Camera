//
//  FilterView.m
//  GPUImage_Camera
//
//  Created by weipeng.mao on 2018/5/4.
//  Copyright © 2018年 weipeng.mao. All rights reserved.
//

#import "FilterView.h"

@interface FilterView ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *fileterArr;
@property (nonatomic, assign) NSInteger selectRow;
@end

@implementation FilterView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    
    self.titleArr = @[
                      @"关闭",
                      @"哈哈镜",
                      @"怀旧",
                      @"边缘检测",
                      @"反色",
                      @"灰度"
                      ,@"黑白",
                      @"素描",
                      @"油画",
                      @"像素化",
                      @"黑白网格",
                      @"晕影",
                      @"旋涡",
                      @"鱼眼",
                      @"水晶",
                      @"折射"
                      ];
    
    //默认效果
    GPUImageBrightnessFilter *BrightnessFilter = [[GPUImageBrightnessFilter alloc] init];
    
    //哈哈镜效果
    GPUImageStretchDistortionFilter *stretchDistortionFilter = [[GPUImageStretchDistortionFilter alloc] init];
    
    //怀旧
    GPUImageSepiaFilter *sepiaFilter = [[GPUImageSepiaFilter alloc] init];
    
    //边缘检测
    GPUImageXYDerivativeFilter *XYDerivativeFilter = [[GPUImageXYDerivativeFilter alloc] init];
    
    //反色
    GPUImageColorInvertFilter *invertFilter = [[GPUImageColorInvertFilter alloc] init];
    
    //灰度
    GPUImageGrayscaleFilter *GrayscaleFilter = [[GPUImageGrayscaleFilter alloc]init];
    
   //黑白
    GPUImageAverageLuminanceThresholdFilter *ThresholdFilter = [[GPUImageAverageLuminanceThresholdFilter alloc]init];
    
    //素描
    GPUImageSketchFilter *SketchFilter = [[GPUImageSketchFilter alloc]init];

    //油画
    GPUImageSmoothToonFilter *SmoothToonFilter= [[GPUImageSmoothToonFilter alloc]init];
    
    //像素化
    GPUImagePixellateFilter *PixellateFilter = [[GPUImagePixellateFilter alloc]init];
    
    //黑白网格
    GPUImageCrosshatchFilter *CrosshatchFilter = [[GPUImageCrosshatchFilter alloc]init];
    
    //晕影
    GPUImageVignetteFilter *VignetteFilter = [[GPUImageVignetteFilter alloc]init];
    
    //旋涡
    GPUImageSwirlFilter *SwirlFilter = [[GPUImageSwirlFilter alloc]init];
    
    //鱼眼
    GPUImageBulgeDistortionFilter *BulgeDistortionFilter = [[GPUImageBulgeDistortionFilter alloc]init];
    
    //水晶
    GPUImageGlassSphereFilter *GlassSphereFilter = [[GPUImageGlassSphereFilter alloc]init];
    
    //折射
    GPUImageSphereRefractionFilter *SphereRefractionFilter = [[GPUImageSphereRefractionFilter alloc]init];
    
    self.fileterArr = @[BrightnessFilter,stretchDistortionFilter,sepiaFilter,XYDerivativeFilter,invertFilter,GrayscaleFilter,ThresholdFilter,SketchFilter,SmoothToonFilter,PixellateFilter,CrosshatchFilter,VignetteFilter,SwirlFilter,BulgeDistortionFilter,GlassSphereFilter,SphereRefractionFilter];
}


#pragma mark -UIPickerViewDataSource/UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.titleArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.titleArr[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectRow = row;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44;
}





- (IBAction)Cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)Determine:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(backSelectItem:)])
    {
        [self.delegate backSelectItem:self.fileterArr[_selectRow]];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
