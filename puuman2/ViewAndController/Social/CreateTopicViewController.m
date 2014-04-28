//
//  CreateTopicViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-20.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CreateTopicViewController.h"
#import "UniverseConstant.h"
#import "Forum.h"
#import "CustomAlertViewController.h"

@interface CreateTopicViewController ()

@end

@implementation CreateTopicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initContent];
        [[Forum sharedInstance] addDelegateObject:self];
    }
    return self;
}

-(void)initContent
{
    bgTitleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(144, 122, 403, 174)];
    [bgTitleImageView setImage:[UIImage imageNamed:@"pic_start_topic.png"]];
    [_content addSubview:bgTitleImageView];
    
    inputTextFied = [[CustomTextField alloc] initWithFrame:CGRectMake(32, 286, 544, 48)];
   // inputTextFied.placeholder =[NSString stringWithFormat:@"您还可以发起%d个话题,30字以内哦",5];
    inputTextFied.placeholder = @"请输入您要发起的话题,30字以内哦";
    [inputTextFied setDelegate:self];
    [_content addSubview:inputTextFied];
    
//    instructionBtn = [[ColorButton alloc] init];
//    [instructionBtn  initWithTitle:@"说明" andIcon:[UIImage imageNamed:@"icon_info_diary.png"] andButtonType:kGrayLeftUp];
//    [instructionBtn addTarget:self action:@selector(instruction) forControlEvents:UIControlEventTouchUpInside];
//    [_content  addSubview:instructionBtn];
    createBtn = [[ColorButton alloc] init];
    [createBtn  initWithTitle:@"发起" andIcon:[UIImage imageNamed:@"icon_start_topic.png"] andButtonType:kBlueLeftDown];
    [createBtn addTarget:self action:@selector(createTopic) forControlEvents:UIControlEventTouchUpInside];
    [_content  addSubview:createBtn];
    SetViewLeftUp(instructionBtn, 592, 256);
    SetViewLeftUp(createBtn, 592, 296);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.length == 0) {
        if ([textField.text length] >=30) {
            NSString *str = [textField.text substringToIndex:30];
            textField.text =str;
        }
    }
    return YES;
}

- (void)showKeyBoard
{
    [inputTextFied becomeFirstResponder];

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

- (void)instruction
{

}

- (void)createTopic
{
    
    [[Forum sharedInstance] uploadNewTopic:inputTextFied.text detail:@"" type:TopicType_Text];
    
}

//新话题上传成功
- (void)topicUploaded
{
    PostNotification(Noti_RefreshVoteTabe, nil);
    [super closeBtnPressed];
}

//新话题上传失败
- (void)topicUploadFailed
{
    [CustomAlertViewController showAlertWithTitle:@"网络不给力~" confirmRightHandler:^{
        
    }];
}

- (void)topicUploadFull
{
    
}

@end
