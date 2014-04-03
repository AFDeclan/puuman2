//
//  ChatTableCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-20.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextLayoutLabel.h"
#import "AFImageView.h"
#import "AdaptiveLabel.h"
#import "Action.h"
#import "Friend.h"
#import "Group.h"
#import "Member.h"
#define kWidthForH 864
#define kWidthForV 608

@interface ChatTableCell : UITableViewCell
{
    AFImageView *portrait;
    UIImageView *tri;
    UIView *bgView;
    AdaptiveLabel *detail;
    UILabel *time_label;
    Member *member;
}

-(void)buildWidthDetailChat:(Action *)chatInfo andPreChat:(Action *)preChat;
+ (CGFloat)heightForChat:(NSString *)chat;
@end
