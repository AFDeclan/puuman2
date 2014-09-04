//
//  AFAnimationManager.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-3.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

#define kAFAnimationName  @"kAFAnimationName"
#define kAFAnimationType  @"kAFAnimationType"
#define kAFAnimationHiddenOut  @"kAFAnimationNameHiddenOut"
#define kAFAnimationShowIn  @"kAFAnimationNameShowIn"
#define kAFAnimationFadeOut  @"kAFAnimationFadeOut"
#define kAFAnimationFadeIn  @"kAFAnimationFadeIn"
#define kAFAnimationTypeIn  @"kAFAnimationTypeIn"
#define kAFAnimationTypeOut  @"kAFAnimationTypeOut"
#define kAFAnimationTargetViewKey  @"kAFAnimationTargetViewKey"
#define kAFAnimationCallerDelegateKey  @"kAFAnimationCallerDelegateKey"
#define kAFAnimationCallerStartSelectorKey  @"kAFAnimationCallerStartSelectorKey"
#define kAFAnimationCallerStopSelectorKey  @"kAFAnimationCallerStopSelectorKey"
#define kAFAnimationWasInteractionEnabledKey  @"kAFAnimationWasInteractionEnabledKey"
#define kAFAnimationNextAnimationKey  @"kAFAnimationNextAnimationKey"
#define kAFAnimationIsChainedKey  @"kAFAnimationIsChainedKey"

typedef enum _FTAnimationDirection {
    kAFAnimationTop = 0,
    kAFAnimationRight,
    kAFAnimationBottom,
    kAFAnimationLeft,
    kAFAnimationTopLeft,
    kAFAnimationTopRight,
    kAFAnimationBottomLeft,
    kAFAnimationBottomRight,
    kAFAnimationNone,
    kAFAnimationFromTop,
    kAFAnimationFromOutTop,
    kAFanimationFromRight
    
} AFAnimationDirection;

static inline CGPoint FTAnimationOutOfViewCenterPoint(CGRect enclosingViewFrame, CGRect viewFrame, CGPoint viewCenter, AFAnimationDirection direction) {
	switch (direction) {
		case kAFAnimationBottom: {
			CGFloat extraOffset = viewFrame.size.height / 2;
			return CGPointMake(viewCenter.x, enclosingViewFrame.size.height + extraOffset);
			break;
		}
		case kAFAnimationTop: {
			CGFloat extraOffset = viewFrame.size.height / 2;
			return CGPointMake(viewCenter.x, enclosingViewFrame.origin.y - extraOffset);
			break;
		}
     
		case kAFAnimationLeft: {
			CGFloat extraOffset = viewFrame.size.width / 2;
			return CGPointMake(enclosingViewFrame.origin.x - extraOffset, viewCenter.y);
			break;
		}
		case kAFAnimationRight: {
			CGFloat extraOffset = viewFrame.size.width / 2;
			return CGPointMake(enclosingViewFrame.size.width + extraOffset, viewCenter.y);
			break;
		}
		case kAFAnimationBottomLeft: {
			CGFloat extraOffsetHeight = viewFrame.size.height / 2;
			CGFloat extraOffsetWidth = viewFrame.size.width / 2;
			return CGPointMake(enclosingViewFrame.origin.x - extraOffsetWidth, enclosingViewFrame.size.height + extraOffsetHeight);
			break;
		}
		case kAFAnimationTopLeft: {
			CGFloat extraOffsetHeight = viewFrame.size.height / 2;
			CGFloat extraOffsetWidth = viewFrame.size.width / 2;
			return CGPointMake(enclosingViewFrame.origin.x - extraOffsetWidth, enclosingViewFrame.origin.y - extraOffsetHeight);
			break;
		}
		case kAFAnimationBottomRight: {
			CGFloat extraOffsetHeight = viewFrame.size.height / 2;
			CGFloat extraOffsetWidth = viewFrame.size.width / 2;
			return CGPointMake(enclosingViewFrame.size.width + extraOffsetWidth, enclosingViewFrame.size.height + extraOffsetHeight);
			break;
		}
		case kAFAnimationTopRight: {
			CGFloat extraOffsetHeight = viewFrame.size.height / 2;
			CGFloat extraOffsetWidth = viewFrame.size.width / 2;
			return CGPointMake(enclosingViewFrame.size.width + extraOffsetWidth, enclosingViewFrame.origin.y - extraOffsetHeight);
			break;
		}
        case kAFAnimationNone: {
			return CGPointMake(viewCenter.x,viewCenter.y);
			break;
		}
        case kAFanimationFromRight:{
            CGFloat extraOffset = viewFrame.size.width / 2;
			return CGPointMake(enclosingViewFrame.size.width + extraOffset, viewCenter.y);
			break;
        }
        case kAFAnimationFromTop: {
			CGFloat extraOffset = viewFrame.size.height/2 ;
			return CGPointMake(viewCenter.x, enclosingViewFrame.origin.y - extraOffset );
			break;
		}
        case kAFAnimationFromOutTop: {
			CGFloat extraOffset = viewFrame.size.height/2 + 189;
			return CGPointMake(viewCenter.x, enclosingViewFrame.origin.y - extraOffset );
			break;
		}
	}
	return CGPointZero;
}


@interface AFAnimationManager : NSObject
{

}
@property(assign) CGFloat overshootThreshold;
+ (AFAnimationManager *)sharedManager;
- (CAAnimation *)showInAnimationFor:(UIView *)view withFade:(BOOL)fade direction:(AFAnimationDirection)direction inView:(UIView*)enclosingView
                           duration:(NSTimeInterval)duration delegate:(id)delegate
                      startSelector:(SEL)startSelector stopSelector:(SEL)stopSelector;
- (CAAnimation *)hiddenOutAnimationFor:(UIView *)view withFade:(BOOL)fade direction:(AFAnimationDirection)direction inView:(UIView*)enclosingView
                           duration:(NSTimeInterval)duration delegate:(id)delegate
                      startSelector:(SEL)startSelector stopSelector:(SEL)stopSelector;
@end
