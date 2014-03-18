//
//  AuPhotoDiaryCell.h
//  puman
//
//  Created by Declan on 13-12-28.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "DiaryCell.h"
#import "NewAudioPlayView.h"

@interface AuPhotoDiaryCell : DiaryCell <NewAudioPlayDelegate>
{
    UIImageView *_photoView;
    NewAudioPlayView *playBtn;
    UIImage *photo;
    UIImageView *titleView;
    UILabel *titleLabel;
}

@end
