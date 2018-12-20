//
//  LDDCustomCameraVC.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/11/21.
//  Copyright © 2018年 My. All rights reserved.
//

#import "LDDCustomCameraVC.h"
#import <AVFoundation/AVFoundation.h>// 相机框架
#import <Photos/Photos.h>// 相册

@interface LDDCustomCameraVC ()

/**
 捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
 */
@property (nonatomic) AVCaptureDevice *device;
/**
 输入设备，使用AVCaptureDevice 来初始化
 */
@property (nonatomic) AVCaptureDeviceInput *input;
/**
 当启动摄像头开始捕获输入
 */
@property (nonatomic) AVCaptureMetadataOutput *outPut;
/**
 照片输出流
 */
@property (nonatomic) AVCaptureStillImageOutput *imageOutPut;
/**
 把输入输出结合在一起，并开始启动捕获设备（摄像头）
 */
@property (nonatomic) AVCaptureSession *session;
/**
 图像预览层，实时显示捕获的图像
 */
@property (nonatomic) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *photoBtn;
@property (nonatomic, strong) UIView *focusView;
@property (nonatomic, strong) UIButton *changeBtn;
@property (nonatomic, strong) UIImage *currentPhoto;

@end

@implementation LDDCustomCameraVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self prefersStatusBarHidden];
    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    
    if ([self checkCameraPermission]) {
        [self customCamera];
        [self setupViews];
        [self setupFrames];
        [self addFocusGesture];
        [self focusAtPoint:CGPointMake(0.5, 0.5)];
    }
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Focus

- (void)addFocusGesture {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(focusGesture:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)focusGesture:(UITapGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:gesture.view];
    [self focusAtPoint:point];
}

- (void)focusAtPoint:(CGPoint)point {
    CGSize size = self.view.bounds.size;
    
    CGPoint focusPoint = CGPointMake(point.y/size.height, 1 - point.x/size.width);
    
    if ([self.device lockForConfiguration:nil]) {
        
        if ([self.device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            [self.device setFocusPointOfInterest:focusPoint];
            [self.device setFocusMode:AVCaptureFocusModeAutoFocus];
        }
            
        [self.device unlockForConfiguration];
        self.focusView.center = point;
        self.focusView.hidden = NO;
        [UIView animateWithDuration:0.25 animations:^{
            self.focusView.transform = CGAffineTransformMakeScale(1.25, 1.25);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                self.focusView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                self.focusView.hidden = YES;
            }];
        }];
    }
}

#pragma mark -

- (void)setupFrames {
    [self.photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.with.equalTo(@60);
        make.bottom.equalTo(@-40);
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.photoBtn);
        make.left.equalTo(@20);
    }];
    [self.focusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.width.height.equalTo(@80);
    }];
    [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cancelBtn);
        make.right.equalTo(@-20);
    }];
}

- (void)setupViews {
    [self.view addSubview:self.cancelBtn];
    [self.view addSubview:self.photoBtn];
    [self.view addSubview:self.focusView];
    [self.view addSubview:self.changeBtn];
}

- (void)customCamera {
    // 后置摄像头
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 使用后置摄像头初始化输入设备
    self.input = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:nil];
    // 生成输出对象
    self.outPut = [[AVCaptureMetadataOutput alloc] init];
    
    self.imageOutPut = [[AVCaptureStillImageOutput alloc] init];
    
    self.session = [[AVCaptureSession alloc] init];
    
    /*
    if ([self.session canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
        [self.session setSessionPreset:AVCaptureSessionPreset1280x720];
    }
    */
    
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    
    if ([self.session canAddOutput:self.imageOutPut]) {
        [self.session addOutput:self.imageOutPut];
    }
    
    // 使用self.session，初始化预览层，self.session负责驱动input进行信息的采集，layer负责把图像渲染显示
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.frame = CGRectMake(0, 0, YYScreenSize().width, YYScreenSize().height);
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.previewLayer];
    
    [self.session startRunning];
    
    if ([self.device lockForConfiguration:nil]) {
        
        // 闪光灯自动
//        if ([self.device isFlashModeSupported:AVCaptureFlashModeOff]) {
//            [self.device setFlashMode:AVCaptureFlashModeOff];
//        }
        
        // 自动白平衡
        if ([self.device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
            [self.device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
        }
        
        // 解锁
        [self.device unlockForConfiguration];
        
    }
}

#pragma mark - 相机权限
- (BOOL)checkCameraPermission {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied) {
        [SVProgressHUD showInfoWithStatus:@"请在'设置-隐私-相机'中打开相机权限"];
        return NO;
    }
    else {
        return YES;
    }
}

#pragma mark - 保存到相册
- (void)saveImageWithImage:(UIImage *)image {
    __block PHObjectPlaceholder *createdAsset = nil;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized) {
            NSLog(@"保存到相册失败:没有相册权限");
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *error = nil;
            
            [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
                if (@available(iOS 9.0, *)) {
                    createdAsset = [PHAssetCreationRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset;
                } else {
                    // iOS 9 一下不适配
                }
            } error:&error];
            
            if (error) {
                NSLog(@"保存失败:%@",error.description);
                return;
            }
            
        });
    }];
}

#pragma mark - 前后摄像头切换
- (void)changeCamera {
    // 获取摄像头的数量
    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    if (cameraCount <= 1) {
        return;
    }
    
    AVCaptureDevice *newCamera = nil;
    AVCaptureDeviceInput *newInput = nil;
    // 相机方向
    AVCaptureDevicePosition position = [[self.input device] position];
    /*
    CATransition *animation = [CATransition animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.25;
    animation.type = @"oglFlip";
    
    if (position == AVCaptureDevicePositionFront) {
        newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
        animation.subtype = kCATransitionFromLeft;
    }
    else {
        newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
        animation.subtype = kCATransitionFromRight;
    }
    
    [self.previewLayer addAnimation:animation forKey:nil];*/
    if (position == AVCaptureDevicePositionFront) {
        newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
    }
    else {
        newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
    }
    // 输入流
    newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
    
    if (newInput != nil) {
        [self.session beginConfiguration];
        [self.session removeInput:self.input];
        if ([self.session canAddInput:newInput]) {
            [self.session addInput:newInput];
            self.input = newInput;
        }
        else {
            [self.session addInput:self.input];
        }
        [self.session commitConfiguration];
    }
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (device.position == position) {
            return device;
        }
    }
    return nil;
}

#pragma mark - 相机状态
- (void)changeCameraRunState:(BOOL)isRunning {
    if (isRunning) {
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.changeBtn setTitle:@"切换" forState:UIControlStateNormal];
        [self.photoBtn setHidden:NO];
    }
    else {
        [self.cancelBtn setTitle:@"重拍" forState:UIControlStateNormal];
        [self.changeBtn setTitle:@"使用照片" forState:UIControlStateNormal];
        [self.photoBtn setHidden:YES];
    }
}

#pragma mark - Lazy load

- (UIButton *)changeBtn {
    if (!_changeBtn) {
        _changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changeBtn setTitle:@"切换" forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        [[_changeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if ([weakSelf.session isRunning]) {
                [weakSelf changeCamera];
            }
            else {
                if (weakSelf.photoBlock) {
                    weakSelf.photoBlock(weakSelf.currentPhoto);
                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
                }
            }
        }];
    }
    return _changeBtn;
}

- (UIView *)focusView {
    if (!_focusView) {
        _focusView = [UIView new];
        _focusView.hidden = YES;
        _focusView.layer.borderWidth = 1;
        _focusView.layer.borderColor = [UIColor orangeColor].CGColor;
    }
    return _focusView;
}

- (UIButton *)photoBtn {
    if (!_photoBtn) {
        _photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_photoBtn setImage:[UIImage imageNamed:@"photograph"] forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        [[_photoBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            AVCaptureConnection *videoConnection = [weakSelf.imageOutPut connectionWithMediaType:AVMediaTypeVideo];
            if (videoConnection == nil) {
                [SVProgressHUD showErrorWithStatus:@"拍照失败"];
                return;
            }
            
            [weakSelf.imageOutPut captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef  _Nullable imageDataSampleBuffer, NSError * _Nullable error) {
               
                if (imageDataSampleBuffer == nil) {
                    [SVProgressHUD showErrorWithStatus:@"拍照失败"];
                    return;
                }
                
                NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
                UIImage *image = [UIImage imageWithData:imageData];
                [weakSelf saveImageWithImage:image];
                weakSelf.currentPhoto = image;
                
                [weakSelf.session stopRunning];
                
                [weakSelf changeCameraRunState:NO];
            }];
            
        }];
    }
    return _photoBtn;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        [[_cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if ([weakSelf.session isRunning]) {
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }
            else {
                [weakSelf.session startRunning];
                [weakSelf changeCameraRunState:YES];
            }
        }];
    }
    return _cancelBtn;
}

@end
