//
//  ToolsInfoView.m
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-6-20.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import "ToolsInfoView.h"
#import "UniverseConstant.h"
#import <Reachability.h>
#import <ASIFormDataRequest.h>
#import "UserNameCheck.h"
#import "UILabel+AdjustSize.h"
#import "JSONKit.h"

@implementation ToolsInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
        [self setBackgroundColor:PMColor5];
    }
    return self;
}

- (void)initialization
{
    _temperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(72, 120, 136, 20)];
    _temperatureLabel.backgroundColor = [UIColor clearColor];
    _temperatureLabel.font = PMFont2;
    _temperatureLabel.textColor = PMColor2;
    [self addSubview:_temperatureLabel];
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(72, 96, 136, 20)];
    _dateLabel.backgroundColor = [UIColor clearColor];
    _dateLabel.font = PMFont2;
    _dateLabel.textColor = PMColor6;
    [self addSubview:_dateLabel];
    _weatherImgView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 88, 48, 48)];
    [self addSubview:_weatherImgView];
    [self setWeather];
    [self setDate];

}

- (void)setWeather
{
    if (![[Reachability reachabilityForInternetConnection] isReachable])
        return;
    NSURL *url = [NSURL URLWithString:@"http://61.4.185.48:81/g/"];
    ASIFormDataRequest *form = [[ASIFormDataRequest alloc] initWithURL:url];
    form.timeOutSeconds = 15;
    [form setDidFailSelector:@selector(failRequest:)];
    [form setDidFinishSelector:@selector(finishRequest:)];
    form.delegate = self;
    [form startAsynchronous];
}
- (void)failRequest:(ASIFormDataRequest *)form
{
    [ErrorLog requestFailedLog:form fromFile:@"DynamicView"];
}
- (void)finishRequest:(ASIFormDataRequest *)form
{
    NSString *jsonString = [form responseString];
    if ([jsonString isEqualToString:@""])
    {
        [ErrorLog requestFailedLog:form fromFile:@"DynamicView.m"];
        return;
    }
    NSString *Str, *cityNumberStr;
    for (int i = 0; i<=[jsonString length]; i++)
    {
        for (int j = i+1; j <=[jsonString length]; j++)
        {
            Str = [jsonString substringWithRange:NSMakeRange(i, j-i)];
            if ([Str isEqualToString:@"id"]) {
                if (![[jsonString substringWithRange:NSMakeRange(i+3, 1)] isEqualToString:@"c"])
                {
                    cityNumberStr = [jsonString substringWithRange:NSMakeRange(i+3, 9)];
                }
            }
        }
        
    }
    

    NSString *path=@"http://www.weather.com.cn/data/cityinfo/cityNumber.html";
    path=[path stringByReplacingOccurrencesOfString:@"cityNumber" withString:cityNumberStr];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:path]];
    request.delegate = self;
    [request startAsynchronous];


    
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *str = request.responseString;
    NSError* parseError = nil;
    NSDictionary *dic = [[str dataUsingEncoding:NSUTF8StringEncoding] objectFromJSONDataWithParseOptions:JKParseOptionStrict error:&parseError];
    
    NSDictionary *weatherinfo = [dic objectForKey:@"weatherinfo"];
    NSString *temp1 = [weatherinfo objectForKey:@"temp1"];
    NSString *temp2 = [weatherinfo objectForKey:@"temp2"];
    if (temp1 &&temp2) {
        [_temperatureLabel setText:[NSString stringWithFormat:@"%@~%@",temp1,temp2]];

    }
    //当前天气状况
    NSString *weather = [weatherinfo objectForKey:@"weather"];
    if (weather) {
        [self setWeatherImg:weather];
    }

}

- (void)setDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY/M/d";
    NSString *date_str = [dateFormatter stringFromDate:[NSDate date]];
    [_dateLabel setText:date_str];
}

- (void)setWeatherImg:(NSString *)strWeather
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
    [_weatherImgView setImage:[UIImage imageNamed:fileName]];
}

@end
