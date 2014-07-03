//
//  BabyInfoPregnancyViewCell.h
//  puuman2
//
//  Created by AF_Bigwaves on 14-7-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorButton.h"
#import "AFImageView.h"
#import "UIColumnView.h"
#import "BabyInfoIconViewDelegate.h"
@interface BabyInfoPregnancyViewCell : UITableViewCell<BabyInfoIconViewDelegate>
{
    UIView *clearInfoView;
    ColorButton *modifyBtn;
    AFImageView *portraitView;
    UIImageView *info_sexIcon;
    UILabel *info_name;
    UILabel *info_age;
    UILabel *weekLabel;
  
}

@property (nonatomic,assign)id<BabyInfoIconViewDelegate>delegate;

@end
