//
//  VideoDiaryCell.h
//  puman
//
//  Created by Declan on 13-12-28.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "DiaryCell.h"
#import "DiaryImageView.h"

@interface VideoDiaryCell : DiaryCell
{
    DiaryImageView *_imgView;
    UIButton *_playBtn;
    UIImageView *titleView;
    UILabel *titleLabel;
    NSString *filePath;
    UIButton *reloadBtn;

}

@end
