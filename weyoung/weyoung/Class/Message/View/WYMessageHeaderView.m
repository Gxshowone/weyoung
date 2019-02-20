//
//  WYMessageHeaderView.m
//  weyoung
//
//  Created by gongxin on 2019/1/10.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYMessageHeaderView.h"
#import "WYMessageHeaderTableViewCell.h"
@interface WYMessageHeaderView() <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,strong)UIView * lineView;
@property(nonatomic,strong)UILabel * footerLabel;
@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation WYMessageHeaderView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor clearColor];
        self.scrollEnabled = NO;
  
        [self setData];
    }
    return self;
}

-(void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update) name:WYSYSTEMMESSAGE object:nil];
   
}

-(void)updatNotification:(NSNotification *)note
{
    
}

-(void)setData
{
    NSDictionary * weiyang = @{@"image":@"message_weiyang",@"title":@"未央"};
    NSDictionary * common = @{@"image":@"message_common",@"title":@"评论"};
    NSDictionary * like = @{@"image":@"message_like",@"title":@"点赞"};
    [self.dataArray addObject:weiyang];
    [self.dataArray addObject:common];
    [self.dataArray addObject:like];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid = @"WYMessageHeaderTableViewCell";
    
    WYMessageHeaderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell) {
        cell = [[WYMessageHeaderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.backgroundColor = [UIColor blackColor];
    cell.data = self.dataArray[indexPath.row];
    
    switch (indexPath.row) {
        case 0:
        {
            [cell getSystemCount];
        }
            break;
            case 1:
        {
            
        }
            break;
            case 2:
        {
            
        }
            break;
        default:
            break;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(nullable UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(nullable UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return self.footerLabel;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.prtocal)
    {
        [self.prtocal didSelectRowAtIndexPath:indexPath];
    }
}

-(UIView*)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
        _lineView.frame = CGRectMake(20, 0, KScreenWidth-20, 1);
    }
    return _lineView;
}

-(UILabel*)footerLabel
{
    if (!_footerLabel) {
        _footerLabel = [[UILabel alloc]initWithFrame: CGRectMake(0, 0, KScreenWidth, 60)];
        _footerLabel.text = @"    消息";
        _footerLabel.textAlignment = NSTextAlignmentLeft;
        _footerLabel.font = [UIFont fontWithName:TextFontName size:18];
        _footerLabel.backgroundColor = [UIColor blackColor];
        _footerLabel.textColor = [UIColor whiteColor];
        [_footerLabel addSubview:self.lineView];
    }
    return _footerLabel;
}

-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
