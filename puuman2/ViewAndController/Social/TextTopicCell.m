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
        mainTextView = [[AdaptiveLabel alloc] initWithFrame:CGRectMake(56, 0, 0, 0)];
        [mainTextView setBackgroundColor:[UIColor clearColor]];
        [mainTextView setFont:PMFont2];
        [mainTextView setTextColor:PMColor1];
        [mainTextView addSubview:mainTextView];
        [contentView addSubview:mainTextView];
        
        
    }
    return self;
}
- (void)buildWithReply:(Reply *)replay
{
 
    [mainTextView setTitle:@"补脑片而不能去哦过Neo钱不够日本去玩过 弄吧Nero去吧弄夫妻百日哦该不热波陪你去荣光朴讷荣热哦高非农恶搞不热按哦不能够本二本那个人送饿哦日工农二哥你送哦仍ioerg" withMaxWidth:536];
    
    CGRect frame = contentView.frame;
    frame.size.height = ViewHeight(mainTextView)+16;
    [contentView setFrame:frame];
    [super buildWithReply:replay];

}

+ (CGFloat)heightForReplay:(Reply *)replay
{
    
    AdaptiveLabel *example = [[AdaptiveLabel alloc] initWithFrame:CGRectMake(56, 0, 0, 0)];
    [example setFont:PMFont2];
    [example setTitle:@"补脑片而不能去哦过Neo钱不够日本去玩过 弄吧Nero去吧弄夫妻百日哦该不热波陪你去荣光朴讷荣热哦高非农恶搞不热按哦不能够本二本那个人送饿哦日工农二哥你送哦仍ioerg" withMaxWidth:536];
    
    return  ViewHeight(example)+16;
}

@end
