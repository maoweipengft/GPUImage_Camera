//
//  ViewController.m
//  GPUImage_Camera
//
//  Created by weipeng.mao on 2018/5/4.
//  Copyright © 2018年 weipeng.mao. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import "UIButton+Custom.h"
#import "FilterView.h"
#import "MenuView.h"
@interface ViewController ()<FilterViewDelegate,MenuViewDelegate>
{
    GPUImageMovieWriter *movieWriter;
    NSString *pathToMovie;
}
@property (strong, nonatomic)GPUImageStillCamera *myCamera;
@property (strong, nonatomic)GPUImageView *myGPUImageView;
@property (strong, nonatomic)GPUImageFilter *myFilter;
@property (copy, nonatomic)NSArray *filterArr;
@property (weak, nonatomic)UISlider *mySlider;
@property (strong, nonatomic)UIButton *selectedBtn;
@property (nonatomic, strong)MenuView *menuV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化相机
    self.myCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionBack];
    
    //竖屏方向
    self.myCamera.outputImageOrientation = UIInterfaceOrientationPortrait;

    //初始化GPUImageView
    self.myGPUImageView = [[GPUImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    //滤镜
    GPUImageBrightnessFilter *BrightnessFilter = [[GPUImageBrightnessFilter alloc] init];
    
    //设置滤镜效果
    [self.myCamera addTarget:BrightnessFilter];
    [BrightnessFilter addTarget:self.myGPUImageView];
    self.myFilter = BrightnessFilter;
    [self.view addSubview:self.myGPUImageView];
    [self.myCamera startCameraCapture];
    
    
    UIButton *button_camera = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_camera setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    [button_camera setImage:[UIImage imageNamed:@"camerared"] forState:UIControlStateHighlighted];
   
   
    UITapGestureRecognizer *tap_Camera = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TakingPictures)];
    [button_camera addGestureRecognizer:tap_Camera];
    
    UILongPressGestureRecognizer *long_Camera = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(RecordingVideo:)];
    [button_camera addGestureRecognizer:long_Camera];
    
    
    [self.view addSubview:button_camera];
    [button_camera mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-KfontWidth(30));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(KfontWidth(100), KfontWidth(100)));
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ShowMenuView)];
    [self.myGPUImageView addGestureRecognizer:tap];
    
    
}

-(void)ShowMenuView
{
    if (!self.menuV.hidde)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.menuV.frame = CGRectMake(0, topBarHetght, kScreenWidth, 60);
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.menuV.frame = CGRectMake(0, -60, kScreenWidth, 60);
        }];
    }
    
    self.menuV.hidde = !self.menuV.hidde;
}


-(void)MenuSelectIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            [self filterClick];
            break;
        case 3:
            [self.myCamera rotateCamera];
            break;
        default:
            break;
    }
}


-(void)filterClick
{
    FilterView *filter = [[FilterView alloc]init];
    filter.delegate = self;
    self.definesPresentationContext = YES;
     filter.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:filter animated:YES completion:nil];
    
}

-(void)backSelectItem:(GPUImageFilter *)Filter
{
    [self.myCamera removeAllTargets];
    [self.myCamera addTarget:Filter];
    [Filter addTarget:self.myGPUImageView];
    self.myFilter = Filter;
}


-(void)TakingPictures
{
    NSLog(@"拍照");
    [CameraTool animationWithcamera:self.view];
    
    //定格一张图片 保存到相册
    [self.myCamera capturePhotoAsPNGProcessedUpToFilter:self.myFilter withCompletionHandler:^(NSData *processedPNG, NSError *error) {
        
        //拿到相册，需要引入Photo Kit
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            //写入图片到相册
            PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:[UIImage imageWithData:processedPNG]];
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            
            if (error)
            {
                NSLog(@"error:%@",error);
            }
        }];
        
    }];
    
}

-(void)RecordingVideo:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"开始录制");
        pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie.m4v"];
        unlink([pathToMovie UTF8String]);
        NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
        movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(360.0, 640.0)];
        movieWriter.encodingLiveVideo = YES;
        movieWriter.shouldPassthroughAudio = YES;
        [self.myFilter addTarget:movieWriter];
        self.myCamera.audioEncodingTarget = movieWriter;
        
        [movieWriter startRecording];
    }
    
    else if (sender.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"结束录制");
        self.myCamera.audioEncodingTarget = nil;
        NSLog(@"Path %@",pathToMovie);
        UISaveVideoAtPathToSavedPhotosAlbum(pathToMovie, nil, nil, nil);
        [movieWriter finishRecording];
        [self.myFilter removeTarget:movieWriter];
    }
   
    
    
}

-(void)EndRecordingVideo
{
    NSLog(@"结束录制");
    self.myCamera.audioEncodingTarget = nil;
    NSLog(@"Path %@",pathToMovie);
    UISaveVideoAtPathToSavedPhotosAlbum(pathToMovie, nil, nil, nil);
    [movieWriter finishRecording];
    [self.myFilter removeTarget:movieWriter];
    
}


-(MenuView *)menuV
{
    if (_menuV == nil)
    {
        _menuV = [[MenuView alloc]initWithFrame:CGRectMake(0, -60, kScreenWidth, 60)];
        _menuV.hidde = NO;
        _menuV.delegate = self;
        [self.view addSubview:_menuV];
    }
    return _menuV;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
