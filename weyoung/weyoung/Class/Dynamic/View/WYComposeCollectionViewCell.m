//
//  WYComposeCollectionViewCell.m
//  weyoung
//
//  Created by gongxin on 2019/1/2.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYComposeCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation WYComposeCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self){
        
       [self.contentView addSubview:self.imageView];
       [self.contentView addSubview:self.deletePhotoButton];
    }
    
    return self;
}

-(void)layoutSubviews
{
    
    self.deletePhotoButton.frame =CGRectMake(self.contentView.width-40, 0, 40, 40);
}


- (void)setAsset:(WYAssets *)asset {
    
    if (_asset != asset){
        _asset = asset;
        self.imageView.image  = asset.photo;
    }
    
}


- (UIImageView *)imageView{
    
    if(!_imageView){
        
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _imageView.layer.cornerRadius = 10.0f;
        _imageView.layer.borderColor = [UIColor clearColor].CGColor;
        _imageView.layer.borderWidth = 0.5;
        _imageView.layer.masksToBounds=YES;
      

    }
    return _imageView;
}

-(UIButton*)deletePhotoButton
{
    if (!_deletePhotoButton) {
        _deletePhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deletePhotoButton setImage:[UIImage imageNamed:@"dynamic_pic_close"] forState:UIControlStateNormal];
    }
    return _deletePhotoButton;
}

@end
