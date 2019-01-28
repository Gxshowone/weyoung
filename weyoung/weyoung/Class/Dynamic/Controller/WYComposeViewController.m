//
//  WYComposeViewController.m
//  weyoung
//
//  Created by gongxin on 2019/1/2.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYComposeViewController.h"
#import "WYTextView.h"
#import "WYComposePhotosView.h"
#import "WYComposeToolBar.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "WYAssets.h"
#import "WYDynamicModel.h"
#import "NSString+Extension.h"

@interface WYComposeViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic , strong) WYTextView *textView;
@property (nonatomic , strong) WYComposeToolBar *toolbar;
@property (nonatomic , strong) WYComposePhotosView *photosView;

//是否正在切换键盘
@property (nonatomic ,assign, getter=isChangingKeyboard) BOOL ChangingKeyboard;

@property(nonatomic,copy)NSString * signUrl;
@property(nonatomic,copy)NSString * key;

@end

@implementation WYComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navigationConfig];
    [self setupTextView];
    [self setupPhotosView];
    [self setupToolbar];
    [self getSignUrl];
    
}

-(void)getSignUrl
{
    
    NSDictionary * dict = @{@"interface":@"File@getUploadUrl",@"source":@"2"};
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
        
        self.key = [NSString stringWithFormat:@"%@",[response valueForKey:@"key"]];
        self.signUrl = [NSString stringWithFormat:@"%@",[response valueForKey:@"signedUrl"]];
    };
    
    request.failureDataBlock = ^(id  _Nonnull error) {
        
    };
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.textView.frame = CGRectMake(20, KNaviBarHeight+10, KScreenWidth-40, KScreenHeight-KNaviBarHeight);
    self.photosView.frame= CGRectMake(0, 166+KNaviBarHeight, KScreenWidth, 130);
   
}

/**
 *  view显示完毕的时候再弹出键盘，避免显示控制器view的时候会卡住
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self.textView becomeFirstResponder];
}

-(void)navigationConfig
{
    [self.rightButton setImage:[UIImage imageNamed:@"dynamic_release_btn"] forState:UIControlStateNormal];
    [self.rightButton setAlpha:0.3];
    self.rightButton.userInteractionEnabled = NO;
    @weakify(self);
    [[self.leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
          [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [[self.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self sendDynamic];
        
    }];
    
    self.rightButton.alpha = 0.3;
    self.rightButton.userInteractionEnabled = NO;
}

-(void)sendDynamic
{

    NSString * type = ([self.photosView hasImage])?@"2":@"1";
    
    NSDictionary * dict ;
    if ([type isEqualToString:@"1"]) {
         dict = @{@"content":self.textView.text,@"interface":@"Dynamic@PubDynamic",@"type":type};
    }else if([type isEqualToString:@"2"])
    {
        dict = @{@"image":self.key,@"content":self.textView.text,@"interface":@"Dynamic@PubDynamic",@"type":type};
    }
    

    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
        
        
    
        WYDynamicModel * model = [[WYDynamicModel alloc]init];
        model.image = ([self.photosView hasImage])?[response valueForKey:@"image"]:@"";
        model.praise_count = 0;
        model.uid = [WYSession sharedSession].uid;
        model.type = [type integerValue];
        model.d_id = @"";
        model.nick_name = [WYSession sharedSession].nickname;
        model.header_url = [WYSession sharedSession].avatar;
        model.create_time = [NSString getNowTimeTimestamp];
        model.content = self.textView.text;
        [[NSNotificationCenter defaultCenter] postNotificationName:WYComposeSusscess object:model];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    };
    
    request.failureDataBlock = ^(id  _Nonnull error) {
        
    };
    
}


// 添加工具条
- (void)setupToolbar {
    
    WYComposeToolBar *toolbar = [[WYComposeToolBar alloc] init];
    toolbar.width = self.view.width;
    toolbar.height = 50;
    self.toolbar = toolbar;
    toolbar.y = self.view.height - toolbar.height;
    @weakify(self);
    [[toolbar.photoButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied)
        {
            //无权限
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先在隐私中设置相册权限" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
            
            
        }else{
            
            UIImagePickerController *imgpicker = [[UIImagePickerController alloc]init];
            imgpicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imgpicker.allowsEditing = YES;
            imgpicker.delegate = self;
            [[imgpicker navigationBar] setTintColor:[UIColor blackColor]];
            [self presentViewController:imgpicker animated:YES completion:nil];
        }
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        
    }];
    [self.view addSubview:toolbar];
}



// 添加输入控件
- (void)setupTextView {
    
    // 1.创建输入控件
    WYTextView *textView = [[WYTextView alloc] init];
    
    textView.alwaysBounceVertical = YES ;//垂直方向上有弹簧效果
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 2.设置提醒文字
    textView.placeholder = @"记录夜晚的美好...";
    
    // 3.设置字体
    textView.font = [UIFont systemFontOfSize:15];
    
    // 4.监听键盘
    // 键盘的frame(位置)即将改变, 就会发出UIKeyboardWillChangeFrameNotification
    // 键盘即将弹出, 就会发出UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    @weakify(self);
    [self.textView.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
        @strongify(self);
        
        self.rightButton.alpha = (IsStrEmpty(x))?0.3:1.0;
        self.rightButton.userInteractionEnabled = (IsStrEmpty(x))?NO:YES;
        
    }];
    
    
}

// 添加显示图片的相册控件
- (void)setupPhotosView {
    
    WYComposePhotosView *photosView = [[WYComposePhotosView alloc] initWithFrame:CGRectMake(0, 166+KNaviBarHeight, KScreenWidth, 130)];
    @weakify(self);
    photosView.block = ^(NSInteger count) {
         @strongify(self);
        
        self.rightButton.alpha = (count==0)?0.3:1.0;
        self.rightButton.userInteractionEnabled = (count==0)?NO:YES;
        
    };
    [self.view addSubview:photosView];
    self.photosView = photosView;
}




- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    WYAssets * asset = [[WYAssets alloc]init];
    asset.photo = image;
    NSMutableArray * array = [NSMutableArray arrayWithObjects:asset, nil];
    [self.photosView setData:array];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self uploadimageWithImage:image];

  
}

//上传头像
-(void)uploadimageWithImage:(UIImage*)avatarImage
{

    NSData * data = UIImageJPEGRepresentation(avatarImage, 0.5);
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request put_uploadFileWithURLString:self.signUrl rename:@"user_photo" orFromData:data];
    
}


#pragma mark - 键盘处理
/**
 *  键盘即将隐藏：工具条（toolbar）随着键盘移动
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    //需要判断是否自定义切换的键盘
    if (self.isChangingKeyboard) {
        self.ChangingKeyboard = NO;
        return;
    }
    
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;//回复之前的位置
    }];
}

/**
 *  键盘即将弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘高度
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, - keyboardH);
    }];
}



/**
 *  监听文字该表
 *
 *  @param textView
 */
- (void)textViewDidChange:(UITextView *)textView
{
    self.rightButton.alpha = (textView.hasText)?1.0:0.3;
    self.rightButton.userInteractionEnabled = textView.hasText;
    
    NSString * count = [NSString stringWithFormat:@"%ld",[textView.text length]];
    [self.toolbar updateCount:count];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
   //如果是删除减少字数，都返回允许修改
    if ([text isEqualToString:@""]) {
            return YES;
    }
    if (range.location>= 220)
    {
            return NO;
    }
    else
    {
          return YES;
    }
 }

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboarWYegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
