//
//  ToolsSelectedButton.h
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-7.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimateShowLabel.h"
@interface ToolsSelectedButton : UIButton
{
    UIImageView *iconFlag;
    UIImageView *triFlag;
    UIImageView *triFlag2;

    UILabel *titleLabel;
}
@property(nonatomic,assign)NSInteger flagNum;
@end
