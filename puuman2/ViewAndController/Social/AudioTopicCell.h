//
//  AudioTopicCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-25.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "TopicCell.h"
#import "NewAudioPlayView.h"

@interface AudioTopicCell : TopicCell <NewAudioPlayDelegate>
{
    NewAudioPlayView *playBtn;
}
@end
