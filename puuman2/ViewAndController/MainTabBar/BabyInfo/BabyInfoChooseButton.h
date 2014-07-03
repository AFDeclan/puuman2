//
//  BabyInfoChooseButton.h
//  puuman2
//
//  Created by AF_Bigwaves on 14-6-30.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    kBabyInfoHeight,
    kBabyInfoWeight,
    kBabyInfoVaci,
    kBabyInfoProp,
    kBabyInfoModle,
    kBabyInfoBModle
    
} BabyInfoType;

@interface BabyInfoChooseButton : UIButton

{
    UIImageView *iconView;
    UILabel *stateLabel;
    UILabel *detailLabel;
    UILabel *instLabel;


}

@property (nonatomic,assign) BabyInfoType type;

@end
