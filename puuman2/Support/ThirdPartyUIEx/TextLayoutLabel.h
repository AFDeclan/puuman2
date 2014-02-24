//
//  TextLayoutLabel.h
//  tryCoretext
//
//  Created by 陈晔 on 13-4-10.
//  Copyright (c) 2013年 创始人团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<Foundation/Foundation.h>



@interface TextLayoutLabel : UILabel

{
@private
    CGFloat characterSpacing_, paragraphSpacing_;
    long linesSpacing_;
    CGRect frame_;
    
}

@property(nonatomic,assign) CGFloat characterSpacing;

@property(nonatomic,assign)long linesSpacing;

@property(nonatomic,assign) CGFloat paragraphSpacing;

@property(nonatomic,assign) BOOL didAbbr;
-(CGFloat) setText:(NSString *)text abbreviated:(BOOL)abbr;

-(void) setFrame:(CGRect)frame;

@end
