//
//  HappyView.h
//  puman
//
//  Created by 祁文龙 on 13-12-20.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HappyView : UIView
{
    
   UIImageView *bgImgView;
    
    UIImageView *cloudView;
    UIImageView *animalView;
    UIImageView *birdView;
    UIImageView *sea_one;
    UIImageView *sea_two;
    BOOL  oneIsPre;
    NSTimer *aniTimer;
    BOOL animate;
}
- (void)remove;
@end
