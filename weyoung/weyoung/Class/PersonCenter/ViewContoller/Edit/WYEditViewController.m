//
//  WYEditViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/8.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYEditViewController.h"
#import "WYEditHeaderView.h"
#import "WYEditTableViewCell.h"
#import "WSDatePickerView.h"
#import "NSString+Extension.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
@interface WYEditViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)WYEditHeaderView * headerView;
@property(nonatomic,strong)NSArray * titleArray;
@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,copy)NSString * dateString;
@property(nonatomic,copy)NSString * sex;
@property(nonatomic,copy)NSString * signUrl;
@property(nonatomic,copy)NSString * avatar_str;
@property(nonatomic,copy)NSString * key;

@end

@implementation WYEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self initData];
    [self initUI];
    [self getSignUrl];
}

-(void)initUI
{
    [self.rightButton setTitle:@"保存" forState:UIControlStateNormal];
    
    @weakify(self);
    [[self.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self changeUserInfo];
        
    }];
}
-(void)initData
{
    
    self.titleArray = @[@"昵称",@"性别",@"生日",@"星座"];
    
    NSString * nick = [WYSession sharedSession].nickname;
    BOOL isMan =  [[WYSession sharedSession].sex isEqualToString:@"1"];
    NSString * gender = (isMan)?@"小哥哥":@"小姐姐";
    self.dateString = [WYSession sharedSession].birthday;
    NSString * xingzuo = [NSString stringWithFormat:@"%@座",[NSString getAstroWithBrith:self.dateString]];
    
    [self.dataArray addObject:nick];
    [self.dataArray addObject:gender];
    [self.dataArray addObject:self.dateString];
    [self.dataArray addObject:xingzuo];

    [self.tableView reloadData];
    
    NSString * avatar = [WYSession sharedSession].avatar;
    [self.headerView setAvatar:avatar];
}

-(void)changeUserInfo
{
    [self stopEdit];
    
    NSDictionary * dict = @{@"header_url":self.key,@"nick_name":[self nick],@"birthday":self.dateString,@"interface":@"User@changeUserInfo"};
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
        
        [WYSession sharedSession].nickname = [self nick];
        [WYSession sharedSession].birthday = self.dateString;
        NSString * avatar = [NSString stringWithFormat:@"%@",[response valueForKey:@"header_url"]];

        if (IsStrEmpty(avatar)==NO) {
            [WYSession sharedSession].avatar  = avatar;
            [[NSNotificationCenter defaultCenter] postNotificationName:WYNotifacationUserInfoChange object:nil];
            
        }

        [self.view makeToast:@"修改成功"];
    };
    
    request.failureDataBlock = ^(id  _Nonnull error) {
        
         [self.view makeToast:@"修改失败"];
    };
    
    
}


-(void)stopEdit
{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0  inSection:0];
    WYEditTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell stopEdit];
}

-(NSString*)nick
{
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0  inSection:0];
    WYEditTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    return  [cell inputText];
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
    
    [self.headerView.avatarButton setImage:avatarImage forState:UIControlStateNormal];

    NSData * data = UIImageJPEGRepresentation(avatarImage, 0.5);
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request put_uploadFileWithURLString:self.signUrl rename:@"user_photo" orFromData:data];
    
}


-(void)getSignUrl
{

    NSDictionary * dict = @{@"interface":@"File@getUploadUrl",@"source":@"1"};
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
        
        self.key = [NSString stringWithFormat:@"%@",[response valueForKey:@"key"]];
        self.signUrl = [NSString stringWithFormat:@"%@",[response valueForKey:@"signedUrl"]];
    };
    
    request.failureDataBlock = ^(id  _Nonnull error) {
        
    };
}


#pragma mark - TabelView delegate 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 70;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.titleArray count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 184;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return self.headerView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
 
    static NSString * cellId = @"WYEditTableViewCell";
    WYEditTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell  = [[WYEditTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==0||indexPath.row==2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.canEdit = (indexPath.row==0)?YES:NO;
    [cell setTitle:self.titleArray[indexPath.row]];
    [cell setContent:self.dataArray[indexPath.row]];
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==2) {
        [self showDataPicker];
    }
    
}

-(void)showDataPicker
{
    //年-月-日
    @weakify(self);
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
        @strongify(self);
        self.dateString = [selectDate stringWithFormat:@"yyyy-MM-dd"];
        NSString * xingzuo = [NSString stringWithFormat:@"%@座",[NSString getAstroWithBrith:self.dateString]];
  
        [self.dataArray replaceObjectAtIndex:2 withObject:self.dateString];
        [self.dataArray replaceObjectAtIndex:3 withObject:xingzuo];
        [self.tableView reloadData];

    }];
    datepicker.doneButtonColor = [UIColor binaryColor:@"6950FB"];//确定按钮的颜色
    [datepicker show];
}


-(WYEditHeaderView*)headerView
{
    if (!_headerView) {
        _headerView = [[WYEditHeaderView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 184)];
        
        @weakify(self);
        [[_headerView.avatarButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            UIActionSheet*actionSheet =[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选取", nil];
            actionSheet.delegate = self;
            actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
            [actionSheet showInView:self.view];
            
        }];
    }
    return _headerView;

}

-(UITableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KNaviBarHeight, KScreenWidth, KScreenHeight-KNaviBarHeight) style:UITableViewStyleGrouped];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
    
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
