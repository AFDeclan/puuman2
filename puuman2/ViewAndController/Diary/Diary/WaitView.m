//
//  WaitView.m
//  puman
//
//  Created by 祁文龙 on 13-11-14.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "WaitView.h"
#import "ColorsAndFonts.h"
#import "UserInfo.h"

@implementation WaitView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
         [self initialization];
    }
    return self;
}
- (void)initialization
{
     titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 208, 16)];
    [titleLabel setFont:PMFont2];
    [titleLabel setTextColor:PMColor6];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    NSString *nickName =  [[UserInfo sharedUserInfo].meta  valueForKey:@"uMeta_nickName"];
    NSString *nameStr;
    if (nickName) {
        if ([[UserInfo sharedUserInfo] identity] == Mother) {
            nameStr = [NSString stringWithFormat:@"%@爸",nickName];
            
        }else
        {
            nameStr = [NSString stringWithFormat:@"%@妈",nickName];
        }
        
    }else{
        if ([[UserInfo sharedUserInfo] identity] == Mother) {
             nameStr = @"爸爸";
           
        }else
        {
            nameStr = @"妈妈";
        }
        
    }
    [titleLabel setText:[NSString stringWithFormat:@"已经邀请了%@",nameStr]];
    [self addSubview:titleLabel];
    detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 16, 208, 40)];
    [detailLabel setNumberOfLines:2];
    [detailLabel setTextColor:PMColor3];
    [detailLabel setBackgroundColor:[UIColor clearColor]];
    [detailLabel setTextAlignment:NSTextAlignmentLeft];
    [detailLabel setText:[NSString stringWithFormat: @"正在等待%@处理邀请，24小时后可以再次发送邀请。",nameStr]];
    [detailLabel setFont:PMFont3];
    [self addSubview:detailLabel];
    
    waitImg = [[UIImageView alloc] initWithFrame:CGRectMake(56, 64, 120, 144)];
    [waitImg setImage:[UIImage imageNamed:@"pic_invite_diary.png"]];
    [self addSubview:waitImg];
    

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
