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
@interface WYEditViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)WYEditHeaderView * headerView;
@property(nonatomic,strong)NSArray * titleArray;
@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation WYEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self initData];
}

-(void)initUI
{
   
    [self.rightButton setTitle:@"保存" forState:UIControlStateNormal];
}
-(void)initData
{
    self.titleArray = @[@"昵称",@"性别",@"生日",@"星座"];
    [self.dataArray addObject:@"昵称最多八个字"];
    [self.dataArray addObject:@"小哥哥"];
    [self.dataArray addObject:@"1991-03-20"];
    [self.dataArray addObject:@"双鱼座"];
    [self.tableView reloadData];
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
        NSString *dateString = [selectDate stringWithFormat:@"yyyy-MM-dd"];

        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        NSDate *mydate=[formatter dateFromString:dateString];
        [formatter setDateFormat:@"MM"];
        int currentMonth=[[formatter stringFromDate:mydate]intValue];
        [formatter setDateFormat:@"dd"];
        int currentDay=[[formatter stringFromDate:mydate] intValue];
     
        NSString * constellation = [NSString getAstroWithMonth:currentMonth day:currentDay];
        
        [self.dataArray replaceObjectAtIndex:2 withObject:dateString];
        [self.dataArray replaceObjectAtIndex:3 withObject:constellation];
        [self.tableView reloadData];

    }];
    datepicker.doneButtonColor = [UIColor binaryColor:@"6950FB"];//确定按钮的颜色
    [datepicker show];
}


-(WYEditHeaderView*)headerView
{
    if (!_headerView) {
        _headerView = [[WYEditHeaderView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 184)];
    
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
