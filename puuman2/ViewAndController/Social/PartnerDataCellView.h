//
//  PartnerDataCellView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-26.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColumnView.h"
#import "Group.h"
#import "Member.h"


@interface PartnerDataCellView : UIView<UIColumnViewDataSource, UIColumnViewDelegate>
{
    UIColumnView *dataColumnView;
    Group *_group;
    UIImageView *icon;
    UILabel *titleLabel;
    UIView *bgView;
}
- (void)setbgViewColor:(UIColor *)color;
- (void)reloadWithGroupInfo:(Group *)group;
- (void)setVerticalFrame;
- (void)setHorizontalFrame;
@end
