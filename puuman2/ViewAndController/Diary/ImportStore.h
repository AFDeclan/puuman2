//
//  ImportStore.h
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-2-25.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Diary.h"

@interface ImportStore : NSObject
{
    NSMutableArray *photosArr;
    NSString *title;
    NSInteger *progress;
   // NSDictionary *diaryInfo;
    Diary *diary;
    
}

+(ImportStore *)shareImportStore;
-(void)initWithImportData:(NSDictionary *)dataDic;
- (void)addNewDiary;
- (void)reset;
@end
