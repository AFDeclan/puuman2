//
//  ShopWebViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-30.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "PopViewController.h"
#import "Ware.h"
#import "AFTextImgButton.h"
#import "AFImageView.h"
#import "ColorButton.h"
#import "AFTextImgButton.h"
#import "PuumanShopViewController.h"

@protocol WebViewDelegate;
@interface ShopWebViewController : PopViewController<UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIButton *_closeBtn;
    AFTextImgButton *otherShopButton;
    UIImageView *icon_shoptri;
    AFTextImgButton *backButton;
    AFTextImgButton *forwardButton;
    AFImageView *shopImg;
    AFTextImgButton *reloadButton;
    ColorButton *shareBtn;
    ColorButton *addBtn;
    UITableView *_shopsTableView;
    Ware *_ware;
    UIWebView *myWebView;
    NSArray *_shopsInfo;
    NSInteger _shopIndex;
    UIView *bg_content;
    BOOL _expanded;
    UILabel * _lowPriceLabel;
    UILabel * _highPriceLabel;
    UILabel * _wName;
    UIView *maskWeb;
    UIView *bg_progress;
    UIView *_progress;
    UIImageView *pointImgView;
    UILabel *noti_Price;
    UILabel *noti_Name;
    UIActivityIndicatorView *activityIndicatorView;
    BOOL recShop;
    NSString *_recShopName;
     NSTimer *_timer;
    PuumanShopViewController *puumanVC;
}
@property(assign,nonatomic)id<WebViewDelegate> delegate;
- (void)show;
- (void)setWare:(Ware *)ware shops:(NSArray *)shopsInfo firstIndex:(NSInteger)index;
- (void)setRecWebUrl:(NSString *)urlString  wareName:(NSString *)wName wareId:(NSInteger)WID warePrice:(CGFloat)price shopName:(NSString *)sName shopIndex:(NSInteger)shopIndex imgLink:(NSString *)picLink;
@end
@protocol WebViewDelegate <NSObject>

@optional
- (void)cartStatusUpdate;
@end


