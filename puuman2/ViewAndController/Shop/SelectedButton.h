//
//  SelectedButton.h
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-5-6.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    kSelectedLeft,
    kSelectedRight
}SelectedButtonType;

@protocol SelectedButtonDelegate;
@interface SelectedButton : UIButton
{
    UIView *bgSelectedView;
    UIView *maskView;
}
@property(nonatomic,assign)     id<SelectedButtonDelegate> delegate;
@property(nonatomic,assign)     SelectedButtonType type;
@property(nonatomic,retain)     UILabel *titleLabel;
@property(nonatomic,retain)     UIImageView *icon;
- (void)adjustSize;

@end

@protocol SelectedButtonDelegate <NSObject>

- (void)selectedButtonSelectedWithButton:(SelectedButton *)button;

@end