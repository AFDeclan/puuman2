//
//  PumanBookModel.h
//  puman
//
//  Created by 武纪昀 on 5/24/13.
//  Copyright (c) 2013 创始人团队. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PumanRequest.h"
#import "UserInfo.h"

#define kBookIDKey  @"bookID"
//对应服务器上的主键（入账为UTID,出账为PBID)
#define kBookBonusKey           @"bookBonus"
#define kBookTitleKey           @"bookTitle"
#define kBookDateKey            @"bookDate"

#define kBookPaidKey            @"bookPaid"
#define kBookStatusKey          @"bookStatus"
//0:付款确认中 1:退换货确认中 2:已完成 3:已取消

#define kBookUserIdentityKey    @"UserIdentity"
/*该账单用户和宝宝的关系
 值为 kUserIdentity_Father
 或   kUserIdentity_Mother
 （定义在UserInfo.h中）
*/

#define kUserDefaultKey_UserInBook    @"userInBook"
#define kUserDefaultKey_UserOutBook    @"userOutBook"


@interface PumanBookModel : NSObject<AFRequestDelegate>
{
    NSMutableArray *_inBooks,   //入账单
            *_outBooks;  //出账单
    double _inTotal, _outTotal;
    NSInteger _inMaxID, _outMaxID;
    NSInteger _bID;
}

@property (retain, readonly) NSArray *inBooks;
@property (retain, readonly) NSArray *outBooks;
@property (assign, readonly) double inTotal;
@property (assign, readonly) double outTotal;

+ (PumanBookModel *)bookModel;

- (void)initialize;

@end
