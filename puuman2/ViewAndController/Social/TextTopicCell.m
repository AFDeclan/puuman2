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
- (void)buildWithReply:(Reply *)reply
{
    if (mainTextView) {
        [mainTextView removeFromSuperview];
    }
    mainTextView = [[AdaptiveLabel alloc] initWithFrame:CGRectMake(56, 0, 0, 0)];
    [mainTextView setBackgroundColor:[UIColor clearColor]];
    [mainTextView setFont:PMFont2];
    [mainTextView setTextColor:PMColor1];
    [contentView addSubview:mainTextView];
    NSString *filePath = [reply.textUrls objectAtIndex:0];
    NSString *text;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
        text = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    else text = @"";
    if (text == nil) text = @"";
    [mainTextView setTitle:text withMaxWidth:536];
    CGRect frame = contentView.frame;
    frame.size.height = ViewHeight(mainTextView)+16;
    [contentView setFrame:frame];
    [super buildWithReply:reply];

}
+ (CGFloat)heightForReply:(Reply *)reply andIsMyTopic:(BOOL)isMytopic andTopicType:(TopicType)type
{
    
    NSString *filePath = [reply.textUrls objectAtIndex:0];
    NSString *text;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
        text = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    else text = @"";
    if (text == nil) text = @"";
    
    AdaptiveLabel *example = [[AdaptiveLabel alloc] initWithFrame:CGRectMake(56, 0, 0, 0)];
    [example setFont:PMFont2];
    [example setTitle:text withMaxWidth:536];

    return  ViewHeight(example)+16;
}

@end
