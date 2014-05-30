//
//  VideoShowButton.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-27.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>

@protocol VideoShowButtonDelegate;
@interface VideoShowButton : UIView
{
    CGImageSourceRef gif;
    NSDictionary *gifProperties;
    NSInteger currentProperty;
    NSInteger countProperty;
    NSTimer *timer;
    UIButton *playBtn;
    NSMutableArray *refs;
}
@property(nonatomic,assign)id<VideoShowButtonDelegate> delegate;
@property(assign,nonatomic)BOOL clickEnable;

- (id)initWithFrame:(CGRect)frame fileName:(NSString *)fileName;
- (void)stopGif;
-(void)startGif;
- (void)showGifAtIndex:(NSInteger)index;

@end
@protocol VideoShowButtonDelegate <NSObject>
- (void)showVideo;
@end