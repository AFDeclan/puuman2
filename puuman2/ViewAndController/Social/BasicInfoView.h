//
//  BasicInfoView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-24.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFImageView.h"
#import "UILabel+AdjustSize.h"
#import "AFTextImgButton.h"

@interface BasicInfoView : UIView
{
    AFImageView *portrait;
    UILabel *info_name;
    UILabel *info_relate;
    UIImageView *icon_sex;
}
- (void)setInfoWithName:(NSString *)name andPortrailPath:(NSString*)path andRelate:(NSString *)relate andIsBoy:(BOOL)isBoy;
@end
