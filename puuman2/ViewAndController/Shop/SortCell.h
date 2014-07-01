//
//  SortCell.h
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-23.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFImageView.h"

@interface SortCell : UIView
{
    UIButton *selectedBtn;
    UILabel *titleLabel;
    AFImageView *wareImgView;
}

@property(nonatomic,assign)NSInteger flagTag;
@end
