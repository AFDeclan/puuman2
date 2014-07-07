//
//  BabyInfoIconViewDelegate.h
//  puuman2
//
//  Created by AF_Bigwaves on 14-7-3.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BabyInfoIconViewDelegate <NSObject>

@optional

- (void)gotoNextCellWithProp:(BOOL)isProp;
- (void)gotoPreCell;
- (void)backToMianCell;

@end
