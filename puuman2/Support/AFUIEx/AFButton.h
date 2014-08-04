//
//  AFButton.h
//  AFUIEx
//
//  Created by Declan on 13-12-18.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AFButtonDelegate;

@interface AFButton : UIButton

@property(nonatomic,assign)NSInteger flagTag;
@property(nonatomic,assign)id<AFButtonDelegate> delegate;
@property(assign,nonatomic)BOOL selected;

@end

@protocol AFButtonDelegate <NSObject>

- (void)clickAFButtonWithButton:(AFButton *)button;

@end