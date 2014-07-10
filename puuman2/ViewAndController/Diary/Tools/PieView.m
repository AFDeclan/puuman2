//
//  PieView.m
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-20.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "PieView.h"
#import "PieElement.h"
#import "PieLayer.h"
#import "UserInfo.h"
@interface PieView ()
{
    CGPoint panNormalizedVector;
    float panStartCenterOffsetElem;
    float panStartDotProduct;
}
@end


@implementation PieView
@synthesize pieLayerDelegate = _pieLayerDelegate;
@synthesize finishLoad =_finishLoad;
+ (Class)layerClass
{
    return [PieLayer class];
}

- (id)init
{
    self = [super init];
    if(self){
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.layer.maxRadius = 80;
    self.layer.minRadius = 0;
    self.layer.animationDuration = 0.6;
    self.layer.showTitles = ShowTitlesNever;
    self.layer.pieLayerDelegate = self;
    self.layer.finishLoad = NO;
    if ([self.layer.self respondsToSelector:@selector(setContentsScale:)])
    {
        self.layer.contentsScale = [[UIScreen mainScreen] scale];
    }
    
}



- (void)finishedAnimate
{
    if (([[UserInfo sharedUserInfo] UCorns_connect] != 0) && ([[UserInfo sharedUserInfo] UCorns] != 0))
    {
        PieElement* elem =  [self.layer.values objectAtIndex:1];
        elem.centrOffset = 0;
        [UIView animateWithDuration:1 animations:^{
            [elem setCentrOffset:4];
           
        }];
    }
     [_pieLayerDelegate finishedAnimate];
}

- (void)setFinishLoad:(BOOL)finishLoad
{
    _finishLoad = finishLoad;
    [self.layer setFinishLoad:finishLoad];
    if (!finishLoad) {
        [self reloadLayer];
    }
}

- (void)reloadLayer
{
    PieElement* elem =  [self.layer.values objectAtIndex:1];
    elem.centrOffset = 0;
    [UIView animateWithDuration:1 animations:^{
        [elem setCentrOffset:0];
    }];
}
@end
