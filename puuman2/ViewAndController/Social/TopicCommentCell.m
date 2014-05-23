//
//  TopicCommentCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-23.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "TopicCommentCell.h"

@implementation TopicCommentCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initContent];

    }
    return self;
}

- (id)init
{
    return [self initWithFrame:CGRectMake(0, 0, 608, 0)];

}

- (void)initContent
{
    
    infoView = [[BasicInfoView alloc] init];
    [self addSubview:infoView];
    
}



- (void)buildWithComment:(Comment *)comment
{
    
    if (mainTextView) {
        [mainTextView removeFromSuperview];
    }
    mainTextView = [[AdaptiveLabel alloc] initWithFrame:CGRectMake(218, 16, 0, 0)];
    [mainTextView setBackgroundColor:[UIColor clearColor]];
    [mainTextView setFont:PMFont2];
    [mainTextView setTextColor:PMColor1];
    [self addSubview:mainTextView];
    [mainTextView setTitle:[comment CContent] withMaxWidth:340];
    [mainTextView setText:[comment CContent]];
    [infoView setInfoWithUid:[comment UID] andIsTopic:NO];
    SetViewLeftUp(infoView, 48, 0);
    CGRect frame = self.frame;
    frame.size.height = ViewHeight(mainTextView)+32 >60?ViewHeight(mainTextView)+32:60;
    self.frame = frame;
    
}

@end
