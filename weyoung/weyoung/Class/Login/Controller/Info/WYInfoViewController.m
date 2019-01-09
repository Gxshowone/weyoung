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
#import "WSDatePickerView.h"
#import "NSString+Validation.h"
@interface WYInfoViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UIButton * picButton;
@property(nonatomic,strong)WYNickNameInputView * nickInputView;
@property(nonatomic,strong)UIButton * dateButton;
@property(nonatomic,strong)UIButton * manButton;
@property(nonatomic,strong)UIButton * womanButton;
@property(nonatomic,strong)WYGradientButton * startButton;
@property(nonatomic,copy)NSString * dateString;
@property(nonatomic,copy)NSString * sex;
@property(nonatomic,copy)NSString * signUrl;
@property(nonatomic,copy)NSString * avatar_str;

@end

@implementation WYInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.picButton];
    [self.view addSubview:self.nickInputView];
    [self.view addSubview:self.dateButton];
    [self.view addSubview:self.manButton];
    [self.view addSubview:self.womanButton];
    [self.view addSubview:self.startButton];
    
    self.manButton.selected = YES;
    self.sex = @"1";

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
            
           [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            
            
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
    NSData * data = UIImageJPEGRepresentation(avatarImage, 1.0);
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request put_uploadFileWithURLString:self.signUrl rename:@"user_photo" orFromData:data];
    
}


-(void)getSignUrl
{

    NSDictionary * dict = @{@"phone":self.phone,@"zone_num":@"86",@"interface":@"File@getUploadUrl",@"source":@"1",@"uid":self.uid};
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
        
        self.signUrl = [NSString stringWithFormat:@"%@",[response valueForKey:@"signedUrl"]];
    };
    
    request.failureDataBlock = ^(id  _Nonnull error) {
        
    };
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.picButton.frame = CGRectMake(KScreenWidth/2-43, KNaviBarHeight+52, 86, 86);
    self.nickInputView.frame =   CGRectMake(27.5, KNaviBarHeight+196, KScreenWidth-55, 50);
    
    self.dateButton.frame = CGRectMake(27.5, CGRectGetMaxY(self.nickInputView.frame)+21, KScreenWidth-55, 50);
    
    CGFloat w = (KScreenWidth-75)/2;
    self.manButton.frame =  CGRectMake(27.5, CGRectGetMaxY(self.picButton.frame)+199, w, 50);
    self.womanButton.frame =  CGRectMake(CGRectGetMaxX(self.manButton.frame)+20, CGRectGetMaxY(self.picButton.frame)+199, w, 50);
    
    self.startButton.frame = CGRectMake(35.5, KScreenHeight-KTabbarSafeBottomMargin-158, KScreenWidth-71, 50);
     self.startButton.style = WYGradientButtonRectangle;

}

-(void)showDataPicker
{
    //年-月-日
    @weakify(self);
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
        @strongify(self);
        self.dateString = [selectDate stringWithFormat:@"yyyy-MM-dd"];
        NSLog(@"选择的日期：%@",self.dateString);
        [self.dateButton setTitle:self.dateString forState:UIControlStateNormal];
        [self.dateButton setTitleColor:[UIColor binaryColor:@"FFFFFF"] forState:UIControlStateNormal];
    }];
    datepicker.doneButtonColor = [UIColor binaryColor:@"6950FB"];//确定按钮的颜色
    [datepicker show];
}

-(UIButton*)picButton
{
    if (!_picButton) {
        _picButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [_picButton setImage:[UIImage imageNamed:@"login_pic_btn"] forState:UIControlStateNormal];
        
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

-(WYNickNameInputView*)nickInputView
{
    if (!_nickInputView) {
        _nickInputView = [[WYNickNameInputView alloc]init];
    }
    return _nickInputView;

}

-(UIButton*)dateButton
{
    if (!_dateButton) {
        _dateButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [_dateButton setTitle:@"选择生日" forState:UIControlStateNormal];
        [_dateButton setTitleColor:[[UIColor binaryColor:@"FFFFFF"] colorWithAlphaComponent:0.3] forState:UIControlStateNormal];
        _dateButton.layer.cornerRadius = 26.94;
        _dateButton.layer.borderWidth  = 1;
        _dateButton.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.15].CGColor;
        @weakify(self);
        [[_dateButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self showDataPicker];
        }];
        
        CGFloat edgeLeft = KScreenWidth/2;
        _dateButton.titleEdgeInsets =  UIEdgeInsetsMake(0, -(edgeLeft+20), 0, 0);
        _dateButton.titleLabel.font = [UIFont fontWithName:TextFontName_Light size:16];
    }
    return _dateButton;
    
}



-(UIButton*)manButton
{
    if (!_manButton) {
        _manButton =[UIButton buttonWithType:UIButtonTypeCustom];
        _manButton.layer.cornerRadius = 27.5;
        _manButton.layer.masksToBounds = YES;
        [_manButton setTitle:@"小哥哥" forState:UIControlStateNormal];
        _manButton.titleLabel.font = [UIFont fontWithName:TextFontName_Light size:16];
        
        CGSize titleSize =_manButton.titleLabel.bounds.size;
        CGSize imageSize = _manButton.imageView.bounds.size;
        _manButton.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width, 0, -titleSize.width);
        _manButton.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, 0, imageSize.width);
        
        [_manButton setImage:[UIImage imageNamed:@"login_man_btn_unselect"] forState:UIControlStateNormal];
        [_manButton setImage:[UIImage imageNamed:@"login_man_btn_select"] forState:UIControlStateSelected];
        
        [_manButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_manButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.3]  forState:UIControlStateNormal];
        [_manButton setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.15]];
        
        @weakify(self);
        [[_manButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
          
            self.manButton.selected = YES;
            self.womanButton.selected = NO;
            [self.manButton setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.15]];
            [self.womanButton setBackgroundColor:[UIColor clearColor]];
            
            self.womanButton.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.15].CGColor;
            self.womanButton.layer.borderWidth = 1;
            self.manButton.layer.borderWidth = 0;
            self.sex = @"1";
        }];
    }
    return _manButton;
    
}

-(UIButton*)womanButton
{
    if (!_womanButton) {
        _womanButton =[UIButton buttonWithType:UIButtonTypeCustom];
        _womanButton.layer.cornerRadius = 27.5;
        _womanButton.layer.masksToBounds = YES;
        _womanButton.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.15].CGColor;
        _womanButton.layer.borderWidth = 1;
        
        
        [_womanButton setTitle:@"小姐姐" forState:UIControlStateNormal];
        _womanButton.titleLabel.font = [UIFont fontWithName:TextFontName_Light size:16];
        
        CGSize titleSize =_womanButton.titleLabel.bounds.size;
        CGSize imageSize = _womanButton.imageView.bounds.size;
        _womanButton.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width, 0, -titleSize.width);
        _womanButton.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, 0, imageSize.width);
        
        [_womanButton setImage:[UIImage imageNamed:@"login_woman_btn_unselect"] forState:UIControlStateNormal];
        [_womanButton setImage:[UIImage imageNamed:@"login_woman_btn_select"] forState:UIControlStateSelected];
        
        [_womanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_womanButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.3]  forState:UIControlStateNormal];
        
        [_womanButton setBackgroundColor:[UIColor clearColor]];
        
        @weakify(self);
        [[_womanButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
           
            self.manButton.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.15].CGColor;
            self.manButton.layer.borderWidth = 1;
            self.womanButton.layer.borderWidth = 0;
            
            self.manButton.selected = NO;
            self.womanButton.selected = YES;
            [self.womanButton setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.15]];
            [self.manButton setBackgroundColor:[UIColor clearColor]];
            self.sex = @"2";
    
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
            [self checkUserInfo];
        }];
    }
    return _startButton;
    
}

-(void)checkUserInfo
{
  
    if ([self.avatar_str isEmpty]) {
        [self.view makeToast:@"请先上传头像" duration:3.0 position:CSToastPositionCenter];
        return;
        
    }
    
    if ([[self.nickInputView inputText] isEmpty]) {
        [self.view makeToast:@"请输入昵称" duration:3.0 position:CSToastPositionCenter];
        return;
        
    }
    
    if ([self.dateString isEmpty]) {
        [self.view makeToast:@"请选择生日" duration:3.0 position:CSToastPositionCenter];
        return;
        
    }
    
    [self registerUser];
    
}

-(void)registerUser;
{
  
    NSDictionary * dict = @{@"header_url":self.avatar_str,@"nick_name":[self.nickInputView inputText],@"birthday":self.dateString,@"gender":self.sex, @"phone":self.phone,@"zone_num":@"86",@"interface":@"Login@register",@"step":@"4"};
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
        
        WYSession * session = [WYSession sharedSession];
        [session updateUser:response];
        
        //链接容云
        [self connectRcWithToken:session.rc_token];
        
        WYHomePageViewController * hpVC = [WYHomePageViewController new];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:hpVC];
        [UIApplication sharedApplication].keyWindow.rootViewController = nav;
        
    };
    
    request.failureDataBlock = ^(id  _Nonnull error) {
        
    };
}

-(void)connectRcWithToken:(NSString*)rctoken
{
    [[RCIM sharedRCIM] connectWithToken:rctoken  success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
}


-(void)setUid:(NSString *)uid
{
    _uid = uid;
}

-(void)setPhone:(NSString *)phone
{
    _phone = phone;
    [self getSignUrl];
}

@end
