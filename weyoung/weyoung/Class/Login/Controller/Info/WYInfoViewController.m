//
//  WYInfoViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/7.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYInfoViewController.h"
#import "WYNickNameInputView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import "WYGradientButton.h"
#import "WYHomePageViewController.h"
@interface WYInfoViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UIButton * picButton;
@property(nonatomic,strong)WYNickNameInputView * nickInputView;
@property(nonatomic,strong)UIButton * manButton;
@property(nonatomic,strong)UIButton * womanButton;
@property(nonatomic,strong)WYGradientButton * startButton;

@end

@implementation WYInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.picButton];
    [self.view addSubview:self.nickInputView];
    [self.view addSubview:self.manButton];
    [self.view addSubview:self.womanButton];
    [self.view addSubview:self.startButton];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex

{
    UIImagePickerController *imgpicker = [[UIImagePickerController alloc]init];
    switch (buttonIndex) {
        case 0:
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
                {
                    //无权限
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设备的设置-隐私-相机中允许访问相机!" preferredStyle:UIAlertControllerStyleAlert];
                    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                    [self presentViewController:alert animated:YES completion:nil];
                    
                }else{
                    UIImagePickerController *imgpicker = [[UIImagePickerController alloc]init];
                    imgpicker.sourceType=UIImagePickerControllerSourceTypeCamera;
                    imgpicker.allowsEditing = YES;
                    imgpicker.delegate = self;
                    [[imgpicker navigationBar] setTintColor:[UIColor blackColor]];
                    [self presentViewController:imgpicker animated:YES completion:nil];
                }
            }
            else
            {
    
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"本设备不支持相机模式" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:alert animated:YES completion:nil];
                
                return;
            }
        }
            break;
        case 1:{
            NSLog(@"相册");
            ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
            if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied)
            {
                //无权限
    
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先在隐私中设置相册权限" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:alert animated:YES completion:nil];
                
                
            }else{
                imgpicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                imgpicker.allowsEditing = YES;
                imgpicker.delegate = self;
                [[imgpicker navigationBar] setTintColor:[UIColor blackColor]];
                [self presentViewController:imgpicker animated:YES completion:nil];
            }
            
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
            
            
            
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark imagePickerController methods
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo NS_DEPRECATED_IOS(2_0,3_0)
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self UploadimageWithImage:image];
    
}
#pragma mark Camera View Delegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self UploadimageWithImage:image];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//上传头像
-(void)UploadimageWithImage:(UIImage*)avatarImage
{
  
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.picButton.frame = CGRectMake(KScreenWidth/2-43, KNaviBarHeight+52, 86, 86);
    self.nickInputView.frame =   CGRectMake(27.5, KNaviBarHeight+196, KScreenWidth-55, 50);
    
    CGFloat w = (KScreenWidth-75)/2;
    self.manButton.frame =  CGRectMake(27.5, CGRectGetMaxY(self.picButton.frame)+199, w, 50);
    self.womanButton.frame =  CGRectMake(CGRectGetMaxX(self.manButton.frame)+20, CGRectGetMaxY(self.picButton.frame)+199, w, 50);
    
    self.startButton.frame = CGRectMake(35.5, KScreenHeight-KTabbarSafeBottomMargin-158, KScreenWidth-71, 50);
     self.startButton.style = WYGradientButtonRectangle;

}

-(UIButton*)picButton
{
    if (!_picButton) {
        _picButton =[UIButton buttonWithType:UIButtonTypeCustom];
        @weakify(self);
        [[_picButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
          
            
            UIActionSheet*actionSheet =[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选取", nil];
            actionSheet.delegate = self;
            actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
            [actionSheet showInView:self.view];
            
        }];
    }
    return _picButton;

}

-(UIButton*)manButton
{
    if (!_manButton) {
        _manButton =[UIButton buttonWithType:UIButtonTypeCustom];
        @weakify(self);
        [[_manButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
          
            
        }];
    }
    return _manButton;
    
}

-(UIButton*)womanButton
{
    if (!_womanButton) {
        _womanButton =[UIButton buttonWithType:UIButtonTypeCustom];
        @weakify(self);
        [[_womanButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
        
            
        }];
    }
    return _womanButton;
    
}

-(WYGradientButton*)startButton
{
    if (!_startButton) {
        _startButton =[WYGradientButton buttonWithType:UIButtonTypeCustom];
        [_startButton setTitleColor:[UIColor binaryColor:@"FFFFFF"] forState:UIControlStateNormal];
        _startButton.titleLabel.font = [UIFont fontWithName:TextFontName size:18];
        [_startButton setTitle:@"开启未央" forState:UIControlStateNormal];
    
        @weakify(self);
        [[_startButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            WYHomePageViewController * hpVC = [WYHomePageViewController new];
            [UIApplication sharedApplication].keyWindow.rootViewController = hpVC;
        }];
    }
    return _startButton;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
