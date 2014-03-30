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
#import "AFSelecedTextImgButton.h"


@interface ShopWebViewController : PopViewController<UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIButton *_closeBtn;
    AFTextImgButton *otherShopButton;
    UIImageView *icon_shoptri;
    AFSelecedTextImgButton *backButton;
    AFSelecedTextImgButton *forwardButton;
    AFImageView *shopImg;
    AFTextImgButton *reloadButton;
    ColorButton *shareBtn;
    ColorButton *addBtn;
    UITableView *_shopsTableView;
     Ware *_ware;
     UIWebView *myWebView;
     NSArray *_shopsInfo;
     NSInteger shopIndex;
    UIView *bg_content;
    
}
- (void)show;
- (void)setWare:(Ware *)ware shops:(NSArray *)shopsInfo firstIndex:(NSInteger)index;

@end
