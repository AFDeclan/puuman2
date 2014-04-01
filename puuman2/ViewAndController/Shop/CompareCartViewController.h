//
//  CompareCartViewController.h
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CustomPopViewController.h"
#import "AFImageView.h"
#import "ColorButton.h"
#import "Ware.h"

@interface CompareCartViewController : CustomPopViewController<UITableViewDelegate, UITableViewDataSource>
{
    AFImageView *first_ImgView;
    AFImageView *second_ImgView;
    UILabel *vs;
    UITableView *cartTable;
    UITableView *infoTable;
    ColorButton *first_winBtn;
    ColorButton *second_winBtn;
    Ware * firstWare;
    Ware * secondWare;
  
}

@end
