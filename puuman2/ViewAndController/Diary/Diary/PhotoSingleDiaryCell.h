//
//  PhotoSingleDiaryCell.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-11.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "DiaryCell.h"
#import "DiaryImageView.h"

@interface PhotoSingleDiaryCell : DiaryCell
{
    DiaryImageView *_imgView;
    UIButton *showBtn;
    NSString *_photoPath;
    UIImageView *titleView;
    UILabel *titleLabel;
}

@end
