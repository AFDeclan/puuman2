//
//  TestShopViewController.h
//  PuumanForPhone
//
//  Created by Ra.（祁文龙） on 14-8-23.
//  Copyright (c) 2014年 Declan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestShopViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *myWebView;
    UIImageView *bg_topImageView;
    UIImageView *bg_rightImageView;
    UIView *contentShop;
}
@end
