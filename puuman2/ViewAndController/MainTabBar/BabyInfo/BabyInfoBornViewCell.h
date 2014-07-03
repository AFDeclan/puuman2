//
//  BabyInfoBornViewCell.h
//  puuman2
//
//  Created by AF_Bigwaves on 14-7-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorButton.h"
#import "AFImageView.h"
#import "UserInfo.h"
#import "BabyInfoIconViewDelegate.h"

@interface BabyInfoBornViewCell : UITableViewCell<BabyInfoDelegate,BabyInfoIconViewDelegate>

{
    UIView *clearInfoView;
    
}

@property (nonatomic,assign) id <BabyInfoIconViewDelegate>delegate;

- (void)refreshBabyInfo;

@end
