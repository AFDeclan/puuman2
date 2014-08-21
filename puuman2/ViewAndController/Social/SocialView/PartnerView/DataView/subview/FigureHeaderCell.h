//
//  FigureHeaderCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFImageView.h"
#import "AFTextImgButton.h"
#import "Member.h"

@protocol FigureHeaderDelegate;
@interface FigureHeaderCell : UITableViewCell
{
    AFImageView *portrait;
    UILabel *info_compare;
    AFTextImgButton *name_sex;
    UIImageView *recommendView;
    UIButton *manageBtn;
    UIView *manageView;
}
@property(nonatomic,assign)id<FigureHeaderDelegate> delegate;
@property(nonatomic,assign)BOOL recommend;
@property(nonatomic,retain)Member *member;
@end

@protocol FigureHeaderDelegate <NSObject>

- (void)quit;
- (void)showPartnerWithInfo:(Member *)member;
@end