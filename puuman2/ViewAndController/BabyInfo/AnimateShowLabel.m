//
//  AnimateShowLabel.m
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-2-10.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "AnimateShowLabel.h"
#import "ColorsAndFonts.h"

@implementation AnimateShowLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setScrollEnabled:NO];
        title_First = [[UILabel alloc] init];
        title_Second = [[UILabel alloc] init];
        canMove = NO;
    }
    return self;
}
- (void)setTitleWithTitleText:(NSString *)title andTitleColor:(UIColor *)color andTitleFont:(UIFont *)font andMoveSpeed:(float)speed andIsAutomatic:(BOOL)automatic
{
    _speed = speed;
    title_Name = title;
    CGSize titleSize = [title sizeWithFont:font];
    [title_First  setFrame:CGRectMake(8, 0, titleSize.width, self.frame.size.height)];
    [title_First setFont:font];
    [title_First setTextColor:color];
    [title_First setText:title];
    [self addSubview:title_First];
    if (titleSize.width < self.frame.size.width && automatic) {
        canMove = NO;
    }else{
        canMove = YES;
        [title_Second setFrame:CGRectMake(titleSize.width +88, 0, titleSize.width, self.frame.size.height)];
        [title_Second setFont:font];
        [title_Second setText:title];
        [title_Second setTextColor:color];
        [self addSubview:title_Second];
    }
}

- (void)animationUpdate
{
    CGRect frame_first = title_First.frame;
    if (frame_first.origin.x <= -frame_first.size.width) {
        frame_first.origin.x = frame_first.size.width + 160;
        if (canMove) {
             CGRect frame_second = title_Second.frame;
            frame_second.origin.x = 80;
            [title_Second setFrame:frame_second];
        }
    }
    frame_first.origin.x -= _speed;
    [title_First setFrame:frame_first];
    if (canMove) {
        CGRect frame_second = title_Second.frame;
        if (frame_second.origin.x <= -frame_second.size.width) {
            frame_second.origin.x = frame_second.size.width + 160;
            frame_first.origin.x = 80;
            [title_First setFrame:frame_first];
        }
       
        frame_second.origin.x -= _speed;
        [title_Second setFrame:frame_second];
    }
 
}

- (void)animateRestart
{
    if (animationTimer) {
        [animationTimer invalidate];
        animationTimer = nil;
    }
    CGRect frame_first = title_First.frame;
    frame_first.origin.x = 8;
    [title_First setFrame:frame_first];
    if (canMove) {
        CGRect frame_second = title_Second.frame;
        frame_second.origin.x = frame_second.size.width + 88;
        [title_Second setFrame:frame_second];
        [self performSelector:@selector(moved) withObject:nil afterDelay:2];
    }
}

- (void)animateStart
{
    if (canMove) {
        [self performSelector:@selector(moved) withObject:nil afterDelay:2];
    }
    
}

- (void)moved
{
    if (animationTimer) {
        [animationTimer invalidate];
        animationTimer = nil;
    }
    animationTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0
                                                      target:self
                                                    selector:@selector(animationUpdate)
                                                    userInfo:nil
                                                     repeats:YES];
    [animationTimer setFireDate:[NSDate distantPast]];

}

- (void)animateStop
{
    if (canMove) {
        if (animationTimer) {
            [animationTimer invalidate];
            animationTimer = nil;
        }
    }
  
}

- (void)setTitleTextAlignment:(NSTextAlignment)alignment
{
    [title_First setTextAlignment:alignment];
    [title_Second setTextAlignment:alignment];
}

@end
