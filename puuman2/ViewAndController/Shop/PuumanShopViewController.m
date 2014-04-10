//
//  PuumanShopViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-2.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PuumanShopViewController.h"
#import "MainTabBarController.h"
#import "ColorsAndFonts.h"
#import "BindAlpayViewController.h"
#import "CustomAlertViewController.h"

@interface PuumanShopViewController ()

@end

@implementation PuumanShopViewController
@synthesize wid = _wid;
@synthesize shop = _shop;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [icon setImage:[UIImage imageNamed:@"pic_coin_baby.png"]];
        [icon setFrame:CGRectMake(228, 10, 68, 68)];
        
        [self setTitle:@"扑满金库兑现" withIcon:nil];
        [self setControlBtnType:kCloseAndFinishButton];
        
        UILabel *noti = [[UILabel alloc] initWithFrame:CGRectMake(0, 112, 704, 32)];
        [noti setTextColor:PMColor2];
        [noti setFont:PMFont2];
        [noti setBackgroundColor:[UIColor clearColor]];
        [noti setTextAlignment:NSTextAlignmentCenter];
        [noti setText:@"付款完成后您可以使用扑满金币兑现"];
        [_content addSubview:noti];

        
        UILabel *noti_use = [[UILabel alloc] initWithFrame:CGRectMake(432, 180, 32, 16)];
        [noti_use setTextColor:PMColor2];
        [noti_use setFont:PMFont2];
        [noti_use setBackgroundColor:[UIColor clearColor]];
        [noti_use setTextAlignment:NSTextAlignmentCenter];
        [noti_use setText:@"使用"];
        [_content addSubview:noti_use];
        
        
        
        label_use = [[UILabel alloc] initWithFrame:CGRectMake(432, 204, 48, 16)];
        [label_use setTextColor:PMColor1];
        [label_use setFont:PMFont2];
        [label_use setText:@"0"];
        [label_use setBackgroundColor:[UIColor clearColor]];
        [_content addSubview:label_use];
        
        noti_have = [[UILabel alloc] initWithFrame:CGRectMake(448, 270, 240, 16)];
        [noti_have setTextColor:PMColor3];
        [noti_have setFont:PMFont2];
        [noti_have setBackgroundColor:[UIColor clearColor]];
        [noti_have setTextAlignment:NSTextAlignmentRight];
        [_content addSubview:noti_have];

        
        
        showBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 704, 608)];
        [showBtn addTarget:self action:@selector(showPuumanShopView) forControlEvents:UIControlEventTouchUpInside];
        [_content addSubview:showBtn];
        
        UIImageView *bgShow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 704, 608)];
        [bgShow setImage:[UIImage imageNamed:@"bg_subpage.png"]];
        [showBtn addSubview:bgShow];
        
        UIImageView *icon_show = [[UIImageView alloc] initWithFrame:CGRectMake(264, 5, 34, 34)];
        [icon_show setImage:[UIImage imageNamed:@"pic_coin_baby.png"]];
        [showBtn addSubview:icon_show];
        
        UILabel *notiShow  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 704, 48)];
        [notiShow setTextColor:PMColor6];
        [notiShow setFont:PMFont3];
        [notiShow setBackgroundColor:[UIColor clearColor]];
        [notiShow setTextAlignment:NSTextAlignmentCenter];
        [notiShow setText:@"可以用扑满金币兑换哦！"];
        [showBtn addSubview:notiShow];
        [bgView setAlpha:0];
        showed = NO;
        
        [self.view setBackgroundColor:[UIColor clearColor]];
        
        [self initPuumanScrokkView];
        
        
     
    }
    return self;
}

- (void)initPuumanScrokkView
{
    rulerPumanUse = [[WarePumanScrollView alloc] initWithFrame:CGRectMake(286, 142, 112, 144)];
    [rulerPumanUse setRulerBackgroundColor:PMColor4];
    [rulerPumanUse setOverlayColor:[UIColor clearColor]];
    [rulerPumanUse setMinorTickLength:8];
    [rulerPumanUse setMinorTickWidth:1];
    [rulerPumanUse setMinorTickColor:PMColor1];
    [rulerPumanUse setMinorTicksPerMajorTick:10];
    [rulerPumanUse setMinorTickDistance:24];
    [rulerPumanUse setMajorTickWidth:1];
    [rulerPumanUse setMajorTickLength:32];
    [rulerPumanUse setMajorTickColor:PMColor1];
    [rulerPumanUse setPerminorTickExpression:1];
    [rulerPumanUse setLabelFont:PMFont3];
    [rulerPumanUse setLabelFillColor:PMColor1];
    [rulerPumanUse setShadowBlur:0.9f];
    [rulerPumanUse setShadowOffset:CGSizeMake(0, 1)];
    [rulerPumanUse setShadowColor:[UIColor colorWithRed:0.593 green:0.619 blue:0.643 alpha:1.000]];
    [rulerPumanUse setLabelStrokeWidth:0.1f];
    [rulerPumanUse setleadingOfBottom:72];
    [rulerPumanUse setleadingOfTop:72];
    [rulerPumanUse setDelegate:self];
    [rulerPumanUse setDialRangeFrom:0 to:(int)([UserInfo sharedUserInfo].pumanQuan/10)+1];
    [rulerPumanUse setDialScrollRangeFrom:0 To:[UserInfo sharedUserInfo].pumanQuan];
    [rulerPumanUse setTheCurrentValue:0];
    [_content addSubview:rulerPumanUse];

}

- (void)setCurrentValue:(float)currentNumber andTheRuler:(RulerScrollView *)rulerScroll
{
    pumanUsed = currentNumber;
    [label_use setText:[NSString stringWithFormat:@"%0.1f",currentNumber]];
    float used_pumanQuan =  [UserInfo sharedUserInfo].pumanQuan - currentNumber;
    [noti_have setText:[NSString stringWithFormat:@"剩余：%0.1f",used_pumanQuan]];
    if (currentNumber == 0) {
        [_finishBtn setEnabled:NO];
        [_finishBtn setAlpha:0.5];
    }else{
        [_finishBtn setEnabled:YES];
        [_finishBtn setAlpha:1];
        
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setVerticalFrame
{
    if (showed) {
        [bgView setAlpha:0.3];
        [bgView setFrame:CGRectMake(0, 0, 768, 1024)];
        self.view.frame = CGRectMake(0, 0, 768, 1024);
        [_content setFrame:CGRectMake(32, 704, 704, 608)];
    }else{
        
        [bgView setFrame:CGRectMake(0, 0, 768, 1024)];
        self.view.frame = CGRectMake(0, 976, 768, 1024);
        [_content setFrame:CGRectMake(32, 0, 704, 608)];
        [bgView setAlpha:0];
    }
   
    
    
}

- (void)setHorizontalFrame
{
   
    if (showed) {
        [bgView setAlpha:0.3];
        [bgView setFrame:CGRectMake(0, 0, 1024, 768)];
        self.view.frame = CGRectMake(0, 0, 1024, 768);
        [_content setFrame:CGRectMake(160, 448, 704, 608)];
    }else{
       
        [bgView setFrame:CGRectMake(0, 0, 1024, 768)];
        self.view.frame = CGRectMake(0, 720, 1024, 768);
        [_content setFrame:CGRectMake(160, 0, 704, 608)];
         [bgView setAlpha:0];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showPuumanShopView
{
    showed = YES;
    [showBtn setEnabled:NO];

    if ([MainTabBarController sharedMainViewController].isVertical) {
        [bgView setFrame:CGRectMake(0, 0, 768, 1024)];
        self.view.frame = CGRectMake(0, 0, 768, 1024);
        SetViewLeftUp(_content, 32, 976);
        [UIView animateWithDuration:0.5 animations:^{
             SetViewLeftUp(_content, 32, 704);
            [showBtn setAlpha:0];
            [bgView setAlpha:0.3];
        }];
    }else{
        [bgView setFrame:CGRectMake(0, 0, 1024, 768)];
        self.view.frame = CGRectMake(0, 0, 1024, 768);
        SetViewLeftUp(_content, 160, 720);
        [UIView animateWithDuration:0.5 animations:^{
             SetViewLeftUp(_content, 160, 448);
             [showBtn setAlpha:0];
             [bgView setAlpha:0.3];
        }];
    }

    
    
    
}

- (void)closeBtnPressed
{
    showed = NO;
    [showBtn setEnabled:YES];
    
    if ([MainTabBarController sharedMainViewController].isVertical) {
        
        
        [UIView animateWithDuration:0.5 animations:^{
            SetViewLeftUp(_content, 32, 976);
            [showBtn setAlpha:1];
            [bgView setAlpha:0];
        }completion:^(BOOL finished) {
            SetViewLeftUp(_content, 32, 0);
            [bgView setFrame:CGRectMake(0, 0, 768, 1024)];
            self.view.frame = CGRectMake(0, 976, 768, 1024);
        }];
    }else{
        
        
        [UIView animateWithDuration:0.5 animations:^{
            SetViewLeftUp(_content, 160, 720);
            [showBtn setAlpha:1];
            [bgView setAlpha:0];

        }completion:^(BOOL finished) {
            SetViewLeftUp(_content, 160, 0);
            [bgView setFrame:CGRectMake(0, 0, 1024, 768)];
            self.view.frame = CGRectMake(0, 720, 1024, 768);
        }];
    }

}

- (void)finishBtnPressed
{
    if ([[[UserInfo sharedUserInfo] alipayAccount] isEqualToString:@""] ||![[UserInfo sharedUserInfo] alipayAccount]) {

        BindAlpayViewController *bindVC = [[BindAlpayViewController alloc] initWithNibName:nil bundle:nil];
        [bindVC setControlBtnType:kOnlyCloseButton];
        [bindVC setTitle:@"绑定支付宝" withIcon:nil];
        [self.view addSubview:bindVC.view];
        [bindVC show];
    }else{
        [self paid];
    }
 
}



- (void)hidden
{
    [UIView animateWithDuration:0.4 animations:^{
        [bgView setAlpha:0];
    }];
    [_content hiddenOutTo:kAFAnimationBottom inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:@selector(finishOut)];
}

- (void)finishOut
{
    [super dismiss];
   
    [self.view removeFromSuperview];
}

- (void)showPuumanShop
{

    [bgView setAlpha:0];
    [showBtn setAlpha:1];
    if ([MainTabBarController sharedMainViewController].isVertical) {
        
        SetViewLeftUp(_content, 32, 48);
        [UIView animateWithDuration:0.5 animations:^{
            SetViewLeftUp(_content, 32, 0);
 
        }];
        
    }else{
            SetViewLeftUp(_content, 160, 48);
        [UIView animateWithDuration:0.5 animations:^{
            SetViewLeftUp(_content, 160, 0);

        }];
    }
}




-(void)paid
{
    PostNotification(Noti_ShowHud, @"提交中...");
    
    ASIFormDataRequest* request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kUrl_SubmitPayback]];
    [request setDelegate:self];
    [request setTimeOutSeconds:10];
    [request setPostValue:[MobClick getConfigParams:umeng_onlineConfig_authKey] forKey:@"authCode"];
    [request setPostValue:[NSNumber numberWithInteger:[UserInfo sharedUserInfo].UID] forKey:@"UID"];
    [request setPostValue:[NSNumber numberWithInteger:_wid] forKey:@"WID"];
    [request setPostValue:[NSNumber numberWithDouble:pumanUsed] forKey:@"VOL"];
    [request setPostValue:@"no" forKey:@"AliChange"];
    [request setPostValue:_shop forKey:@"Shop"];
    [request startAsynchronous];
    
}

#pragma mark - ASIHTTPRequest Delegate

- (void) requestFailed:(ASIHTTPRequest *)request
{
    [ErrorLog requestFailedLog:request fromFile:@"PayBackViewController.m"];
    NSLog(@"\nResponse:%@\nError:%@", [request responseString], [request error]);
    PostNotification(Noti_HideHud, nil);
    [CustomAlertViewController showAlertWithTitle:@"您的网络存在故障，这次没法用扑满币了诶.." confirmRightHandler:^{
        
    }];
    [self.delegate popViewfinished];
    [self hidden];
}

- (void) requestFinished:(ASIHTTPRequest *)request
{
    NSString* res = [request responseString];
    NSRange range = [res rangeOfString:_puman_feedback_identifier_prefix];
    if( range.length == 0  ){
        [self requestFailed:request];
        return;
    }
    //res = [res substringFromIndex:(range.location+range.length)];
    [CustomAlertViewController showAlertWithTitle:@"已经成功收到您的请求，我们会在订单确认后汇款到您的支付宝帐户内。敬请查收" confirmRightHandler:^{
        
    }];
    [[UserInfo sharedUserInfo] updateUserInfo];
    PostNotification(Noti_HideHud, nil);
    [self.delegate popViewfinished];
    [self hidden];
}


- (void)beginScrollwithRuler:(RulerScrollView *)rulerScroll
{

}


@end
