//
//  ChatTableCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-20.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ChatTableCell.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"
#import "MainTabBarController.h"
#import "UserInfo.h"
#import "NSDate+Compute.h"
#import "DateFormatter.h"


@implementation ChatTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        portrait = [[AFImageView alloc] initWithFrame:CGRectMake(32, 16, 40, 40)];
        [portrait setBackgroundColor:[UIColor clearColor]];
        portrait.layer.cornerRadius = 20;
        portrait.layer.masksToBounds = YES;
        portrait.layer.shadowRadius =0.1;
        [self addSubview:portrait];
        [self.contentView addSubview:portrait];
        tri = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 6, 8)];
        [self.contentView addSubview:tri];
        
        bgView = [[UIView alloc] init];
        
        [self addSubview:bgView];
        
        detail = [[AdaptiveLabel alloc] initWithFrame:CGRectMake(12, 12, 0, 0)];
        [detail setBackgroundColor:[UIColor clearColor]];
        [detail setFont:PMFont2];
        [bgView addSubview:detail];
        
        time_label = [[UILabel alloc] init];
        [time_label setBackgroundColor:[UIColor clearColor]];
        [time_label setTextAlignment:NSTextAlignmentCenter];
        [time_label setTextColor:PMColor3];
        [time_label setFont:PMFont4];
        [self addSubview:time_label];
    }
    return self;
}

-(void)buildWidthDetailChat:(Action *)chatInfo andPreChat:(Action *)preChat

{
    if (preChat) {
        
    }else{
    
    }
    member= [[[Friend sharedInstance] myGroup] memberWithBid:chatInfo.ATargetBID];
    [portrait getImage:[member BabyPortraitUrl] defaultImage:@"pic_default_topic.png"];
   
    
    
  NSInteger minite = [chatInfo.ACreateTime miniteFromDate:preChat.ACreateTime];
    
    float disHeight = 0;
   // if (minite >= 0) {
        disHeight = 32;
        [time_label setText:[DateFormatter stringFromDate:chatInfo.ACreateTime] ];
        [time_label setAlpha:1];
//    }else{
//        [time_label setAlpha:0];
//        disHeight = 16;
//    }
    
    
    
    
    
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [detail setTitle:chatInfo.AMeta withMaxWidth:488];
        [time_label setFrame:CGRectMake(0, 0, 608, disHeight)];
        if (member.BID == [UserInfo sharedUserInfo].BID) {
            [tri setImage:[UIImage imageNamed:@"tri_blue_fri.png"]];
            SetViewLeftUp(portrait, 536, disHeight);
            SetViewLeftUp(tri, 520, disHeight+16);
            [bgView setBackgroundColor:PMColor6];
            [bgView setFrame:CGRectMake(608-88-ViewWidth(detail)-24, disHeight, ViewWidth(detail)+24, ViewHeight(detail)+24)];
            [detail setTextColor:[UIColor whiteColor]];
        }else{
            [tri setImage:[UIImage imageNamed:@"tri_gray_fri.png"]];
            SetViewLeftUp(portrait, 32, disHeight);
            SetViewLeftUp(tri, 82, disHeight+16);
            [bgView setBackgroundColor:PMColor5];
            [bgView setFrame:CGRectMake(88, disHeight, ViewWidth(detail)+24, ViewHeight(detail)+24)];
            [detail setTextColor:PMColor2];
        }
        
    }else{
        [time_label setFrame:CGRectMake(0, 0, 864, disHeight)];
        [detail setTitle:chatInfo.AMeta withMaxWidth:488];

        if (member.BID == [UserInfo sharedUserInfo].BID) {
            [tri setImage:[UIImage imageNamed:@"tri_blue_fri.png"]];
            SetViewLeftUp(portrait, 792, disHeight);
            SetViewLeftUp(tri, 776, disHeight+16);
            [bgView setBackgroundColor:PMColor6];
            [bgView setFrame:CGRectMake(864-88-ViewWidth(detail)-24, disHeight, ViewWidth(detail)+24, ViewHeight(detail)+24)];
            [detail setTextColor:[UIColor whiteColor]];
        }else{
            [tri setImage:[UIImage imageNamed:@"tri_gray_fri.png"]];
            SetViewLeftUp(portrait, 32, disHeight);
            SetViewLeftUp(tri, 82, disHeight +16);
            [bgView setBackgroundColor:PMColor5];
            [bgView setFrame:CGRectMake(88, disHeight, ViewWidth(detail)+24, ViewHeight(detail)+24)];
            [detail setTextColor:PMColor2];
        }
    }
    
  
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



+ (CGFloat)heightForChat:(NSString *)chat
{

    BOOL hasTime = YES;
    float disHeight = 0;
    if (hasTime) {
        disHeight = 32;
    }else{
        disHeight = 16;
    }
    AdaptiveLabel *label = [[AdaptiveLabel alloc] initWithFrame:CGRectMake(50, 50, 0, 0)];
    [label setBackgroundColor:[UIColor redColor]];
    [label setTextColor:PMColor2];
    [label setFont:PMFont2];
    [label setTitle:chat withMaxWidth:488];
    float dh =ViewHeight(label);
    dh +=24+disHeight;
    dh = dh>60?dh:60;
    
    return dh;

}

@end
