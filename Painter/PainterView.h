//
//  PainterView.h
//  Painter
//
//  Created by 이재범 on 2014. 8. 25..
//  Copyright (c) 2014년 jb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PainterView : UIView
{
    int W, H;
    CGContextRef imgCon;
    CGColorRef col;
    CGFloat Width;
    NSMutableDictionary *Paths;
}

-(void)setColor:(int)r :(int)g :(int)b;
-(void)setWidth:(CGFloat)w;

@end
