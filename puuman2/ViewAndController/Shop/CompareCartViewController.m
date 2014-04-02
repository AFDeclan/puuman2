//
//  CompareCartViewController.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-4-1.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CompareCartViewController.h"
#import "CartModel.h"
#import "UniverseConstant.h"
#import "CompareInfoTableViewCell.h"

@interface CompareCartViewController ()

@end

@implementation CompareCartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        availableCarts = [[NSMutableDictionary alloc] init];
        _keyset = [[NSMutableSet alloc] init];
        _keys = [[NSMutableArray alloc] init];
        _propertyKeys = [[NSMutableArray alloc] init];
        [self initWithContent];
       
    }
    return self;
}

- (void)setCompareData
{
  
    for (NSString *key in firstWare.WMeta.allKeys)
    {
        if ([[key componentsSeparatedByString:@"|"] count] < 2) continue;
        NSInteger priority = [[[key componentsSeparatedByString:@"|"] objectAtIndex:0] integerValue];
        if (priority < 100) [_keyset addObject:key];
    }
    for (NSString *key in secondWare.WMeta.allKeys)
    {
        if ([[key componentsSeparatedByString:@"|"] count] < 2) continue;
        NSInteger priority = [[[key componentsSeparatedByString:@"|"] objectAtIndex:0] integerValue];
        if (priority < 100) [_keyset addObject:key];
    }
   
    for (NSString *key in _keyset)
    {
        [_keys addObject:key];
    }
    _sortedKeys = [_keys sortedArrayUsingComparator:^NSComparisonResult(id key1, id key2){
        NSInteger priority1 = [[[key1 componentsSeparatedByString:@"|"] objectAtIndex:0] integerValue];
        NSInteger priority2 = [[[key2 componentsSeparatedByString:@"|"] objectAtIndex:0] integerValue];
        if (priority1 < priority2) return NSOrderedAscending;
        else return NSOrderedDescending;
    }];
    
    for (int i = 0; i < [_sortedKeys count]; i++) {
        NSCharacterSet *characters = [[NSCharacterSet
                                       characterSetWithCharactersInString:[_sortedKeys objectAtIndex:i]]  invertedSet];
        NSRange userNameRange = [@"shoplink" rangeOfCharacterFromSet:characters];
        if (userNameRange.location != NSNotFound) {
            [_propertyKeys addObject:[_sortedKeys  objectAtIndex:i]];
        }
        
    }
    [infoTable reloadData];

}

- (void)initWithContent
{
  
    firstWare = nil;
    secondWare = nil;
    firstIndex = -1;
    secondIndex = -1;
    for (int i = 0; i < [[CartModel sharedCart] UndoCount]; i ++) {
        [availableCarts setObject:[NSNumber numberWithInt:i] forKey:[NSString stringWithFormat:@"%d",i]];
    }
    UIImageView *first_bg = [[UIImageView alloc] initWithFrame:CGRectMake(136, 112, 192, 192)];
    [first_bg setImage:[UIImage imageNamed:@"pic_com_shop.png"]];
    [_content addSubview:first_bg];
    
    
    UIImageView *second_bg = [[UIImageView alloc] initWithFrame:CGRectMake(376, 112, 192, 192)];
    [second_bg setImage:[UIImage imageNamed:@"pic_com_shop.png"]];
    [_content addSubview:second_bg];
    
    
    first_ImgView = [[AFImageView alloc] initWithFrame:CGRectMake(1, 1, 190, 190)];
    [first_bg addSubview:first_ImgView];
    second_ImgView = [[AFImageView alloc] initWithFrame:CGRectMake(1, 1, 190, 190)];
    [second_bg addSubview:second_ImgView];
    vs = [[UILabel alloc] initWithFrame:CGRectMake(328, 270, 48, 52)];
    [vs setTextColor:PMColor3];
    [vs setFont:PMFont(26)];
    [vs setBackgroundColor:[UIColor clearColor]];
    [vs setText:@"VS"];
    [vs setTextAlignment:NSTextAlignmentCenter];
    [_content addSubview:vs];
   
   
    bg_infoFirst = [[UIView alloc] initWithFrame:CGRectMake(136, 320, 192, 288)];
    [bg_infoFirst setAlpha:0];
    [bg_infoFirst setBackgroundColor:PMColor5];
    [_content addSubview:bg_infoFirst];
    bg_infoSecond = [[UIView alloc] initWithFrame:CGRectMake(376, 320, 192, 288)];
    [bg_infoSecond setAlpha:0];
    [bg_infoSecond setBackgroundColor:PMColor5];
    [_content addSubview:bg_infoSecond];

    
    cartTable = [[UITableView alloc] initWithFrame:CGRectMake(88, 320, 528, 288)];
    [cartTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [cartTable setShowsVerticalScrollIndicator:NO];
    [cartTable setDelegate:self];
    [cartTable setDataSource:self];
    [cartTable setBackgroundColor:[UIColor clearColor]];
    [cartTable setBounces:YES];
    [cartTable setAlpha:1];
    [_content addSubview:cartTable];
    
    
   
    
    
    info_firstWareName = [[AnimateShowLabel alloc] initWithFrame:CGRectMake(160, 320, 144, 16)];
    [info_firstWareName setBackgroundColor:[UIColor clearColor]];
    [_content addSubview:info_firstWareName];
    info_secondWareName = [[AnimateShowLabel alloc] initWithFrame:CGRectMake(400, 320, 144, 16)];
    [info_secondWareName setBackgroundColor:[UIColor clearColor]];
    [_content addSubview:info_secondWareName];
    info_firstWarePrice = [[AnimateShowLabel alloc] initWithFrame:CGRectMake(160, 344, 144, 24)];
    [info_firstWarePrice setBackgroundColor:[UIColor clearColor]];
    [_content addSubview:info_firstWarePrice];
    info_secondWarePrice = [[AnimateShowLabel alloc] initWithFrame:CGRectMake(400, 344, 144, 24)];
    [info_secondWarePrice setBackgroundColor:[UIColor clearColor]];
    [_content addSubview:info_secondWarePrice];
    
    [info_firstWareName setAlpha:0];
    [info_firstWarePrice setAlpha:0];
    [info_secondWareName setAlpha:0];
    [info_secondWarePrice setAlpha:0];
    
    infoTable = [[UITableView alloc] initWithFrame:CGRectMake(136, 400, 432, 208)];
    [infoTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [infoTable setShowsVerticalScrollIndicator:NO];
    [infoTable setDelegate:self];
    [infoTable setDataSource:self];
    [infoTable setBackgroundColor:[UIColor clearColor]];
    [infoTable setBounces:YES];
    [_content addSubview:infoTable];
    [infoTable setAlpha:0];
    
    first_winBtn = [[ColorButton alloc] init];
    [first_winBtn  initWithTitle:@"胜出" andButtonType:kBlueRight];
    [first_winBtn addTarget:self action:@selector(firstWin) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:first_winBtn];
    second_winBtn = [[ColorButton alloc] init];
    [second_winBtn  initWithTitle:@"胜出" andButtonType:kBlueLeft];
    [second_winBtn addTarget:self action:@selector(secondWin) forControlEvents:UIControlEventTouchUpInside];
    [_content addSubview:second_winBtn];
    SetViewLeftUp(first_winBtn, 0, 520);
    SetViewLeftUp(second_winBtn, 592, 520);
    [first_winBtn setAlpha:0];
    [second_winBtn setAlpha:0];

}


- (void)firstWin
{
    [[CartModel sharedCart] addFlagForWid:firstWare.WID];
    PostNotification(Noti_RefreshCartWare, nil);
    [self closeBtnPressed];
}

- (void)secondWin
{
    [[CartModel sharedCart] addFlagForWid:secondWare.WID];
    PostNotification(Noti_RefreshCartWare, nil);
    [self closeBtnPressed];
}



#pragma mark - UITableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (tableView == cartTable) {
        return [availableCarts count];
    }else{
        
        return [_propertyKeys count];
    }
    
 
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == cartTable) {
        static NSString *identify = @"ShopTableCell";
        CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil)
        {
            cell =  [[CartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        
        NSInteger tureNum =  [[availableCarts valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]] integerValue];
        [cell buildCellWithPaid:NO andWareIndex:tureNum];
        [cell setIsCompare:YES];
        [cell setUnflod:NO];
        [cell setDelegate:self];
        [cell setIndexPath:indexPath];
        if (tureNum == firstIndex ||tureNum == secondIndex) {
            [cell setChooseToCompared:YES];
        }else{
            [cell setChooseToCompared:NO];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
    }else{
        static NSString *identify = @"ShopInfoTableCell";
        CompareInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil)
        {
            cell =  [[CompareInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
           
            
        }
        NSString *key = [_propertyKeys objectAtIndex:indexPath.row];
        NSString *v1 = [firstWare.WMeta valueForKey:key];
        NSString *v2 = [secondWare.WMeta valueForKey:key];
        NSString *keyName = [[key componentsSeparatedByString:@"|"] objectAtIndex:1];
        [cell buildCompareCellWithKeyName:keyName value1:v1 value2:v2 ];

        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == cartTable) {
        return 96;
    }else{
        return 28;
    }
   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView != infoTable) {
            CartTableViewCell *cell = (CartTableViewCell *)[cartTable cellForRowAtIndexPath:indexPath];
            if ([[availableCarts valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]] integerValue]== firstIndex) {
                [cell setChooseToCompared:NO];
                firstWare =nil;
                firstIndex = -1;
                [first_ImgView setImage:nil];
                [availableCarts removeAllObjects];
                for (int i = 0; i < [[CartModel sharedCart] UndoCount]; i ++) {
                    [availableCarts setObject:[NSNumber numberWithInt:i] forKey:[NSString stringWithFormat:@"%d",i]];
                }
                [cartTable reloadData];
            }else if([[availableCarts valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]] integerValue] == secondIndex){
                [cell setChooseToCompared:NO];
                secondWare = nil;
                secondIndex = -1;
                [second_ImgView setImage:nil];
            }else{
                if (!firstWare) {
                     firstWare = [[CartModel sharedCart] getUndoWareAtIndex:[[availableCarts valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]] integerValue]];
                    firstIndex = [[availableCarts valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]] integerValue];
                    [first_ImgView getImage:firstWare.WPicLink defaultImage:@""];
                     int j  =  0 ;
                    [availableCarts removeAllObjects];
                    for (int  i = 0;  i <[[CartModel sharedCart] UndoCount]; i++) {
                        if ([[CartModel sharedCart] getUndoWareAtIndex:i].WType == firstWare.WType && [[CartModel sharedCart] getUndoWareAtIndex:i].WType2 == firstWare.WType2) {
                            [availableCarts setObject:[NSNumber numberWithInt:i] forKey:[NSString stringWithFormat:@"%d",j]];
                            j++;
                        }
                   
                    }
                    [cartTable reloadData];
                }else if(!secondWare){
                    secondWare = [[CartModel sharedCart] getUndoWareAtIndex:[[availableCarts valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]] integerValue]];
                    secondIndex = [[availableCarts valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]] integerValue];
                    [second_ImgView getImage:secondWare.WPicLink defaultImage:@""];
                }
                [cell setChooseToCompared:YES];
                if (firstWare &&secondWare) {
                    [self setInfoDta];
                    [self setCompareData];
                }
                
                
                
            }
        
        
 
    }

   

}

- (void)setInfoDta
{
    [cartTable setAlpha:0];
    [infoTable setAlpha:1];
    [infoTable reloadData];
    [first_winBtn setAlpha:1];
    [second_winBtn setAlpha:1];
    [bg_infoFirst setAlpha:1];
    [bg_infoSecond setAlpha:1];
    [info_firstWareName setAlpha:1];
    [info_firstWarePrice setAlpha:1];
    [info_secondWareName setAlpha:1];
    [info_secondWarePrice setAlpha:1];
    
    [info_firstWareName animateStop];
    [info_firstWareName setTitleWithTitleText:firstWare.WName andTitleColor:PMColor1 andTitleFont:PMFont2 andMoveSpeed:1 andIsAutomatic:YES];
    [info_firstWareName setTitleTextAlignment:NSTextAlignmentRight];
    [info_firstWareName animateStart];
    
    [info_firstWarePrice animateStop];
    [info_firstWarePrice setTitleWithTitleText:[NSString stringWithFormat:@"%.2f~%.2f", firstWare.WPriceLB, firstWare.WPriceUB] andTitleColor:PMColor6 andTitleFont:PMFont1 andMoveSpeed:1.5 andIsAutomatic:YES];
    [info_firstWarePrice setTitleTextAlignment:NSTextAlignmentRight];
    [info_firstWarePrice animateStart];
    
    [info_secondWareName animateStop];
    [info_secondWareName setTitleWithTitleText:secondWare.WName andTitleColor:PMColor1 andTitleFont:PMFont2 andMoveSpeed:1 andIsAutomatic:YES];
    [info_secondWareName animateStart];
    
    [info_secondWarePrice animateStop];
    [info_secondWarePrice setTitleWithTitleText:[NSString stringWithFormat:@"%.2f~%.2f", secondWare.WPriceLB, secondWare.WPriceUB] andTitleColor:PMColor6 andTitleFont:PMFont1 andMoveSpeed:1.5 andIsAutomatic:YES];
    [info_secondWarePrice animateStart];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)show
{
    [_closeBtn setImage:[UIImage imageNamed:@"btn_back_login.png"] forState:UIControlStateNormal];
    
    [bgView setBackgroundColor:[UIColor clearColor]];
    [bgView setAlpha:1];
    [_content showInFrom:kAFAnimationNone inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:nil];
    
}

- (void)closeBtnPressed
{
    [self hidden];
}

- (void)hidden
{
   
    [bgView setAlpha:0];
    [_content hiddenOutTo:kAFAnimationNone inView:self.view withFade:YES duration:0.5 delegate:self startSelector:nil stopSelector:@selector(finishOut)];
}

- (void)finishOut
{
    [super dismiss];
    [self.delegate popViewfinished];
    [self.view removeFromSuperview];
}

@end
