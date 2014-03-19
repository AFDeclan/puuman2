//
//  JoinView.m
//  puman
//
//  Created by 祁文龙 on 13-11-14.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import "JoinView.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "ColorsAndFonts.h"
#import "ErrorLog.h"
#import <Reachability.h>
#import "UserInfo.h"
#import "ErrorLog.h"


static JoinView * instance;
@implementation JoinView
+ (JoinView *)sharedJoinView;
{
    if (!instance)
        instance = [[JoinView alloc] initWithFrame:CGRectMake(0, 0, 240, 304)];
    
    return instance;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
     
    }
    return self;
}
- (void)initialization
{
    weatherImg = [[UIImageView alloc] initWithFrame:CGRectMake(16, 8, 48, 48)];
    [self addSubview:weatherImg];
    temperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(72, 40, 48, 16)];
    [temperatureLabel setFont:PMFont2];
    [temperatureLabel setTextColor:PMColor6];
    [temperatureLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:temperatureLabel];
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(136, 16, 96, 16)];
    [dateLabel setTextAlignment:NSTextAlignmentLeft];
    [dateLabel setFont:PMFont2];
    [dateLabel setTextColor:PMColor6];
    [dateLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:dateLabel];
    contentView =[[UIView alloc] initWithFrame:CGRectMake(0,64, 240, 240)];
    [self addSubview:contentView];
    [self setWeather];
    [self refreshStaus];

}
- (void)resign
{
   if(invite)
   {
       [invite resign];
   }
}
- (void)refreshStaus
{
    
    switch ([UserInfo sharedUserInfo].inviteState) {
        case noInvite:
            [self initInviteView];
            break;
        case waitForAccept:
            [self initWaitView];
            break;
        case done:
            [self initDynamicView];
            break;
        default:
            break;
    }

}
- (void)initInviteView
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         [contentView setAlpha:0];
                     }];
    for (UIView *view in [contentView subviews]) {
        [view removeFromSuperview];
    }
    invite = [[InviteView alloc] initWithFrame:CGRectMake(0, 0, 240, 240)];
    [contentView addSubview:invite];
    [UIView animateWithDuration:0.5
                     animations:^{
                         [contentView setAlpha:1];
                     }];
}
- (void)initWaitView
{  [UIView animateWithDuration:0.5
                    animations:^{
                        [contentView setAlpha:0];
                    }];
    for (UIView *view in [contentView subviews]) {
        [view removeFromSuperview];
    }
    WaitView *wait = [[WaitView alloc] initWithFrame:CGRectMake(0, 0, 240, 240)];
    [contentView addSubview:wait];
    [UIView animateWithDuration:0.5
                     animations:^{
                         [contentView setAlpha:1];
                     }];
}
-(void)initDynamicView
{  [UIView animateWithDuration:0.5
                    animations:^{
                        [contentView setAlpha:0];
                    }];
    for (UIView *view in [contentView subviews]) {
        [view removeFromSuperview];
    }
    DynamicView *dynamic = [[DynamicView alloc] initWithFrame:CGRectMake(0, 0, 240, 240)];
    [contentView addSubview:dynamic];
    [UIView animateWithDuration:0.5
                     animations:^{
                         [contentView setAlpha:1];
                     }];
    
}
- (void)setWeather
{
  
    
    if (![[Reachability reachabilityForInternetConnection] isReachable])
        return;
    //解析网址通过ip 获取城市天气代码
    NSURL *url = [NSURL URLWithString:@"http://61.4.185.48:81/g/"];
//    ASIHTTPRequest *request1 = [ASIHTTPRequest requestWithURL:url];
//    request1.timeOutSeconds = 15;
//    [request1 startSynchronous];
    ASIFormDataRequest *form = [[ASIFormDataRequest alloc] initWithURL:url];
    form.timeOutSeconds = 15;
    [form setDidFailSelector:@selector(failRequest:)];
    [form setDidFinishSelector:@selector(finishRequest:)];
    form.delegate = self;
    [form startAsynchronous];
    
    
   
}
- (void)failRequest:(ASIFormDataRequest *)form
{
    
    [ErrorLog requestFailedLog:form fromFile:@"JoinView"];
}
- (void)finishRequest:(ASIFormDataRequest *)form
{
    NSString *jsonString = [form responseString];
    if ([jsonString isEqualToString:@""])
    {

        [ErrorLog requestFailedLog:form fromFile:@"JoinView.m"];
        NSLog(@"获取位置失败！");
        return;
    }
    //    NSLog(@"------------%@",jsonString);
    
    // 得到城市代码字符串，截取出城市代码
    NSString *Str;
    for (int i = 0; i<=[jsonString length]; i++)
    {
        for (int j = i+1; j <=[jsonString length]; j++)
        {
            Str = [jsonString substringWithRange:NSMakeRange(i, j-i)];
            if ([Str isEqualToString:@"id"]) {
                if (![[jsonString substringWithRange:NSMakeRange(i+3, 1)] isEqualToString:@"c"]) {
                    intString = [jsonString substringWithRange:NSMakeRange(i+3, 9)];
                    
                }
            }
        }
    }
    
    //中国天气网解析地址；
    NSString *path=@"http://m.weather.com.cn/data/cityNumber.html";
    //将城市代码替换到天气解析网址cityNumber 部分！
    path=[path stringByReplacingOccurrencesOfString:@"cityNumber" withString:intString];
    
//    NSLog(@"path:%@",path);
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:path]];
    
    request.delegate = self;
    [request startAsynchronous];
    

}


- (void)requestStarted:(ASIHTTPRequest *)request
{
//    NSLog(@"请求开始了");
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
//    NSLog(@"请求结束了");
    //responseString就是response响应的正文内容.(即网页的源代码)
    NSString *str = request.responseString;
//    NSLog(@"str is ---> %@",str);
    NSError* parseError = nil;
    NSDictionary *dic = [[str dataUsingEncoding:NSUTF8StringEncoding] objectFromJSONDataWithParseOptions:JKParseOptionStrict error:&parseError];
    
    NSDictionary *weatherinfo = [dic objectForKey:@"weatherinfo"];
//    NSLog(@"weatherinfo  =  %@",weatherinfo);
    
    //当前城市
  //  NSString *city = [weatherinfo objectForKey:@"city"];
    //cityLabel.text = city;
    //日期
    NSString *date = [weatherinfo objectForKey:@"date_y"];
    [self initDateWithDate:date];
    //星期
 ///   NSString *week = [weatherinfo objectForKey:@"week"];
  //  weekLabel.text = week;
    //城市天气编码
 //   NSString *cityid = [weatherinfo objectForKey:@"cityid"];
 //   cityidLabel.text = cityid;
    //当前温度
    NSString *temp = [weatherinfo objectForKey:@"temp1"];
    [self initTempWithTmep:temp];
    //当前天气状况
    NSString *weather = [weatherinfo objectForKey:@"weather1"];
    [self initWeatherImgWithWeather:weather];
    
    //更多细节请参考 输出框自己添加！
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [ErrorLog requestFailedLog:request fromFile:@"JoinView.m"];
   //    NSLog(@"请求失败了");
}
- (void)initDateWithDate:(NSString *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY/M/d";
    NSString *date_str = [dateFormatter stringFromDate:[NSDate date]];
    [dateLabel setText:date_str];
    CGSize size = [date sizeWithFont:PMFont2];
    CGRect frame = dateLabel.frame;
    frame.size =size;
    [dateLabel setFrame:frame];
}
- (void)initTempWithTmep:(NSString *)temp
{
    [temperatureLabel setText:temp];
    CGSize size = [temp sizeWithFont:PMFont2];
    CGRect frame = temperatureLabel.frame;
    frame.size =size;
    [temperatureLabel setFrame:frame];
}
- (void)initWeatherImgWithWeather:(NSString *)strWeather
{
   NSString *fileName;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"H";
    NSString *date_str = [dateFormatter stringFromDate:[NSDate date]];
    int hour = [date_str intValue];
  
    
 
    if(NSNotFound != [strWeather rangeOfString:@"晴"].location)
    {
        if (hour <18 && hour >6) {
            fileName = @"icon1_weather_diary.png";
        }else{
           fileName = @"icon7_weather_diary.png";
        }
        
    }
    if(NSNotFound != [strWeather rangeOfString:@"多云"].location)
    {
        
        if (hour <18 && hour >6) {
          fileName = @"icon16_weather_diary.png";
        }else{
            fileName = @"icon6_weather_diary.png";
        }
    }
    if(NSNotFound != [strWeather rangeOfString:@"阴"].location)
    {  if (hour <18 && hour >6) {
         fileName =@"icon18_weather_diary.png";
    }else{
        fileName = @"icon6_weather_diary.png";
    }
        
    }
    if(NSNotFound != [strWeather rangeOfString:@"雷"].location)
    {
        fileName =@"icon15_weather_diary.png";
    }
    if(NSNotFound != [strWeather rangeOfString:@"阵雨"].location)
    {
        fileName =@"icon13_weather_diary.png";
    }
    if(NSNotFound != [strWeather rangeOfString:@"雷阵雨"].location)
    {
        fileName = @"icon14_weather_diary.png";
    }
 
    if(NSNotFound != [strWeather rangeOfString:@"雨"].location)
    {
        fileName =@"icon12_weather_diary.png";
    }
    if(NSNotFound != [strWeather rangeOfString:@"小雨"].location)
    {
        fileName = @"icon12_weather_diary.png";
    }
    if(NSNotFound != [strWeather rangeOfString:@"中雨"].location)
    {
        fileName = @"icon12_weather_diary.png";
    }
    if(NSNotFound != [strWeather rangeOfString:@"大雨"].location)
    {
        fileName =@"icon11_weather_diary.png";
    }
    if(NSNotFound != [strWeather rangeOfString:@"暴雨"].location)
    {
        fileName =@"icon11_weather_diary.png";
    }
    if(NSNotFound != [strWeather rangeOfString:@"雪"].location)
    {
        fileName =@"icon10_weather_diary.png";
    }
    if(NSNotFound != [strWeather rangeOfString:@"雨加雪"].location)
    {
        fileName =@"icon8_weather_diary.png";
    }
    if(NSNotFound != [strWeather rangeOfString:@"小雪"].location)
    {
        fileName = @"icon10_weather_diary.png";
    }
    if(NSNotFound != [strWeather rangeOfString:@"中雪"].location)
    {
        fileName = @"icon9_weather_diary.png";
    }
    if(NSNotFound != [strWeather rangeOfString:@"大雪"].location)
    {
        fileName = @"icon9_weather_diary.png";
    }
    if(NSNotFound != [strWeather rangeOfString:@"暴雪"].location)
    {
        fileName = @"icon9_weather_diary.png";
    }
    if(NSNotFound != [strWeather rangeOfString:@"雾"].location)
    {
        fileName =@"icon2_weather_diary.png";
    }
    
    if(NSNotFound != [strWeather rangeOfString:@"阴转晴"].location)
    {
        if (hour <18 && hour >6) {
             fileName = @"icon17_weather_diary.png";
        }else{
            fileName = @"icon6_weather_diary.png";
        }
       
    }
    if(NSNotFound != [strWeather rangeOfString:@"多云转晴"].location)
    {
        if (hour <18 && hour >6) {
            fileName = @"icon16_weather_diary.png";
        }else{
            fileName = @"icon6_weather_diary.png";
        }
    }

    if(NSNotFound != [strWeather rangeOfString:@"尘"].location)
    {
        fileName = @"icon3_weather_diary.png";
    }
    if(NSNotFound != [strWeather rangeOfString:@"冰"].location)
    {
        fileName = @"icon5_weather_diary.png";
    }
    if(NSNotFound != [strWeather rangeOfString:@"冻雨"].location)
    {
        fileName = @"icon4_weather_diary.png";
    }
    [weatherImg setImage:[UIImage imageNamed:fileName]];

}


@end
