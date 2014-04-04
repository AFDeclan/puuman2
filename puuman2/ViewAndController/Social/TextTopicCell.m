//
//  TextTopicCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "TextTopicCell.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"

@implementation TextTopicCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
 
        
        
    }
    return self;
}
- (void)buildWithReply:(Reply *)replay
{
    if (mainTextView) {
        [mainTextView removeFromSuperview];
    }
    mainTextView = [[AdaptiveLabel alloc] initWithFrame:CGRectMake(56, 0, 0, 0)];
    [mainTextView setBackgroundColor:[UIColor clearColor]];
    [mainTextView setFont:PMFont2];
    [mainTextView setTextColor:PMColor1];
    [contentView addSubview:mainTextView];
    if ([replay.textUrls count]>0) {
        [mainTextView setTitle:[replay.textUrls objectAtIndex:0] withMaxWidth:536];
    }else{
        [mainTextView setTitle:@"" withMaxWidth:536];

    }
 
    CGRect frame = contentView.frame;
    frame.size.height = ViewHeight(mainTextView)+16;
    [contentView setFrame:frame];
    [super buildWithReply:replay];

}

+ (CGFloat)heightForReplay:(Reply *)replay andIsMyTopic:(BOOL)isMytopic andTopicType:(TopicType)type;
{
    
    AdaptiveLabel *example = [[AdaptiveLabel alloc] initWithFrame:CGRectMake(56, 0, 0, 0)];
    [example setFont:PMFont2];
    if ([replay.textUrls count]>0) {
        [example setTitle:[replay.textUrls objectAtIndex:0] withMaxWidth:536];
 
    }else{
       [example setTitle:@"" withMaxWidth:536];
    }
    return  ViewHeight(example)+16;
}

@end
