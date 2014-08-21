//
//  AudioTopicCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AudioTopicCell.h"

@implementation AudioTopicCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        playBtn = [[NewAudioPlayView alloc] initWithFrame:CGRectMake(272, 20, 96, 96)];
        [playBtn setDelegate:self];
        [contentView addSubview:playBtn];
    }
    return self;
}

- (void)buildWithReply:(Reply *)reply
{

    NSString *filePath;// = [self.diaryInfo valueForKey:kFilePathName];
    
    [playBtn setPlayFile:[NSURL fileURLWithPath:filePath]];
    CGRect frame = contentView.frame;
    frame.size.height = 156;
    [contentView setFrame:frame];
    [super buildWithReply:reply];

}

+ (CGFloat)heightForReplay:(Reply *)reply andIsMyTopic:(BOOL)isMytopic
{
    BOOL hasTitle = YES;
    if (hasTitle) {
        return  312;
    }else{
        return  284;
    }
}

- (void)stopAudio
{
    [playBtn stopPlay];
}

- (void)stopPlay
{
    
}
- (void)startPlay
{
    
}

@end
