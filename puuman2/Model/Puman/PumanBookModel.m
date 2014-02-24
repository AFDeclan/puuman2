//
//  PumanBookModel.m
//  puman
//
//  Created by 武纪昀 on 5/24/13.
//  Copyright (c) 2013 创始人团队. All rights reserved.
//

#import "PumanBookModel.h"
#import "JSONKit.h"
#import "UniverseConstant.h"
#import "UserInfo.h"
#import "DiaryModel.h"
#import "ErrorLog.h"

static PumanBookModel *instance;

@implementation PumanBookModel

@synthesize inBooks = _inBooks;
@synthesize outBooks = _outBooks;
@synthesize inTotal = _inTotal;
@synthesize outTotal = _outTotal;

+ (PumanBookModel *)bookModel
{
    if (!instance)
    {
        instance = [[PumanBookModel alloc] init];
    }
    return instance;
}

- (void)initialize
{
    _bID = [UserInfo sharedUserInfo].BID;
    if (_bID == 0) return;
    NSString *userDefaultKey_inBook = [NSString stringWithFormat:@"%@%d", kUserDefaultKey_UserInBook, _bID];
    NSArray *inBooks = [[NSUserDefaults standardUserDefaults] valueForKey:userDefaultKey_inBook];
    _inBooks = [[NSMutableArray alloc] initWithArray:inBooks];
    NSString *userDefaultKey_outBook = [NSString stringWithFormat:@"%@%d", kUserDefaultKey_UserOutBook, _bID];
    NSArray *outBooks = [[NSUserDefaults standardUserDefaults] valueForKey:userDefaultKey_outBook];
    _outBooks = [[NSMutableArray alloc] initWithArray:outBooks];
    [self computeTotal];
    if ([[UserInfo sharedUserInfo] logined]) [self getBooksFromServer];
}

- (void)computeTotal
{
    double inTotal = 0, outTotal = 0;
    _inMaxID = 0;
    _outMaxID = 0;
    for (NSDictionary *book in _inBooks)
    {
        inTotal += [[book valueForKey:kBookBonusKey] doubleValue];
        NSInteger bID = [[book valueForKey:kBookIDKey] integerValue];
        if (bID > _inMaxID) _inMaxID = bID;
    }
    for (NSDictionary *book in _outBooks)
    {
        outTotal += [[book valueForKey:kBookBonusKey] doubleValue];
        NSInteger bID = [[book valueForKey:kBookIDKey] integerValue];
        if (bID > _outMaxID) _outMaxID = bID;
    }
    _inTotal = inTotal;
    _outTotal = outTotal;
}

- (void)saveInBooks
{
    NSString *userDefaultKey_inBook = [NSString stringWithFormat:@"%@%d", kUserDefaultKey_UserInBook, _bID];
    [[NSUserDefaults standardUserDefaults] setValue:_inBooks forKey:userDefaultKey_inBook];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)saveOutBooks
{
    NSString *userDefaultKey_inBook = [NSString stringWithFormat:@"%@%d", kUserDefaultKey_UserOutBook, _bID];
    NSMutableArray *oBooks = [[NSMutableArray alloc] init];
    for (NSDictionary *book in _outBooks)
    {
        NSInteger status = [[book valueForKey:kBookStatusKey] integerValue];
        if (status > 1) //已完成或已取消
        {
            [oBooks addObject:book];
        }
    }
    [[NSUserDefaults standardUserDefaults] setValue:oBooks forKey:userDefaultKey_inBook];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)getBooksFromServer
{
    [self getInBooksFromServer];
    [self getOutBooksFromServer];
}

- (void)getInBooksFromServer
{
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_GetCompletedTask;
    [request setTimeOutSeconds:20];
    [request setDelegate:self];
    [request setParam:[NSString stringWithFormat:@"%d", _bID] forKey:@"BID"];
    [request setParam:[NSString stringWithFormat:@"%d", _inMaxID] forKey:@"UTID_local"];
    request.tag = 0;
    request.resEncoding = PumanRequestRes_JsonEncoding;
    [request postAsynchronous];
}

- (void)getOutBooksFromServer
{
    PumanRequest *request = [[PumanRequest alloc] init];
    request.urlStr = kUrl_GetPayBack;
    [request setTimeOutSeconds:20];
    [request setDelegate:self];
    [request setParam:[NSString stringWithFormat:@"%d", _bID] forKey:@"BID"];
    [request setParam:[NSString stringWithFormat:@"%d", _outMaxID] forKey:@"PBID_local"];
    request.tag = 1;
    request.resEncoding = PumanRequestRes_JsonEncoding;
    [request postAsynchronous];
}

- (void)requestEnded:(AFBaseRequest *)afRequest
{
    NSDictionary *result = afRequest.resObj;
    if (result)
    {
        switch (afRequest.tag) {
            case 0:
                for (NSDictionary *item in result)
                {
                    NSString *bID = [item valueForKey:@"UTID"];
                    NSString *bonus = [item valueForKey:@"TBonus"];
                    NSString *dateTime = [item valueForKey:@"UTCreateTime"];
                    NSString *bDate = [[dateTime componentsSeparatedByString:@" "] objectAtIndex:0];
                    NSString *bTitle = [self titleForInBook:item];
                    NSString *identity = [item valueForKey:@"Identity"];
                    NSDictionary *book = [NSDictionary dictionaryWithObjectsAndKeys:bID, kBookIDKey,
                                          bTitle, kBookTitleKey,
                                          bonus, kBookBonusKey,
                                          bDate, kBookDateKey,
                                          identity, kBookUserIdentityKey,
                                          nil];
                    [_inBooks addObject:book];
                }
                [self computeTotal];
                [[NSNotificationCenter defaultCenter] postNotificationName:Noti_PumanInBookUpdated object:nil];
                [self saveInBooks];
                break;
            default:
                for (NSDictionary *item in result)
                {
                    NSString *bID = [item valueForKey:@"PBID"];
                    NSString *bonus = [item valueForKey:@"Vol"];
                    NSString *dateTime = [item valueForKey:@"CreateTime"];
                    NSString *bDate = [[dateTime componentsSeparatedByString:@" "] objectAtIndex:0];
                    NSString *bTitle = [item valueForKey:@"Shop"];
                    NSString *bStatus = [item valueForKey:@"Status"];
                    NSString *bPaid = [item valueForKey:@"Delt"];
                    NSString *identity = [item valueForKey:@"Identity"];
                    NSDictionary *book = [NSDictionary dictionaryWithObjectsAndKeys:bID,kBookIDKey,
                                          bTitle, kBookTitleKey,
                                          bonus, kBookBonusKey,
                                          bDate, kBookDateKey,
                                          bStatus, kBookStatusKey,
                                          bPaid, kBookPaidKey,
                                          identity, kBookUserIdentityKey,
                                          nil];
                    [_outBooks addObject:book];
                }
                [self computeTotal];
                [[NSNotificationCenter defaultCenter] postNotificationName:Noti_PumanOutBookUpdated object:nil];
                [self saveOutBooks];
                break;
        }
    }
}

- (NSString *)titleForInBook:(NSDictionary *)item
{
    NSString *bTitle = @"";
    NSInteger tid = [[item valueForKey:@"TID"] integerValue];
    NSString *type1 = [item valueForKey:@"type1"];
    NSString *type2 = [item valueForKey:@"type2"];
    if ([type1 isEqualToString:vType_Text])
    {
        if ([type2 isEqualToString:vType_Photo])
            bTitle = @"图文";
        else bTitle = @"文字";
    }
    else if ([type1 isEqualToString:vType_Photo])
    {
        if ([type2 isEqualToString:vType_Audio])
            bTitle = @"有声图";
        else bTitle = @"照片";
    }
    else if ([type1 isEqualToString:vType_Audio])
        bTitle = @"录音";
    else bTitle = @"视频";
    if (tid < 6)
        bTitle = @"新手任务";
    else if (tid == 6)
        bTitle = [bTitle stringByAppendingString:@"日记"];
    else bTitle = [bTitle stringByAppendingString:@"任务"];
    return bTitle;
}

@end
