//
//  AuPhotoDiaryCell.h
//  puman
//
//  Created by Declan on 13-12-28.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "DiaryCell.h"
#import "NewAudioPlayView.h"

@class DiaryImageView;
@interface AuPhotoDiaryCell : DiaryCell <NewAudioPlayDelegate>
{
    DiaryImageView *_photoView;
    NewAudioPlayView *playBtn;
    UIImageView *titleView;
    UILabel *titleLabel;
}

@end
