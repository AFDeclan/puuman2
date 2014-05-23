//
//  TopicCommentView.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-22.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//


#import "TopicCommentView.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"
#import "AllWordsPopViewController.h"
#import "MainTabBarController.h"


@implementation TopicCommentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[Forum sharedInstance] addDelegateObject:self];
        [self setBackgroundColor:PMColor5];
        UIView *bgText  =[[UIView alloc] initWithFrame:CGRectMake(16, 4, 520, 40)];
        [bgText.layer setCornerRadius:8];
        [bgText setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:bgText];
        commentText= [[UITextField alloc] initWithFrame:CGRectMake(24, 4, 480, 40)];
        [commentText setBackgroundColor:[UIColor clearColor]];
        [commentText setDelegate:self];
        [self addSubview:commentText];
        
        createBtn = [[ColorButton alloc] init];
        [createBtn initWithTitle:@"留言" andIcon:[UIImage imageNamed:@"icon_reply_topic.png"] andButtonType:kBlueLeft];
        [self addSubview:createBtn];
        [createBtn addTarget:self action:@selector(replayed) forControlEvents:UIControlEventTouchUpInside];
        SetViewLeftUp(createBtn, 496, 4);
        [createBtn setEnabled:NO];
        [createBtn setAlpha:0.5];
        for (int i = 0; i < 5; i ++) {
            comments[i] = [[TopicCommentCell alloc] init];
            [self addSubview:comments[i]];
            [comments[i] setAlpha:0];
        }
        scanMoreReplay = [[AFTextImgButton alloc] initWithFrame:CGRectMake(0, 0, 608, 48)];
        [scanMoreReplay setTitle:@"点击查看更多留言" andImg:nil andButtonType:kButtonTypeOne];
        [scanMoreReplay setTitleLabelColor:PMColor3];
        [scanMoreReplay addTarget:self action:@selector(scanMore) forControlEvents:UIControlEventTouchUpInside];
        [scanMoreReplay setTitleFont:PMFont3];
        [self addSubview:scanMoreReplay];
        [scanMoreReplay setAlpha:0];
        [MyNotiCenter addObserver:self selector:@selector(hiddenKeyBopard) name:Noti_HiddenCommentKeyBoard object:nil];
        
    }
    return self;
}

-(void)hiddenKeyBopard
{
    [commentText resignFirstResponder];
}

- (void)setCommentWithReply:(Reply *)reply
{
    _reply = reply;
    float height = 48;
    for (int i = 0; i < 5; i++) {
        if (i < [reply.comments count]) {
            [comments[i] setAlpha:1];
            [comments[i] buildWithComment:[reply.comments objectAtIndex:i]];
            SetViewLeftUp(comments[i], 0, height);
            height += ViewHeight(comments[i]);
        }else{
            [comments[i] setAlpha:0];
        }
    }
    if (reply.RCommentCnt >5) {
        [scanMoreReplay setAlpha:1];
        SetViewLeftUp(scanMoreReplay, 0, height);
        height += ViewHeight(scanMoreReplay);
    }else{
        [scanMoreReplay setAlpha:0];
    }
    
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    
}

- (void)replayed
{
    [_reply comment:commentText.text];
    [commentText setText:@""];
    [commentText resignFirstResponder];
    [createBtn setEnabled:NO];
    [createBtn setAlpha:0.5];
    
}

- (void)scanMore
{
    PostNotification(Noti_ShowCommentPopView, [NSNumber numberWithBool:YES]);
    AllWordsPopViewController *moreReplayVC  =[[ AllWordsPopViewController alloc] initWithNibName:nil bundle:nil];
    [[MainTabBarController sharedMainViewController].view addSubview:moreReplayVC.view];
    [moreReplayVC setControlBtnType:kOnlyCloseButton];
    [moreReplayVC setTitle:@"所有留言"];
    [moreReplayVC setReplay:_reply];
    [moreReplayVC setDelegate:self];
    [moreReplayVC show];
}

- (void)popViewfinished
{
    
    PostNotification(Noti_ShowCommentPopView, [NSNumber numberWithBool:NO]);

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.length == 1) {
        if ([textField.text length]==1) {
            createBtn.enabled = NO;
            createBtn.alpha = 0.5;
        }else
        {
            createBtn.enabled = YES;
            createBtn.alpha = 1;
        }
    }else{
        if ([string isEqualToString:@""]) {
            createBtn.enabled = NO;
            createBtn.alpha = 0.5;
        }else{
            createBtn.enabled = YES;
            createBtn.alpha = 1;
        }
        
    }
    return YES;
}

@end
