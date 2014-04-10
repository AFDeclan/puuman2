//
//  CartTableViewCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-3-30.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CartTableViewCell.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"
#import "CartModel.h"
#import "CustomNotiViewController.h"

@implementation CartTableViewCell
@synthesize  isCompare = _isCompare;
@synthesize unflod =_unflod;
@synthesize chooseToCompared = _chooseToCompared;
@synthesize delegate = _delegate;
@synthesize indexPath = _indexPath;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
               wareIndex = -1;
        _isCompare = NO;
        wareImg = [[AFImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        [wareImg getImage:@"" defaultImage:@"default_ware_image                                                                                                                           "];
        [self.contentView addSubview:wareImg];
        infoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(80, 0, 448, 80)];
        [infoScrollView setBackgroundColor:PMColor5];
        [infoScrollView setContentSize:CGSizeMake(528, 80)];
        [infoScrollView setDelegate:self];
        [infoScrollView setShowsHorizontalScrollIndicator:NO];
        [infoScrollView setShowsVerticalScrollIndicator:NO];
        [self.contentView addSubview:infoScrollView];
        
        wareName = [[UILabel alloc] initWithFrame:CGRectMake(12, 22, 428, 16)];
        wareName.backgroundColor = [UIColor clearColor];
        wareName.textColor = PMColor1;
        wareName.font = PMFont3;
        [infoScrollView addSubview:wareName];
        rmb_icon = [[UIImageView alloc] initWithFrame:CGRectMake(12, 48, 12, 12)];
        [rmb_icon setImage:[UIImage imageNamed:@"icon_rmb_shop.png"]];
        [infoScrollView addSubview:rmb_icon];

        
        warePrice= [[UILabel alloc] initWithFrame:CGRectMake(28, 46, 320, 24)];
        warePrice.backgroundColor = [UIColor clearColor];
        warePrice.textColor = PMColor6;
        warePrice.font = PMFont1;
        [infoScrollView addSubview:warePrice];
        
        wareTime= [[UILabel alloc] init];
        wareTime.backgroundColor = [UIColor clearColor];
        wareTime.textColor = PMColor3;
        wareTime.font = PMFont4;
        [infoScrollView addSubview:wareTime];
        
        wareShop= [[UILabel alloc] initWithFrame:CGRectMake(352, 48, 80, 10)];
        wareShop.backgroundColor = [UIColor clearColor];
        wareShop.textColor = PMColor3;
        wareShop.font = PMFont4;
        [wareShop setTextAlignment:NSTextAlignmentRight];
        [infoScrollView addSubview:wareShop];
        
        delBtn = [[AFTextImgButton alloc] initWithFrame:CGRectMake(448, 0, 80, 80)];
        [delBtn setTitle:@"" andImg:[UIImage imageNamed:@"icon_delete_shop.png"] andButtonType:kButtonTypeOne];
        [delBtn setIconFrame:CGRectMake(0, 0, 36, 36)];
        [delBtn addTarget:self action:@selector(delBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        [delBtn setBackgroundColor:[UIColor redColor]];
        [infoScrollView addSubview:delBtn];
        time_icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        [time_icon setImage:[UIImage imageNamed:@"icon_time_shop.png"]];
        [infoScrollView addSubview:time_icon];
        
        bg_compareSelected = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 528,80)];
        [bg_compareSelected setBackgroundColor:[UIColor blackColor]];
        [bg_compareSelected setAlpha:0];
        [infoScrollView addSubview:bg_compareSelected];
        
        selectedFlag = [[UIImageView alloc] initWithFrame:CGRectMake(468, 16, 48, 48)];
        [selectedFlag setImage:[UIImage imageNamed:@"icon_check_shop.png"]];
        [self.contentView addSubview:selectedFlag];
        [selectedFlag setAlpha:0];
        [MyNotiCenter addObserver:self selector:@selector(unFoldAtIndex:) name:Noti_UnFoldCartWare object:nil];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedWare)];
        [infoScrollView addGestureRecognizer:tap];
        [self initFlags];
        
        
    }
    return self;
}

- (void)initFlags
{
    for (int i = 0; i <5; i++) {
        flag[i] = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_flag_shop.png"]];
        [flag[i] setFrame:CGRectMake(500 - 16*i, 0, 16, 16)];
        [self.contentView addSubview:flag[i]];
        [flag[i] setAlpha:0];

    }
}




- (void)selectedWare
{
  
    [_delegate tableView:nil didSelectRowAtIndexPath:_indexPath];
}

- (void)setTimeIconLocation
{

    CGSize size = [wareTime.text sizeWithFont:PMFont4];
    [wareTime setFrame:CGRectMake(432-size.width, 64, size.width, size.height)];
    SetViewLeftUp(time_icon, 64, wareTime.frame.origin.x-14);
    
}


- (void)buildCellWithPaid:(BOOL)paid andWareIndex:(NSInteger)index
{
    wareIndex = index;
    isPaid = paid;
    if (paid) {
        [rmb_icon setAlpha:0];
        Ware* w;
        NSDate* d;
        
        w = [[CartModel sharedCart] getDoneWareAtIndex:index];
        d = [[CartModel sharedCart] getDoneTimeAtIndex:index];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comps ;
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |  NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        if( d == nil )
            d = [NSDate date];
        comps = [calendar components:unitFlags fromDate:d];
        if( w != nil ){
            NSString *mm = nil, *dd = nil;
            if( [comps month] < 10 )
                mm = [NSString stringWithFormat:@"0%1d", [comps month]];
            else
                mm = [NSString stringWithFormat:@"%d", [comps month]];
            
            if( [comps day] < 10 )
                dd = [NSString stringWithFormat:@"0%1d", [comps day]];
            else
                dd = [NSString stringWithFormat:@"%d", [comps day]];
            NSString* wt = [NSString stringWithFormat:@"%4d-%@-%@",
                            [comps year], mm, dd];
            [self setWare:w  wareTime:wt ];
        }

    }else{
        [rmb_icon setAlpha:1];
        Ware* w;
        NSDate* d;
        NSInteger flags;
        
        w = [[CartModel sharedCart] getUndoWareAtIndex:index];
        d = [[CartModel sharedCart] getUndoTimeAtIndex:index];
       
        
        flags = [[CartModel sharedCart] flagAtIndex:index];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comps ;
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |  NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        if( d == nil )
            d = [NSDate date];
        comps = [calendar components:unitFlags fromDate:d];
        if( w != nil ){
            NSString *mm = nil, *dd = nil;
            if( [comps month] < 10 )
                mm = [NSString stringWithFormat:@"0%1d", [comps month]];
            else
                mm = [NSString stringWithFormat:@"%d", [comps month]];
            
            if( [comps day] < 10 )
                dd = [NSString stringWithFormat:@"0%1d", [comps day]];
            else
                dd = [NSString stringWithFormat:@"%d", [comps day]];
            NSString* wt = [NSString stringWithFormat:@"%4d-%@-%@",
                            [comps year], mm, dd];
            [self buildCellWithWare:w  flagCount:flags wareTime:wt ];
        }
    }
}


- (void)setWare:(Ware *)ware  wareTime:(NSString *)wt
{
    [infoScrollView setScrollEnabled:NO];
    [warePrice setAlpha:0];
    [wareShop setAlpha:1];
    _ware = ware;
    [wareName setText:ware.WName];
    [wareTime setText:wt];
    [self setTimeIconLocation];
    wareShop.text = ware.WShop;
    [wareImg getImage:ware.WPicLink defaultImage:default_ware_image];
    

}

- (void)buildCellWithWare:(Ware *)ware  flagCount:(NSInteger)flagCount wareTime:(NSString *)wt
{
    [infoScrollView setScrollEnabled:YES];
    [warePrice setAlpha:1];
    [wareShop setAlpha:0];
    _ware = ware;
    wareName.text = ware.WName;
    warePrice.text = [NSString stringWithFormat:@"%.2f~%.2f", ware.WPriceLB, ware.WPriceUB];
    wareTime.text = wt;
    [self setTimeIconLocation];
    [wareImg getImage:ware.WPicLink defaultImage:default_ware_image];
    
    for (int i = 0; i <5; i ++) {
        if (i < flagCount) {
            [flag[i] setAlpha:1];
        }else{
            [flag[i] setAlpha:0];
        }
    }
    
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{


    float x = scrollView.contentOffset.x;
    if (x>=80) {
        _unflod = YES;
       PostNotification(Noti_UnFoldCartWare, [NSNumber numberWithInteger:wareIndex]);
        scrollView.pagingEnabled=NO;
        if (x>=160) {
            scrollView.contentOffset=CGPointMake(160, 0);
        }
        
    }else if (x<0) {
        scrollView.pagingEnabled=NO;
        
        if (x<-80) {
            scrollView.contentOffset=CGPointMake(-80, 0);
        }
        
    }else
    {
        scrollView.pagingEnabled=YES;
       
    }
    
}

- (void)delBtnPressed
{
    [MobClick event:umeng_event_click label:@"Delete_ShopInfoLeftCell"];
    [[CartModel sharedCart] deleteWareFromCart:_ware.WID];
    [CustomNotiViewController showNotiWithTitle:@"删除成功" withTypeStyle:kNotiTypeStyleRight];
    PostNotification(Noti_RefreshCartWare, nil);
   
}

- (void)setChooseToCompared:(BOOL)chooseToCompared
{
    _chooseToCompared = chooseToCompared;
    if (chooseToCompared) {
        [selectedFlag setAlpha:1];
        [bg_compareSelected setAlpha:0.5];
    }else{
        [selectedFlag setAlpha:0];
        [bg_compareSelected setAlpha:0];
    }
}

- (void)setIsCompare:(BOOL)isCompare
{
    _isCompare = isCompare;
    if (isCompare) {
        [infoScrollView setScrollEnabled:NO];
    }else{
        [infoScrollView setScrollEnabled:YES];
    }
}

- (void)setUnflod:(BOOL)unflod
{
    if (unflod) {
        [infoScrollView setContentOffset:CGPointMake(79, 0)];
        infoScrollView.pagingEnabled=YES;
    }else{
        [infoScrollView setContentOffset:CGPointMake(0, 0)];
    }
}

- (void)unFoldAtIndex:(NSNotification *)notification
{
    
    if (_unflod) {
        if ( wareIndex !=  [[notification object] integerValue]) {

            [delBtn setEnabled:NO];
            [UIView animateWithDuration:0.7
                             animations:^{
                                 infoScrollView.contentOffset=CGPointMake(0, 0);
                             }completion:^(BOOL finished) {
                                 [delBtn setEnabled:YES];
                                 
                             } ];

        
        }
       
    }
    
}





@end
