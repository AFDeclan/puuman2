//
//  PregnancyTableViewCell.h
//  puuman2
//
//  Created by AF_Bigwaves on 14-7-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFImageView.h"
#define BABY_COLUMN_CNT 40
#define kPicWidth 480
#define kPicHeight 540

@interface PregnancyTableViewCell : UITableViewCell
{
    AFImageView *imageView;
}

@property (nonatomic,assign)BOOL columnImgBMode;
@property (nonatomic,assign)NSInteger indexNum;
@end
