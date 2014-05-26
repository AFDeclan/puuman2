//
//  ControlScrollView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-26.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ControlScrollView.h"
#import "UniverseConstant.h"

@implementation ControlScrollView
@synthesize selectedIndex = _selectedIndex;
@synthesize controlDelegate = _controlDelegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
      
    }
    return self;
}



- (void)tap:(UITapGestureRecognizer *)tap
{
    CGPoint touch =[tap locationInView:self];
    if (CGRectContainsPoint(preFrame, touch)) {
        [_controlDelegate goPre];
    }else if(CGRectContainsPoint(nextFrame, touch)){
        [_controlDelegate goNext];
    }
    
    
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    preFrame = CGRectMake((selectedIndex-1)*self.frame.size.width +24+8, 120, 256, 296);
    nextFrame = CGRectMake(preFrame.origin.x + 2*272+8, 120, 256, 296);

}

@end
