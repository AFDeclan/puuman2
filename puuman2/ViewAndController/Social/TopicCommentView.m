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
        textField= [[UITextField alloc] initWithFrame:CGRectMake(24, 4, 480, 40)];
        [textField setBackgroundColor:[UIColor clearColor]];
        [self addSubview:textField];
        
        createBtn = [[ColorButton alloc] init];
        [createBtn initWithTitle:@"留言" andIcon:[UIImage imageNamed:@"icon_reply_topic.png"] andButtonType:kBlueLeft];
        [self addSubview:createBtn];
        [createBtn addTarget:self action:@selector(replayed) forControlEvents:UIControlEventTouchUpInside];
        SetViewLeftUp(createBtn, 496, 4);
        [createBtn setEnabled:NO];
        [createBtn setAlpha:0.5];
        
        
        
    }
    return self;
}

- (void)setCommentWithReply:(Reply *)reply
{
    CGRect frame = self.frame;
    if (reply.RCommentCnt == 0) {
        frame.size.height = 48;
    }else{
        if ([reply.comments count] <= 5 && [reply.comments count] < reply.RCommentCnt){
            [reply getMoreComments:5 newDirect:YES];
        }else{

        }
        frame.size.height = 48 +50*([reply.comments count]>5?5:[reply.comments count]);
    }
    self.frame = frame;
    
}

//评论上传成功
- (void)replyCommentUploaded:(Reply *)reply
{
    
    
}

//评论上传失败
- (void)replyCommentUploadFailed:(Reply *)reply
{
    
}


//更多评论加载成功
- (void)replyCommentsLoadedMore:(Reply *)reply
{
}

//更多评论加载失败 注意根据noMore判断是否是因为全部加载完
- (void)replyCommentsLoadFailed:(Reply *)reply
{
    
}


- (void)replayed
{

}


@end
