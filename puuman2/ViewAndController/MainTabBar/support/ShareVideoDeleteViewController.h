//
//  ShareVideoDeleteViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-7-22.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomAlertViewController.h"
@protocol ShareVideoDeleteDelegate;

@interface ShareVideoDeleteViewController : CustomAlertViewController
{
    UILabel *saveLabel;
    UILabel *deleteLabel;
    UIButton *saveBtn;
    UIButton *deleteBtn;
}
@property(nonatomic,assign)id<ShareVideoDeleteDelegate> deleteDelegate;

@end

@protocol ShareVideoDeleteDelegate <NSObject>
@optional
- (void)saveShareVideo;
- (void)deleteShareVideo;
@end