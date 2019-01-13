//
//  WYEditTableViewCell.m
//  weyoung
//
//  Created by gongxin on 2018/12/8.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYEditTableViewCell.h"
#import "WYTextField.h"
@interface WYEditTableViewCell()<UITextFieldDelegate>

@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * contentLabel;
@property(nonatomic,strong)WYTextField * textField;


@end
@implementation WYEditTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.textField];
        
    }
    return self;
}

-(void)setCanEdit:(BOOL)canEdit
{
    _canEdit = canEdit;
    
    self.textField.hidden = !canEdit;
    self.contentLabel.hidden = canEdit;
}

-(void)setTitle:(NSString*)text
{
    self.titleLabel.text = text;
}
-(void)setContent:(NSString*)text
{
    self.contentLabel.text = text;
    self.textField.text = text;
}


-(void)stopEdit
{
    [self.textField resignFirstResponder];
}

-(NSString*)inputText
{
    return self.textField.text;
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(20, 15, 26, 17);
    self.contentLabel.frame = CGRectMake(20, 33.5,200, 22);
    self.textField.frame = CGRectMake(20, 33.5,200, 22);
    
}

-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont fontWithName:TextFontName size:12];
    }
    return _titleLabel;
}

-(UILabel*)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = [UIColor binaryColor:@"DCDEEA"];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont fontWithName:TextFontName_Light size:16];
        
    }
    return _contentLabel;
}

-(WYTextField*)textField
{
    if (!_textField) {
        _textField = [[WYTextField alloc]init];
        _textField.delegate = self;
        _textField.keyboardType = UIKeyboardTypeDefault;
        @weakify(self);
        [_textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            NSLog(@"%@",x);
            @strongify(self);
            
        }];
    }
    return _textField;
    
}



@end
