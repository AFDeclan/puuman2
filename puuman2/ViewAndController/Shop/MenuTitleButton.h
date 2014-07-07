//
//  MenuTitleButton.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTitleButton : UIButton
{
    UIImageView *iconView;
    UILabel *titleLabel;
}
- (void)showSubView;
- (void)hiddenSubView;
@property(nonatomic,assign) NSInteger flagNum;
@end
