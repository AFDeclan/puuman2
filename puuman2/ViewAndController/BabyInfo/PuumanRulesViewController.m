//
//  PuumanRulesViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-15.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PuumanRulesViewController.h"
#import "ColorsAndFonts.h"

@interface PuumanRulesViewController ()

@end

@implementation PuumanRulesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(32, 112, 640, 640)];
        [_content addSubview:_textView];
        _textView.editable = NO;
        _textView.font = PMFont3;
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textColor = PMColor2;
        [_textView setText:@"1.如何获取扑满金币？\n\
         方法一：每给宝宝多纪录一条成长日记都领取到相应的扑满金币。\n\
         方法二：每多完成一个任务也会领取到相应的扑满金币噢。\n\
         \n2.如何使用扑满金币?\n\
         第一步：选好目标商品\n\
         第二步：成功支付\n\
         第三步：在浏览器左下方输入想要使的扑满金币个数。\n\
         第四步：点击确定，完成操作。\n\
         \n提示：在收到请求后，我们会在24小时内将金额的50%汇款到您指定的支付宝帐户内，剩余的50%我们会在订单确认后的第一时间补汇给您。^^详细的变现状态可以在扑满页面查询得到喔。\n\
         \n注意：为了保证交易的安全和公平，扑满日记正在建立信用等级系统，会从扑满日记1.1.0版本开始实行。\n\
         \n具体细则，请访问扑满日记官方网站或联系我们。"];
    }
    return self;
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

@end
