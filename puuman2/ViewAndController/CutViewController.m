//
//  CutViewController.m
//  puuman2
//
//  Created by AF_Bigwaves on 14-5-23.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "CutViewController.h"

@interface CutViewController ()

@end

@implementation CutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIImage *srcImg = [UIImage imageNamed:@""];
    imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(10, 150, 300, 200) ;
    CGRect rect = CGRectMake(0, 0, 300, 100);
    CGImageRef cgimg = CGImageCreateWithImageInRect([srcImg CGImage], rect);
    imageView.image = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    [self.view addSubview:imageView];
    
}
-(void)cutCurrentImage:(UIImage *)img{

  

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
