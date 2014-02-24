//
//  DiaryShareView.m
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-1-25.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "DiaryShareView.h"
#import "ColorsAndFonts.h"
#import "SocialNetwork.h"


@implementation DiaryShareView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [titleLabel setText:@"分享到？"];
        
        [self initialization];
    }
    return self;
}
- (void)initialization
{
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 32, 320, 168)];
    [_contentView addSubview:contentView];
    [self initContentView];
    [super initWithContentSize:CGSizeMake(320, 168) andhasControlBtnType:HasClose];
}
-(void)initContentView
{
    weixin = [[UIButton alloc] initWithFrame:CGRectMake(80, 48, 40, 40)];
    [weixin setImage:[UIImage imageNamed:@"btn_wechat_diary.png"] forState:UIControlStateNormal];
    [weixin addTarget:self action:@selector(shareToWeixin) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:weixin];
    
    weibo= [[UIButton alloc] initWithFrame:CGRectMake(200, 48, 40, 40)];
    [weibo setImage:[UIImage imageNamed:@"btn_weibo_diary.png"] forState:UIControlStateNormal];
    [weibo addTarget:self action:@selector(shareToWeiBo) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:weibo];
    
    
    weixinLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 96, 40, 19)];
    [weixinLabel setFont:DefaultFont_Small2];
    [weixinLabel setTextColor:Color_bl2];
    [weixinLabel setText:@"微信"];
    [weixinLabel setTextAlignment:NSTextAlignmentCenter];
    [weixinLabel setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:weixinLabel];
    
    weiBoLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 96, 40, 19)];
    [weiBoLabel setFont:DefaultFont_Small2];
    [weiBoLabel setTextColor:Color_bl2];
    [weiBoLabel setText:@"微博"];
    [weiBoLabel setTextAlignment:NSTextAlignmentCenter];
    [weiBoLabel setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:weiBoLabel];

   
}

- (void)shareToWeixin
{
    [[SocialNetwork sharedInstance] shareText:shareText title:shareTitle image:shareImg toSocial:Weixin];
}
- (void)shareToWeiBo
{
    [[SocialNetwork sharedInstance] shareText:shareText title:shareTitle image:shareImg toSocial:Weibo];
}

- (void)setInfoWithText:(NSString *)text_ title:(NSString *)title_ image:(UIImage*)img_
{
    shareTitle = title_;
    shareText = text_;
    shareImg = img_;
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
