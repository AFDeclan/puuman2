//
//  BasicInfoView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFImageView.h"
#import "UILabel+AdjustSize.h"
#import "AFTextImgButton.h"
#import "RecommendPartnerViewController.h"
#import "Friend.h"

@interface BasicInfoView : UIView<PopViewDelegate,FriendDelegate>
{
    AFImageView *portrait;
    UILabel *info_name;
    UILabel *info_relate;
    UIImageView *icon_sex;
    NSInteger _uid;
    UIButton *info_btn;
    BOOL hasInfoView;
    BOOL tapped;
    BOOL _isTopic;
}
- (void)setInfoWithUid:(NSInteger)uid andIsTopic:(BOOL)isTopic;
@end
