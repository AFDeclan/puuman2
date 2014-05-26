//
//  ControlScrollView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-26.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ControlScrollDelegate;
@interface ControlScrollView : UIScrollView<UIScrollViewDelegate>
{
    CGRect preFrame;
    CGRect nextFrame;
}
@property(nonatomic,assign)id<ControlScrollDelegate> controlDelegate;
@property(nonatomic,assign)NSInteger selectedIndex;
@end

@protocol ControlScrollDelegate <NSObject>
@optional
- (void)goPre;
- (void)goNext;
@end