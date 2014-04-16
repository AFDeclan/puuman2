//
//  InsuranceInfoViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-14.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PopViewController.h"
#import "AFNetwork.h"

@interface InsuranceInfoViewController : PopViewController<AFDataStoreDelegate>
{
    UIScrollView *_scrollView;
    UIImage *_infoImg;
    NSString *_url;
}

- (void)show;
- (void)setInfoUrl:(NSString *)url;
@end
