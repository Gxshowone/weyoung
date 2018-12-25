//
//  WYReportView.m
//  weyoung
//
//  Created by gongxin on 2018/12/22.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYReportView.h"
#import "WYReportCollectionViewCell.h"
@interface WYReportView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)UIView * horView,* verView;
@property(nonatomic,strong)UIButton * cancleButton;
@property(nonatomic,strong)UIButton * sureButton;
@property(nonatomic,strong)UIView * alertView;
@property(nonatomic,strong)NSArray * titleArray;
@property(nonatomic,assign)NSInteger selectIndex;

@end
@implementation WYReportView

- (instancetype)init
{
    if (self == [super init]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.8];
        
        [self.alertView addSubview:self.titleLabel];
        [self.alertView addSubview:self.collectionView];
        [self.alertView addSubview:self.horView];
        [self.alertView addSubview:self.verView];
        [self.alertView addSubview:self.cancleButton];
        [self.alertView addSubview:self.sureButton];
        [self addSubview:self.alertView];
        
        [self initData];
        
    }
    
    return self;
}

-(void)initData
{
    self.titleArray = @[@"骚扰广告",@"欺诈行为",@"辱骂行为",@"低俗或色情",@"传播垃圾信息",@"其他违法行为"];
    [self.collectionView reloadData];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(25, 40.6, 108, 27);
    self.horView.frame = CGRectMake(0, 259.5, 325, 1);
    self.verView.frame = CGRectMake(162, 259.5, 1, 60);
    self.cancleButton.frame = CGRectMake(0, 259.5, 324/2, 60);
    self.sureButton.frame =  CGRectMake(324/2+1, 259.5, 324/2, 60);
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    WYReportCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WYReportCollectionViewCell" forIndexPath:indexPath];
    [cell setTitle:self.titleArray[indexPath.item]];
   
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _selectIndex = indexPath.item;
}


- (void)show
{

    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self showAnimation];
    
}
-(void)hide
{
    [self removeFromSuperview];
}
- (void)showAnimation
{
    self.alertView.layer.position = self.center;
    self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
}


-(UIView*)alertView
{
    if (!_alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectZero];
        _alertView.width = 325;
        _alertView.height = 320;
        _alertView.layer.cornerRadius = 20;
        _alertView.layer.masksToBounds = YES;
        _alertView.backgroundColor = [UIColor whiteColor];
    }
    return _alertView;
}

-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"选择举报原因";
        _titleLabel.textColor = [UIColor binaryColor:@"1D1D1D"];
        _titleLabel.font = [UIFont fontWithName:TextFontName size:18];
        
    }
    return _titleLabel;
}

-(UICollectionView*)collectionView
{
    if (!_collectionView) {
        
        
        //普通集合视图布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 23;
        layout.minimumInteritemSpacing = 15;
        layout.itemSize = CGSizeMake(130,30);
        
        _collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(25, 90,275, 150) collectionViewLayout:layout];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor binaryColor:@"FFFFFF"];
        [_collectionView registerClass:[WYReportCollectionViewCell class] forCellWithReuseIdentifier:@"WYReportCollectionViewCell"];
        
        
        
    }
    return _collectionView;
}

-(UIView*)horView
{
    if (!_horView) {
        _horView = [[UIView alloc]init];
        _horView.backgroundColor = [UIColor binaryColor:@"DDDDDD"];
        
    }
    return _horView;
}

-(UIView*)verView
{
    if (!_verView) {
        _verView = [[UIView alloc]init];
        _verView.backgroundColor = [UIColor binaryColor:@"DDDDDD"];
        
    }
    return _verView;
}
-(UIButton*)cancleButton
{
    if (!_cancleButton) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleButton setTitleColor:[UIColor binaryColor:@"333333"] forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = [UIFont systemFontOfSize:18];
        @weakify(self);
        [[_cancleButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self hide];
            
        }];
    }
    return _cancleButton;
}

-(UIButton*)sureButton
{
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setTitle:@"确认" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor binaryColor:@"007AFF"] forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:18];
        @weakify(self);
        [[_sureButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self hide];
            
            if (self.block) {
                self.block(self.selectIndex);
            }
        }];
    }
    return _sureButton;
}


@end
