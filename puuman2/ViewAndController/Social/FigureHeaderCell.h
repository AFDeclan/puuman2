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

@interface FigureHeaderCell : UITableViewCell
{
    AFImageView *portrait;
    UILabel *info_compare;
    AFTextImgButton *name_sex;
    UIImageView *recommendView;
    UILabel *label_manageStatus;
}
@property(nonatomic,assign)BOOL recommend;
- (void)buildWithMemberInfo:(Member *)member;
@end
