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

@interface AllWordsPopViewController ()

@end

@implementation AllWordsPopViewController

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
    [_content addSubview:talksTable];
    
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
    SetViewLeftUp(_content, 592, 232);
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

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
   
    
     NSString  *identity = @"talkPopCell";
      AllWordsPopTalkTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell){
            cell = [[AllWordsPopTalkTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
            
    }
        
        
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [AllWordsPopTalkTableViewCell heightForTalk:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}


@end
