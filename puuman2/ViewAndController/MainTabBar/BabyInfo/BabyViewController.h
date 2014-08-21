//
//  BabyViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-19.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PopUpViewController.h"
#import "BabyView.h"

@protocol BabyViewControllerDelegate;
@interface BabyViewController : PopUpViewController
@property(nonatomic,assign)id<BabyViewControllerDelegate>delegate;
@property(nonatomic,retain) BabyView *babyView;
- (void)show;
- (void)hidden;
@end
@protocol BabyViewControllerDelegate <NSObject>
@optional
- (void)babyViewfinished;
@end