//
//  AFTextImgButton.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AFButton.h"

@interface AFTextImgButton : AFButton
{
    UIImageView *iconView;

}

@property(nonatomic,assign)CGSize iconSize;
@property(nonatomic,retain)UIImage *iconImg;
@property(nonatomic,retain)UILabel *title;

- (void)setIconLocation:(CGPoint)pos;
- (void)adjustLayout;
- (void)adjustLeftLayout;

@end
