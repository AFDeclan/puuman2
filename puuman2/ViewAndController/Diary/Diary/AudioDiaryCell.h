//
//  AudioDiaryCell.h
//  puman
//
//  Created by Declan on 13-12-28.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "DiaryCell.h"
#import "NewAudioPlayView.h"


@interface AudioDiaryCell : DiaryCell <NewAudioPlayDelegate>
{
    NewAudioPlayView *playBtn;
    UILabel *titleLabel;
 
}

+ (CGFloat)heightForDiary:(Diary*)diary abbreviated:(BOOL)abbr;

@end
