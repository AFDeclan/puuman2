//
//  SettingViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-17.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "SettingViewController.h"
#import "ColorsAndFonts.h"
#import "AFTextImgButton.h"
#import "UniverseConstant.h"
#import "MainTabBarController.h"
#import <Reachability.h>
#import "NSString+VersionCompare.h"
#import "SettingBindViewController.h"
#import "SettingPassWordViewController.h"
#import "SettingAdviceViewController.h"

@interface SettingViewController ()

@end
static NSString *titles[3] = {@"账户安全",@"账户关联",@"建议"};
static NSString *titleIcons[3] = {@"icon_safe_set.png",@"icon_admin_set.png",@"icon_sug_set.png"};
static NSString *cellTitles[3][4] = {{@"修改手机&邮箱",@"修改密码"},{@"支付宝", @"新浪微博",@"QQ"},{@"发送评价",@"打分",@"帮助"}};

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)initialization
{
    canSelected = YES;
    [super initialization];
    [_content setBackgroundColor:PMColor6];
    settingTable = [[UITableView alloc] initWithFrame:CGRectMake(72, 0, 248, 608)];
    [settingTable setDelegate:self];
    [settingTable setDataSource:self];
    [settingTable setScrollEnabled:NO];
    [settingTable setShowsHorizontalScrollIndicator:NO];
    [settingTable setShowsVerticalScrollIndicator:NO];
    [settingTable setBackgroundColor:[UIColor clearColor]];
    [settingTable setSeparatorColor:[UIColor clearColor]];
    [settingTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_content addSubview:settingTable];
    
    backBtn = [[AFTextImgButton alloc] initWithFrame:CGRectMake(0, 0, 56, 48)];
    [backBtn setTitle:nil andImg:[UIImage imageNamed:@"btn_back_set.png"] andButtonType:kButtonTypeNine];
    [backBtn setBackgroundColor:[UIColor clearColor]];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:backBtn];
    updateBtn = [[ColorButton alloc] init];
    [updateBtn initWithTitle:@"检查更新" andButtonType:kGrayLeftUp];
    [updateBtn addTarget:self action:@selector(updateBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:updateBtn];
    
    logOut = [[ColorButton alloc] init];
    [logOut initWithTitle:@"注销登录" andButtonType:kRedLeftDown];
    [logOut addTarget:self action:@selector(logOutBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:logOut];
    
    versionLabel = [[UILabel  alloc] initWithFrame:CGRectMake(0, 608, 304, 30)];
    [versionLabel setTextColor:PMColor7];
    [versionLabel setFont:PMFont3];
    [versionLabel setBackgroundColor:[UIColor clearColor]];
    [versionLabel setTextAlignment:NSTextAlignmentRight];
    [_content addSubview:versionLabel];
    NSString* currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    [versionLabel setText:[NSString stringWithFormat:@"当前版本:%@",currentVersion]];
    if ([MainTabBarController sharedMainViewController].isVertical) {
        [self setVerticalFrame];
    }else{
        [self setHorizontalFrame];
    }
}

- (void)logOutBtnPressed
{
    [[UserInfo sharedUserInfo] logout];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)updateBtnPressed
{
    if ([[Reachability reachabilityForInternetConnection] isReachable])
    {
       // PostNotification(Noti_ShowHud, @"正在检查更新...");
        [ASIHTTPRequest setSessionCookies:nil];
        NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@", APPID]];
        ASIHTTPRequest* request = [[ASIHTTPRequest alloc] initWithURL:url];
        [request setTimeOutSeconds:5];
        [request setTag:1];
        [request setRequestMethod:@"GET"];
        [request startSynchronous];
       // PostNotification(Noti_HideHud, nil);
        if (request.error)
        {
            //PostNotification(Noti_ShowAlert, @"您当前的网络状态不佳，请在网络通畅的环境中再次尝试");
        }
        else
        {
            NSError* parseError = nil;
            id result =[[request responseData] objectFromJSONDataWithParseOptions:JKParseOptionStrict error:&parseError];
            
            if ( parseError )
            {
                [ErrorLog errorLog:@"JSON Error" fromFile:@"AppDelegate.m" error:parseError];
            }
            else
            {
                NSArray* appInfo = [NSArray arrayWithArray:[result objectForKey:@"results"]];
                NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
                [userDefault setValue:appInfo forKey:APPINFO];
                [userDefault synchronize];
                NSString* receivedVersion = @"";
                NSString* trackViewUrl = @"";
                for( id conf in appInfo ){
                    receivedVersion = [conf objectForKey:@"version"];
                    trackViewUrl = [conf objectForKey:@"trackViewUrl"];
                    break;
                }
                NSString* currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
                if( [currentVersion earlierThenVersion:receivedVersion] && ![currentVersion isEqualToString:@""])
                {
                   // NSString *hint = [NSString stringWithFormat:@"现在最新的版本是%@，当前您的版本是%@，请前往更新~", receivedVersion, currentVersion];
                   // [CustomAlertView showInView:nil content:hint confirmHandler:^{
                   //     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackViewUrl]];
                   // }];
                }
              //  else //[CustomAlertView showInView:nil content:@"当前已是最新版本~"];
            }
        }
    }
    else
    {
        PostNotification(Noti_ShowAlert, @"您当前的网络状态不佳，请在网络通畅的环境中再次尝试");
    }
    
}


- (void)setVerticalFrame
{
    [super setVerticalFrame];
    [_content setFrame:CGRectMake(0, 0, 320, 1024)];
    SetViewLeftUp(backBtn, 0, 952);
    SetViewLeftUp(updateBtn, 208, 938);
    SetViewLeftUp(logOut, 208, 978);
    
}

- (void)setHorizontalFrame
{
    [super setHorizontalFrame];
    [_content setFrame:CGRectMake(0, 0, 320, 768)];
    SetViewLeftUp(backBtn, 0, 696);
    SetViewLeftUp(updateBtn, 208, 682);
    SetViewLeftUp(logOut, 208, 722);
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 32;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identify = @"SettingTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 212, 64)];
        [title setTextColor:[UIColor whiteColor]];
        [title setBackgroundColor:[UIColor clearColor]];
        [title setFont:PMFont2];
        [title setTag:10];
        [cell.contentView addSubview:title];
        UIImageView *partLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 62, 248, 2)];
        [partLine setImage:[UIImage imageNamed:@"line_set.png"]];
        [cell.contentView addSubview:partLine];
    }

    UILabel *title =  (UILabel *)[cell viewWithTag:10];
    [title setText:cellTitles[indexPath.section][indexPath.row]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 248, 32)];
    
    AFTextImgButton *titleView = [[AFTextImgButton alloc] initWithFrame:CGRectMake(20, 0, 96, 32)];
    [titleView setTitle:titles[section] andImg:[UIImage imageNamed:titleIcons[section]] andButtonType:kButtonTypeEight];
    [titleView setTitleLabelColor:PMColor7];
    [titleView setEnabled:NO];
    [headView addSubview:titleView];
    UIImageView *partLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 248, 2)];
    [partLine setImage:[UIImage imageNamed:@"line_set.png"]];
    [headView addSubview:partLine];
    return headView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int section = [indexPath section];
    int row = [indexPath row];
    if (canSelected) {
        if (section == 0 ) {
            if (row == 0) {
                SettingBindViewController *bindCV = [[SettingBindViewController alloc] initWithNibName:nil bundle:nil];
                [self.view addSubview:bindCV.view];
                [bindCV setTitle:cellTitles[0][0] withIcon:nil];
                [bindCV setControlBtnType:kOnlyFinishButton];
                [bindCV show];
            }else{
                SettingPassWordViewController *psdCV = [[SettingPassWordViewController alloc] initWithNibName:nil bundle:nil];
                [self.view addSubview:psdCV.view];
                [psdCV setTitle:cellTitles[0][1] withIcon:nil];
                [psdCV setControlBtnType:kCloseAndFinishButton];
                [psdCV show];
            }
            
        }else if(section == 1){
            if (row == 0) {
                
            }else if (row == 1){
            
            }else{
            
            }
        
        }else {
            if (row == 0) {
                SettingAdviceViewController *adCV = [[SettingAdviceViewController alloc] initWithNibName:nil bundle:nil];
                [self.view addSubview:adCV.view];
                [adCV setTitle:cellTitles[2][0] withIcon:nil];
                [adCV setControlBtnType:kCloseAndFinishButton];
                [adCV show];
            }else if (row == 1){
                NSString* url = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", APPID];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
            }else{
                //跳转页面
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://puuman.cn/FAQ.html"]];

            }
        }
    }
}


- (void)back
{
    canSelected = NO;
    [UIView animateWithDuration:0.5 animations:^{
        SetViewLeftUp(_content, -320, 0);
         [bgView setAlpha:0];
    }completion:^(BOOL finished) {
        [super dismiss];
        [self.view removeFromSuperview];

    }];

}

- (void)show
{
    SetViewLeftUp(_content, -320, 0);
    canSelected = NO;
    [UIView animateWithDuration:0.5 animations:^{
        SetViewLeftUp(_content, 0, 0);
    }completion:^(BOOL finished) {
        canSelected = YES;
    }];
    [bgView setAlpha:0];
    [UIView animateWithDuration:0.4 animations:^{
        [bgView setAlpha:0.3];
    }];
    
}

@end
