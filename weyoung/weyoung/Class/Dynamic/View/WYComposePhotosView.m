//
//  WYComposePhotosView.m
//  weyoung
//
//  Created by gongxin on 2019/1/2.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYComposePhotosView.h"
#import "WYComposeCollectionViewCell.h"
@interface WYComposePhotosView()< UICollectionViewDataSource , UICollectionViewDelegate >


@property (nonatomic , retain) UICollectionView *collectionView;
@property (nonatomic , strong) NSMutableArray *assetsArray;
@property (nonatomic , strong) NSArray *selectedPhotos;

@end

@implementation WYComposePhotosView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self){
        
        [self addSubview:self.collectionView];
    }
    
    return self;
}
-(void)setData:(NSMutableArray*)array
{
    self.assetsArray = array;
    [self.collectionView reloadData];
    
    if (self.block) {
        self.block([self.assetsArray count]);
    }

}
-(BOOL)hasImage
{
    return ([self.assetsArray count]==0)?NO:YES;
}

-(void)runInMainQueue:(void (^)())queue{
    dispatch_async(dispatch_get_main_queue(), queue);
}

-(void)runInGlobalQueue:(void (^)())queue{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), queue);
}

static NSString *kPhotoCellIdentifier = @"kPhotoCellIdentifier";


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.assetsArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WYComposeCollectionViewCell *cell = (WYComposeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kPhotoCellIdentifier forIndexPath:indexPath];
    
    cell.asset = [self.assetsArray objectAtIndex:[indexPath row]];
    
    cell.deletePhotoButton.tag = indexPath.row;
    cell.indexpath = indexPath;
    [cell.deletePhotoButton addTarget:self action:@selector(deleteView:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // UIEdgeInsets insets = {top, left, bottom, right};
    return UIEdgeInsetsMake(10, 15, 10, 15);
}


- (void)deleteView:(id)sender{
    
    NSInteger deletedPhoto = ((UIButton *)sender).tag;
    for (WYComposeCollectionViewCell *currentCell in [self.collectionView subviews]){
        
        if (deletedPhoto == currentCell.indexpath.row){
            
            if (self.assetsArray.count > 0){
                [self.assetsArray removeObjectAtIndex:deletedPhoto];
                [UIView animateWithDuration:1 animations:^{
                    
                    currentCell.frame = CGRectMake(currentCell.frame.origin.x, currentCell.frame.origin.y + 100, 0, 0);
                    [currentCell removeFromSuperview];
                }completion:^(BOOL finished) {
                    
                }];
                
                if (self.block) {
                    self.block([self.assetsArray count]);
                }
                
            }
            
        }
        
        if (deletedPhoto < currentCell.indexpath.row){
            currentCell.deletePhotoButton.tag -= 1;
        }
        
    }
    [self.collectionView reloadData];
    
    
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(110, 110);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)[indexPath row]);
    
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 5.0;
        layout.minimumInteritemSpacing = 5.0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[WYComposeCollectionViewCell class] forCellWithReuseIdentifier:kPhotoCellIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
      
    }
    return _collectionView;
}


@end
