//
//  BabyInfoPropEstiCell.h
//  puuman2
//
//  Created by AF_Bigwaves on 14-7-4.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdaptiveLabel.h"

@interface BabyInfoPropEstiCell : UITableViewCell

{
    UIView *lineView;
    AdaptiveLabel *_estiLabel;

}

@property (nonatomic,retain) AdaptiveLabel *estiLabel;

@end
