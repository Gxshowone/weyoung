//
//  WYMoreView.m
//  weyoung
//
//  Created by gongxin on 2018/12/22.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYMoreView.h"
#import "WYMoreCollectionViewCell.h"
#import "WYReportView.h"
#import "WYDataBaseManager.h"
@interface  WYMoreView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) NSArray *imageArray;
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)UIView   * horView;
@property (nonatomic,strong)UIButton * cancleButton;
@property (nonatomic,strong)CAShapeLayer *shapeLayer;

@end
@implementation WYMoreView

-(void)show
{
    [super show];
}

-(void)hide
{
    [super hide];
}

// 初始化子视图
- (void)initView
{
    [super initView];
    [self addShapeLayer];
    self.backgroundColor = [UIColor binaryColor:@"212121"];
    [self addSubview:self.collectionView];
    [self addSubview:self.horView];
    [self addSubview:self.cancleButton];
  
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.horView.frame = CGRectMake(0, 109, KScreenWidth, 1);
    self.cancleButton.frame = CGRectMake(0, 110, KScreenWidth, 50);
}

-(void)addShapeLayer
{
    UIRectCorner corner = UIRectCornerTopLeft | UIRectCornerTopRight;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                               byRoundingCorners:corner
                                                     cornerRadii:CGSizeMake(20,20)];
    self.shapeLayer.path = path.CGPath;
    self.layer.mask = self.shapeLayer;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    WYMoreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WYMoreCollectionViewCell" forIndexPath:indexPath];
    [cell setTitle:self.titleArray[indexPath.item]];
    [cell setImageName:self.imageArray[indexPath.item]];
   
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(20,30,10,15);
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.item) {
        case 0:
        {
            [self hide];
            
            
            WYReportView * reportView = [[WYReportView alloc]init];
            @weakify(self);
            reportView.block = ^(NSInteger index) {
                @strongify(self);
                [self report:index];
    
            };
            [reportView show];
        }
            break;
            case 1:
        {
            
            
            [self hide];
            
            [[WYDataBaseManager shareInstance] insertBlackListToDB:self.user];
            [[RCIMClient sharedRCIMClient] addToBlacklist:self.user.userId success:^{
               
                
                
            } error:^(RCErrorCode status) {
                
            }];
         
        }
            break;
        default:
            break;
    }
   
}


-(void)report:(NSInteger)reason;
{
    NSString * type = (self.type==WYMoreViewType_Dynamic)?@"1":@"2";
    NSString * reasonString = [NSString stringWithFormat:@"%ld",reason];
    
    NSDictionary * dict = @{@"id":@"",@"type":type,@"interface":@"User@report",@"reason":reasonString,@"remark":@""};
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
        
        [[UIApplication sharedApplication].keyWindow makeToast:@"举报成功"];
    };
    
    request.failureDataBlock = ^(id  _Nonnull error) {
        
    };
}

-(void)setIsFriend:(BOOL)isFriend
{
    _isFriend = isFriend;
    
    self.titleArray =@[@"举报",@"拉黑"];
    self.imageArray = @[@"more_report",@"more_black"];
    [self.collectionView reloadData];
}

-(void)setType:(WYMoreViewType)type
{
    switch (type) {
        case WYMoreViewType_Dynamic:
        {
            self.titleArray = @[@"举报"];
            self.imageArray = @[@"more_report"];
        }
            break;
            case WYMoreViewType_Conversation:
        {
            self.titleArray = @[@"举报",@"拉黑"];
            self.imageArray = @[@"more_report",@"more_black",@"more_delete"];
        }
            break;
        default:
            break;
    }
    [self.collectionView reloadData];
}

-(UICollectionView*)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 20;
        layout.minimumInteritemSpacing = 44;
        layout.itemSize = CGSizeMake(48,80);
        
        _collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0,0,KScreenWidth, 110) collectionViewLayout:layout];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor binaryColor:@"212121"];
        [_collectionView registerClass:[WYMoreCollectionViewCell class] forCellWithReuseIdentifier:@"WYMoreCollectionViewCell"];
  
    }
    return _collectionView;
}


-(UIView*)horView
{
    if (!_horView) {
        _horView = [[UIView alloc]init];
        _horView.backgroundColor = [[UIColor binaryColor:@"FFFFFF"] colorWithAlphaComponent:0.1];
    }
    return _horView;
}

-(UIButton*)cancleButton
{
    if (!_cancleButton) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleButton setBackgroundColor:[UIColor binaryColor:@"212121"]];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleButton setTitleColor:[UIColor binaryColor:@"FFFFFF"] forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
        @weakify(self);
        [[_cancleButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self hide];
            
        }];
    }
    return _cancleButton;
}


- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
    }
    return _shapeLayer;
}


@end
