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
#import "Group.h"
#import "ActionForUpload.h"

@interface ChatInputViewController ()

@end

@implementation ChatInputViewController
@synthesize sendIsHidden = _sendIsHidden;
@synthesize actionParent = _actionParent;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      
       
        [bgView setAlpha:0];
        input_now = NO;
        _sendIsHidden = NO;
        addHeightNum = 0;
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
        createBtn = [[AFColorButton alloc] init];
        [_content addSubview:createBtn];
        [createBtn addTarget:self action:@selector(create) forControlEvents:UIControlEventTouchUpInside];
        createBtn.enabled = NO;
        createBtn.alpha = 0.5;
        [createBtn setIconImg:[UIImage imageNamed:@"icon_reply_topic.png"]];
        [createBtn setIconSize:CGSizeMake(16, 16)];
        [createBtn setColorType:kColorButtonBlueColor];
        [createBtn setDirectionType:kColorButtonLeft];
        [createBtn resetColorButton];
        
        
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
        

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taped)];
        [bgView addGestureRecognizer:tap];
//        [MyNotiCenter addObserver:self selector:@selector(removeAllDelegate) name:Noti_RemoveFriendDelegate object:nil];
        
    }
    return self;
}

- (void)removeAllDelegate
{
    [[Friend sharedInstance] removeDelegateObject:self];
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
    keyBoardHeigh = rect.size.height >rect.size.width ?rect.size.width :rect.size.height;
    NSTimeInterval animationDuration = [[[notif userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration*1.1 animations:^{
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
    CGRect rect = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyBoardHeigh = rect.size.height >rect.size.width ?rect.size.width :rect.size.height;
    
    
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
        if (_sendIsHidden) {
                [UIView animateWithDuration:animationDuration*ViewHeight(_content)/keyBoardHeigh animations:^{
                SetViewLeftUp(_content, 0, ViewHeight(_content));
            }completion:^(BOOL finished) {
                [[MainTabBarController sharedMainViewController] hiddenBottomInputView];

            }];
        }
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
    
    float height  = 0;
    if (newSizeH > maxHeight) {
        height = maxHeight - minHeight;
    }else{
        if (newSizeH > minHeight && newSizeH < minHeight +preheight) {
            height = preheight;
        }else{
            height = preheight *(int)((newSizeH - minHeight)/preheight);
            
        }
        
    }
    if ([MainTabBarController sharedMainViewController].isVertical) {
        _content.frame=CGRectMake(_content.frame.origin.x, 1024-keyBoardHeigh- 56-height,ViewWidth(_content), height+  56);
        [bg_inputView setFrame:CGRectMake(0, 4, 640, ViewHeight(_content)-8)];
        [inputTextView setFrame:CGRectMake(16, 10, 608, ViewHeight(_content)-20)];
        SetViewLeftUp(createBtn, ViewWidth(_content)-ViewWidth(createBtn), ViewHeight(_content)-48);
        [inputTextView setContentOffset:CGPointMake(0, newSizeH - ViewHeight(inputTextView))];
    }else{
        _content.frame=CGRectMake(_content.frame.origin.x, 768-keyBoardHeigh- 56-height,ViewWidth(_content), height+  56);
        [bg_inputView setFrame:CGRectMake(0, 4, 900, ViewHeight(_content)-8)];
        [inputTextView setFrame:CGRectMake(16, 10, 868, ViewHeight(_content)-20)];
        SetViewLeftUp(createBtn, ViewWidth(_content)-ViewWidth(createBtn), ViewHeight(_content)-48);
        [inputTextView setContentOffset:CGPointMake(0, newSizeH - ViewHeight(inputTextView))];
    }
 

    
//    
//    if (newSizeH>minHeight&&newSizeH<maxHeight) {
//        
//        addHeightNum += preheight;
//        _content.frame=CGRectMake(_content.frame.origin.x, _content.frame.origin.y-preheight,ViewWidth(_content), ViewHeight(_content)+preheight);
//        inputTextView.frame=CGRectMake(inputTextView.frame.origin.x, inputTextView.frame.origin.y, inputTextView.frame.size.width, inputTextView.frame.size.height+preheight);
//        minHeight=newSizeH;
//        [bg_inputView setFrame:CGRectMake(bg_inputView.frame.origin.x, bg_inputView.frame.origin.y, bg_inputView.frame.size.width, bg_inputView.frame.size.height + preheight)];
//        
//        
//    }else if(newSizeH<minHeight)
//    {
//        addHeightNum -= preheight;
//        _content.frame=CGRectMake(_content.frame.origin.x, _content.frame.origin.y+preheight, ViewWidth(_content), ViewHeight(_content)-preheight);
//        inputTextView.frame=CGRectMake(inputTextView.frame.origin.x, inputTextView.frame.origin.y, inputTextView.frame.size.width, inputTextView.frame.size.height-preheight);
//        minHeight=newSizeH;
//        [bg_inputView setFrame:CGRectMake(bg_inputView.frame.origin.x, bg_inputView.frame.origin.y, bg_inputView.frame.size.width, bg_inputView.frame.size.height - preheight)];
//        SetViewLeftUp(createBtn, createBtn.frame.origin.x, createBtn.frame.origin.y-preheight);
//    }

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.length == 1) {
        if ([textView.text length]==1) {
            createBtn.enabled = NO;
            createBtn.alpha = 0.5;
        }else
        {
            createBtn.enabled = YES;
            createBtn.alpha = 1;
        }
    }else{
        if ([text isEqualToString:@""]) {
            createBtn.enabled = NO;
            createBtn.alpha = 0.5;
        }else{
            createBtn.enabled = YES;
            createBtn.alpha = 1;
        }

    }
    return YES;
}

-(void)show
{
    
    if (_sendIsHidden) {
        [[Forum sharedInstance] addDelegateObject:self];
        SetViewLeftUp(_content, 0, 0);
        [inputTextView becomeFirstResponder];
        
    }else{
         PostNotification(Noti_RemoveFriendDelegate, nil);
        [[Friend sharedInstance] addDelegateObject:self];
        SetViewLeftUp(_content, 0, 56);
        [UIView animateWithDuration:0.5 animations:^{
            SetViewLeftUp(_content, 0, 0);
        }];
    }
    
 
}

-(void)hidden
{
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [UIView animateWithDuration:0.5 animations:^{
        SetViewLeftUp(_content, 0, 56);
    }completion:^(BOOL finished) {
         [[Forum sharedInstance] removeDelegateObject:self];
        [[Friend sharedInstance] removeDelegateObject:self];
        [self.view removeFromSuperview];
    }];
}

- (void)reset
{
    
    [inputTextView setText:@""];
    [_content setFrame:CGRectMake( ViewX(_content),  ViewY(_content)+preheight, ViewWidth(_content),ViewHeight(_content)-addHeightNum)];
    [inputTextView setFrame:CGRectMake(ViewX(inputTextView), ViewY(inputTextView), ViewWidth(inputTextView), ViewHeight(inputTextView)-addHeightNum)];
    [bg_inputView setFrame:CGRectMake(bg_inputView.frame.origin.x, bg_inputView.frame.origin.y, bg_inputView.frame.size.width, bg_inputView.frame.size.height - addHeightNum)];
    SetViewLeftUp(createBtn, createBtn.frame.origin.x, createBtn.frame.origin.y-addHeightNum);
    addHeightNum = 0;
    minHeight = 36;
    preheight =19;
    maxHeight = 19+6*minHeight;
    input_now = NO;
    createBtn.enabled = NO;
    createBtn.alpha = 0.5;
    [inputTextView resignFirstResponder];

}

- (void)create
{
    if (_sendIsHidden) {
        [(Reply *)_actionParent comment:inputTextView.text];
        [inputTextView resignFirstResponder];
    }else{
        [[(Group *)_actionParent actionForSendMsg:inputTextView.text] upload];
        [self reset];
    }
  
}

- (void)taped
{
    if (_sendIsHidden) {
         [inputTextView resignFirstResponder];
    }else{
        [self reset];
    }
}




- (void)setSendIsHidden:(BOOL)sendIsHidden 
{
    
    _sendIsHidden = sendIsHidden;
    if (sendIsHidden) {
        [createBtn.title setText:@"留言"];
    }else{
        [createBtn.title setText:@"发送"];

    }
    [createBtn adjustLayout];
}

//更多评论加载成功
- (void)replyCommentsLoadedMore:(Reply *)reply
{
    PostNotification(Noti_RefreshTopicTable, nil);
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [self.view removeFromSuperview];
    [[MainTabBarController sharedMainViewController] hiddenBottomInputView];
}

//更多评论加载失败 注意根据noMore判断是否是因为全部加载完
- (void)replyCommentsLoadFailed:(Reply *)reply
{
    
}

//Group Action 上传成功
- (void)actionUploaded:(ActionForUpload *)action
{
    PostNotification(Noti_RefreshChatTable, nil);
    
}
//Group Action 上传失败
- (void)actionUploadFailed:(ActionForUpload *)action
{

}

@end
