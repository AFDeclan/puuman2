//
//  ChatInputViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-21.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PopViewController.h"
#import "ChatInputTextView.h"
#import "ColorButton.h"

@interface ChatInputViewController : PopViewController<UITextViewDelegate>

{
    ChatInputTextView *inputTextView;
    ColorButton *createBtn;
    UIView *bg_inputView;
    BOOL input_now;
    float maxHeight;
    float minHeight;
    float preheight;
    int addHeightNum;
    
}
@property(assign,nonatomic)BOOL sendIsHidden;

- (void)show;
- (void)hidden;
- (void)reset;
@end

