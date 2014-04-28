//
//  AllWordsPopViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-20.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "AllWordsPopViewController.h"
#import "ColorsAndFonts.h"
#import "AllWordsPopTalkTableViewCell.h"
#import "Comment.h"

@interface AllWordsPopViewController ()

@end

@implementation AllWordsPopViewController
@synthesize replay =_replay;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initWithContent];
    }
    return self;
}

- (void)initWithContent
{
    talkTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(48, 112, 528, 48)];
    talkTextField.placeholder = @"在此发表您的留言";
    [talkTextField setDelegate:self];
    [talkTextField setReturnKeyType:UIReturnKeyDone];
    [_content addSubview:talkTextField];
    
    talksTable = [[UITableView alloc] initWithFrame:CGRectMake(48, 168, 528, 436)];
    [talksTable setBackgroundColor:PMColor5];
    [talksTable setDelegate:self];
    [talksTable setDataSource:self];
    [talksTable setSeparatorColor:[UIColor clearColor]];
    [talksTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [talksTable setShowsHorizontalScrollIndicator:NO];
    [talksTable setShowsVerticalScrollIndicator:NO];
    [_content addSubview:talksTable];
    
    createTalkBtn = [[ColorButton alloc] init];
    [createTalkBtn initWithTitle:@"留言" andIcon:[UIImage imageNamed:@"icon_reply_topic.png"] andButtonType:kBlueLeft];
    [_content addSubview:createTalkBtn];
    [createTalkBtn addTarget:self action:@selector(replayed) forControlEvents:UIControlEventTouchUpInside];
    SetViewLeftUp(createTalkBtn, 592, 112);
    [createTalkBtn setEnabled:NO];
    [createTalkBtn setAlpha:0.5];
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


- (void)viewDidDisappear:(BOOL)animated
{
}
#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_replay comments] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
   
    
     NSString  *identity = @"talkPopCell";
      AllWordsPopTalkTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell){
            cell = [[AllWordsPopTalkTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
            
    }
    
    Comment *comment =[[_replay comments] objectAtIndex:[indexPath row]];
    
    [cell buildWithUid:comment.UID andIndex:[indexPath row] andCommmet: comment.CContent];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [AllWordsPopTalkTableViewCell heightForComment:[[[_replay comments] objectAtIndex:[indexPath row]] CContent]];
}


- (void)replayed
{
    [talkTextField resignFirstResponder];
    [_replay comment:talkTextField.text];

}

- (void)show
{
    
    [super show];
}

- (void)closeBtnPressed
{
    [[Forum sharedInstance] removeDelegateObject:self];
    [super closeBtnPressed];
}

//评论上传成功
- (void)replyCommentUploaded:(Reply *)reply
{
   
    [talkTextField setText:@""];
    [createTalkBtn setEnabled:NO];
    [createTalkBtn setAlpha:0.5];
    [talksTable reloadData];
}

//评论上传失败
- (void)replyCommentUploadFailed:(Reply *)reply
{
    
}


//更多评论加载成功
- (void)replyCommentsLoadedMore:(Reply *)reply
{
    if (_refreshFooter.isRefreshing)
        [_refreshFooter endRefreshing];
    if (_refreshHeader.isRefreshing)
        [_refreshHeader endRefreshing];
   
    [talksTable reloadData];
}

//更多评论加载失败 注意根据noMore判断是否是因为全部加载完
- (void)replyCommentsLoadFailed:(Reply *)reply
{
    if (_refreshFooter.isRefreshing)
        [_refreshFooter endRefreshing];
    if (_refreshHeader.isRefreshing)
        [_refreshHeader endRefreshing];
     [talksTable reloadData];
}


- (void)setReplay:(Reply *)replay
{
    _replay =replay;
    
    if (replay.TID == [[Forum sharedInstance] onTopic].TID) {
        [talkTextField setAlpha:1];
        [createTalkBtn setAlpha:1];
        [talksTable setContentSize:CGSizeMake(528, 436)];
        [talksTable setFrame:CGRectMake(48, 168, 528, 436)];
    }else{
        [talkTextField setAlpha:0];
        [createTalkBtn setAlpha:0];
        [talksTable setContentSize:CGSizeMake(528, 492)];
        [talksTable setFrame:CGRectMake(48, 112, 528, 492)];
    }
    [[Forum sharedInstance] addDelegateObject:self];
    if (!_refreshFooter) {
        _refreshFooter = [[MJRefreshFooterView alloc] init];
        _refreshFooter.scrollView = talksTable;
        [talksTable addSubview:_refreshFooter];
        [_refreshFooter setDelegate:self];
        _refreshFooter.alpha = 1;
        __block MJRefreshFooterView * blockRefreshFooter = _refreshFooter;
        __block Reply * reply = _replay;
        _refreshFooter.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
            [reply getMoreComments:2 newDirect:NO];
            if (![replay noMore])
            {
                [blockRefreshFooter endRefreshing];
            }
        };
        
        [_refreshFooter beginRefreshing];
        
    }
    if (!_refreshHeader) {
        _refreshHeader = [[MJRefreshHeaderView alloc] init];
        _refreshHeader.scrollView = talksTable;
        [talksTable addSubview:_refreshHeader];
        [_refreshHeader setDelegate:self];
        _refreshHeader.alpha = 1;
        __block Reply * reply = _replay;
        _refreshHeader.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
            [reply getMoreComments:2 newDirect:YES];
        };
        
    }
    

    [talksTable reloadData];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.length == 1) {
        if ([textField.text length]==1) {
            [createTalkBtn setEnabled:NO];
            [createTalkBtn setAlpha:0.5];
            
        }else{
            [createTalkBtn setEnabled:YES];
            [createTalkBtn setAlpha:1];
            
        }
    }else{
        [createTalkBtn setEnabled:YES];
        [createTalkBtn setAlpha:1];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self replayed];
    return YES;
}
@end
