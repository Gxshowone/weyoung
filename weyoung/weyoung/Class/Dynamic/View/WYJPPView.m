//
//  WYJPPView.m
//  weyoung
//
//  Created by gongxin on 2019/1/2.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYJPPView.h"
#import "YYAnimatedImageView.h"
#import "HZPhotoBrowser.h"
@implementation WYJPPView

-(void)tapImageAction:(UITapGestureRecognizer *)tap{
    UIImageView *tapView = (UIImageView *)tap.view;
    
    HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
    browser.isFullWidthForLandScape = YES;
    browser.isNeedLandscape = YES;
    browser.currentImageIndex = (int)tapView.tag;
    browser.imageArray = self.dataSource;
    [browser show];
    
}

-(void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    //单张图片的大小
    CGFloat jgg_width = KScreenWidth-67-20;
    
    CGFloat imageWidth =  jgg_width;
    CGFloat imageHeight =  imageWidth;
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,imageWidth, imageHeight)];
 
    NSString * urlString = [NSString stringWithFormat:@"%@",dataSource[0]];
    NSURL * url  = [NSURL URLWithString:urlString];
    [iv yy_setImageWithURL:url options:0];
    
    iv.userInteractionEnabled = YES;//默认关闭NO，打开就可以接受点击事件
    iv.tag = 0;
    iv.layer.cornerRadius = 10;
    iv.layer.masksToBounds = YES;
    iv.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:iv];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageAction:)];
    [iv addGestureRecognizer:singleTap];
}

@end
