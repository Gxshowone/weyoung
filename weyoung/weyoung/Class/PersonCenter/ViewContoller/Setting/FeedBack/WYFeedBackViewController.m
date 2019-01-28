//
//  WYFeedBackViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/9.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYFeedBackViewController.h"

@interface WYFeedBackViewController ()<UITextViewDelegate>

@property(nonatomic,strong)UIView * bgView;
@property(nonatomic,strong)UITextView * textView;
@property(nonatomic,strong)UILabel * countLabel;
@property(nonatomic,strong)UILabel * holderLabel;
@property(nonatomic,assign)NSInteger count;

@end

@implementation WYFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.bgView.frame = CGRectMake(25, KNaviBarHeight+25, KScreenWidth-50, 320);
    self.textView.frame = CGRectMake(20, 12.5, KScreenWidth-90, 280);
    self.holderLabel.frame = CGRectMake(20, 12.5, 192, 27);
    self.countLabel.frame = CGRectMake(self.bgView.width-100-16, 279.5, 100, 27);
}

-(void)initUI
{
    [self setNavTitle:@"问题反馈"];
    [self.rightButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.textView];
    [self.bgView addSubview:self.countLabel];
    [self.bgView addSubview:self.holderLabel];
    
    [[self.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSString * type = @"3";
        NSString * reasonString = @"7";
        NSDictionary * dict = @{@"id":@"",@"type":type,@"interface":@"User@report",@"reason":reasonString,@"remark":self.textView.text};
        WYHttpRequest *request = [[WYHttpRequest alloc]init];
        [request requestWithPragma:dict showLoading:NO];
        request.successBlock = ^(id  _Nonnull response) {
            
            [[UIApplication sharedApplication].keyWindow makeToast:@"举报成功"];
        };
        
        request.failureDataBlock = ^(id  _Nonnull error) {
            
        };
    }];
}




-(UILabel*)holderLabel
{
    if (!_holderLabel) {
        _holderLabel = [[UILabel alloc] init];
        _holderLabel.font = [UIFont fontWithName:TextFontName_Light size:16];
        _holderLabel.textColor = [UIColor binaryColor:@"999999"];
        _holderLabel.text = @"留下您的宝贵意见或建议";
    }

    return _holderLabel;
}

-(UILabel*)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.font = [UIFont fontWithName:TextFontName_Light size:16];
        _countLabel.textColor = [UIColor binaryColor:@"979797"];
        _countLabel.text = @"0/200";
        _countLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _countLabel;
}

-(UITextView*)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.delegate = self;
        _textView.font = [UIFont fontWithName:TextFontName_Light size:16];
        _textView.textColor = [UIColor whiteColor];
        _textView.backgroundColor = [UIColor clearColor];
        @weakify(self);
        
        [_textView.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            NSLog(@"%@",x);
            @strongify(self);
            self.count = [x length];
            self.countLabel.text = [NSString stringWithFormat:@"%ld/200字",(long)self.count];
            self.holderLabel.hidden = (self.count==0)?NO:YES;
            
        }];
    }
    return _textView;

}

-(UIView*)bgView
{
    if (!_bgView) {
        _bgView  = [UIView new];
        _bgView.layer.cornerRadius = 10;
        _bgView.layer.borderColor = [UIColor binaryColor:@"333333"].CGColor;
        _bgView.layer.borderWidth = 1;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
    
}

-(BOOL)textView:(UITextView *)textview shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.textView resignFirstResponder];
        return YES;
    }
    if([[self.textView text] length]>200){
        return NO;
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.holderLabel.hidden = YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.holderLabel.hidden = (self.count==0)?NO:YES;
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
