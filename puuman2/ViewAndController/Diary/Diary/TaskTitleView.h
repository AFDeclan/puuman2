//
//  TaskTitleView.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-8.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFImageView.h"

@interface TaskTitleView : UIView
{
    UILabel *title;
    AFImageView *portraitView;
    UIImageView *pointView;
    NSTimer *_timer;
    UIButton *controlBtn;
}
@property(nonatomic,strong)NSDictionary *taskInfo;
@property(nonatomic,assign)BOOL folded;
@property(nonatomic,assign)NSInteger taskIndex;
- (void)setTitle:(NSString *)title_;
- (void)unfold;
- (void)foldWithAnmate:(BOOL)animate;
- (void)loadTask;
- (void)changeTask:(NSInteger)step;
- (void)reloadPortrait;

@end
