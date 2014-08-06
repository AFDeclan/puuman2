//
//  SinglePhotoTopicVIew.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-23.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SinglePhotoTopicVIew.h"
#import "DetailShowViewController.h"

@implementation SinglePhotoTopicVIew

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)buildWithReply:(Reply *)reply
{
    if (imgView) {
        [imgView removeFromSuperview];
    }
    imgView = [[AsyncImgView alloc] initWithFrame:CGRectMake(96, 12, 416, 416)];
    if ([[reply photoUrls] count] > 0) {
        [imgView loadImgWithUrl:[[reply photoUrls] objectAtIndex:0]];
    }
    [imgView setContentMode:UIViewContentModeScaleAspectFit];

    [contentView addSubview:imgView];

    CGRect frame = contentView.frame;
    frame.size.height =416 +24;
    [contentView setFrame:frame];
    [super buildWithReply:reply];
    
    selectedBtn = [[UIButton alloc] initWithFrame:CGRectMake(96, 12, 416, 416)];
    [selectedBtn setBackgroundColor:[UIColor clearColor]];
    [selectedBtn addTarget:self action:@selector(showPhoto) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:selectedBtn];

    
}

- (void)showPhoto
{
    [DetailShowViewController showPhotosPath:[_reply photoUrls] atIndex:0 andTitle:_reply.RTitle];

}

+ (CGFloat)heightForReply:(Reply *)reply andIsMyTopic:(BOOL)isMytopic andTopicType:(TopicType)type;
{
    return 416 +24;
}


@end
