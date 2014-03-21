//
//  ChatInputViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-21.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "ChatInputViewController.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"
#import "MainTabBarController.h"

@interface ChatInputViewController ()

@end

@implementation ChatInputViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      
        [bgView setAlpha:0];
        input_now = NO;
        self.view.backgroundColor = [UIColor clearColor];
        [_content setBackgroundColor:PMColor3];
        bg_inputView = [[UIView alloc] init];
        [bg_inputView setBackgroundColor:[UIColor whiteColor]];
        [_content addSubview:bg_inputView];
        [_content setFrame:CGRectMake(0, 0, 0, 56)];
        inputTextView = [[ChatInputTextView alloc] initWithFrame:CGRectMake(0, 0, 0,16)];
        [inputTextView setContentInset:UIEdgeInsetsZero];
        [inputTextView setShowsHorizontalScrollIndicator:NO];
        [inputTextView setFont:PMFont2];
        [inputTextView setTextColor:PMColor1];
        [inputTextView setDelegate:self];
        [inputTextView setBackgroundColor:[UIColor whiteColor]];
        [_content addSubview:inputTextView];
        [inputTextView setTextAlignment:NSTextAlignmentLeft];
        [inputTextView setText:@""];
        [inputTextView sizeToFit];
        minHeight = 36;
        preheight =19;
        maxHeight = 19+6*minHeight;
        createBtn = [[ColorButton alloc] init];
        [createBtn initWithTitle:@"留言" andIcon:[UIImage imageNamed:@"icon_reply_topic.png"] andButtonType:kBlueLeft];
        [_content addSubview:createBtn];

        if ([MainTabBarController sharedMainViewController].isVertical) {
            [self setVerticalFrame];
        }else{
            [self setHorizontalFrame];
        }
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        

    }
    return self;
}


- (void)keyboardWillShow:(NSNotification *)notif
{

    input_now = YES;
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }
    CGRect rect = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    float keyBoardHeigh = rect.size.height >rect.size.width ?rect.size.width :rect.size.height;
    NSTimeInterval animationDuration = [[[notif userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
             [bgView setAlpha:0.3];
        if ([MainTabBarController sharedMainViewController].isVertical) {
            SetViewLeftUp(_content, 0, 1024-keyBoardHeigh-ViewHeight(_content));
        }else{
            SetViewLeftUp(_content, 0, 768-keyBoardHeigh-ViewHeight(_content));
        }
   
    }];
}

- (void)keyboardWillHide:(NSNotification *)notif
{

    input_now = NO;

    NSTimeInterval animationDuration = [[[notif userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    
    
    [UIView animateWithDuration:animationDuration animations:^{
        if ([MainTabBarController sharedMainViewController].isVertical) {
            
            SetViewLeftUp(_content, 0, 1024-ViewHeight(_content));
        }else{
            SetViewLeftUp(_content, 0, 768-ViewHeight(_content));
        }
        [bgView setAlpha:0];
    }completion:^(BOOL finished) {
        if ([MainTabBarController sharedMainViewController].isVertical) {
            self.view.frame = CGRectMake(0, 1024-ViewHeight(_content), 768, ViewHeight(_content));
           
        }else{
            self.view.frame = CGRectMake(0, 768-ViewHeight(_content), 1024,  ViewHeight(_content));
           
        }
         SetViewLeftUp(_content, 0, 0);
    }];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setVerticalFrame
{
    if (input_now) {
        
        self.view.frame = CGRectMake(0, 0, 768, 1024);
        [bgView setFrame:CGRectMake(0, 0, 768, 1024)];
        [_content setFrame:CGRectMake(0, 1024-ViewHeight(_content), 768, ViewHeight(_content))];
        [inputTextView setFrame:CGRectMake(16, 10, 608, ViewHeight(inputTextView))];
        [bg_inputView setFrame:CGRectMake(0, 4, 640, ViewHeight(_content)-8)];
    }else{
        
        self.view.frame = CGRectMake(0, 968, 768, ViewHeight(_content));
        [_content setFrame:CGRectMake(0, 0, 768, ViewHeight(_content))];
        [inputTextView setFrame:CGRectMake(16, 10, 608, ViewHeight(inputTextView))];
        [bg_inputView setFrame:CGRectMake(0, 4, 640, ViewHeight(_content)-8)];

    }
    SetViewLeftUp(createBtn, ViewWidth(_content)-ViewWidth(createBtn), ViewHeight(_content)-48);

    
}

- (void)setHorizontalFrame
{
    if (input_now) {
        
        self.view.frame = CGRectMake(0, 0, 1024, 768);
        [bgView setFrame:CGRectMake(0, 0, 1024, 768)];
        [_content setFrame:CGRectMake(0, 1024-ViewHeight(_content), 1024, ViewHeight(_content))];
        [inputTextView setFrame:CGRectMake(16, 10, 868,ViewHeight(inputTextView))];
        [bg_inputView setFrame:CGRectMake(0, 4, 900, ViewHeight(_content)-8)];
    }else{
        self.view.frame = CGRectMake(0, 712, 1024,  ViewHeight(_content));
        [_content setFrame:CGRectMake(0, 0, 1024,  ViewHeight(_content))];
        [inputTextView setFrame:CGRectMake(16, 10, 868, ViewHeight(inputTextView))];
        [bg_inputView setFrame:CGRectMake(0, 4, 900, ViewHeight(_content)-8)];
      
    }
    SetViewLeftUp(createBtn, ViewWidth(_content)-ViewWidth(createBtn), ViewHeight(_content)-48);

}


- (void)textViewDidChange:(UITextView *)atextView
{
    NSInteger newSizeH = inputTextView.contentSize.height;
    
    if (newSizeH>minHeight&&newSizeH<maxHeight) {
        
        
        _content.frame=CGRectMake(_content.frame.origin.x, _content.frame.origin.y-preheight,ViewWidth(_content), ViewHeight(_content)+preheight);
        inputTextView.frame=CGRectMake(inputTextView.frame.origin.x, inputTextView.frame.origin.y, inputTextView.frame.size.width, inputTextView.frame.size.height+preheight);
        minHeight=newSizeH;
        [bg_inputView setFrame:CGRectMake(bg_inputView.frame.origin.x, bg_inputView.frame.origin.y, bg_inputView.frame.size.width, bg_inputView.frame.size.height + preheight)];
        SetViewLeftUp(createBtn, createBtn.frame.origin.x, createBtn.frame.origin.y+preheight);
        
        
    }else if(newSizeH<minHeight)
    {

        _content.frame=CGRectMake(_content.frame.origin.x, _content.frame.origin.y+preheight, ViewWidth(_content), ViewHeight(_content)-preheight);
        inputTextView.frame=CGRectMake(inputTextView.frame.origin.x, inputTextView.frame.origin.y, inputTextView.frame.size.width, inputTextView.frame.size.height-preheight);
        minHeight=newSizeH;
        [bg_inputView setFrame:CGRectMake(bg_inputView.frame.origin.x, bg_inputView.frame.origin.y, bg_inputView.frame.size.width, bg_inputView.frame.size.height - preheight)];
        SetViewLeftUp(createBtn, createBtn.frame.origin.x, createBtn.frame.origin.y-preheight);
    }

}

-(void)show
{
    SetViewLeftUp(_content, 0, 56);
    [UIView animateWithDuration:0.5 animations:^{
        SetViewLeftUp(_content, 0, 0);
    }];
}

-(void)hidden
{
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [UIView animateWithDuration:0.5 animations:^{
        SetViewLeftUp(_content, 0, 56);
    }completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}
@end
