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

@interface PieView ()
{
    CGPoint panNormalizedVector;
    float panStartCenterOffsetElem;
    float panStartDotProduct;
}
@end


@implementation PieView
@synthesize pieLayerDelegate = _pieLayerDelegate;
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
    if ([self.layer.self respondsToSelector:@selector(setContentsScale:)])
    {
        self.layer.contentsScale = [[UIScreen mainScreen] scale];
    }
    
}



- (void)finishedAnimate
{
    
    PieElement* elem =  [self.layer.values objectAtIndex:1];
    elem.centrOffset = 0;
    [UIView animateWithDuration:1 animations:^{
        [elem setCentrOffset:4];
        [_pieLayerDelegate finishedAnimate];
    }];
}

@end
