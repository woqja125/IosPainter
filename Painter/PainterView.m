//
//  PainterView.m
//  Painter
//
//  Created by 이재범 on 2014. 8. 25..
//  Copyright (c) 2014년 jb. All rights reserved.
//

#import "PainterView.h"

@implementation PainterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setWidth:(CGFloat)w
{
    Width = w;
    CGContextSetLineWidth(imgCon, Width*2);
}

-(void)awakeFromNib
{
    CGFloat dat[]={0, 0, 0, 1};
    Width = 1;
    CGColorSpaceRef ccs = CGColorSpaceCreateDeviceRGB();
    col = CGColorCreate(ccs, dat);
    CGColorSpaceRelease(ccs);
    Path = CGPathCreateMutable();
    W = self.frame.size.width;
    H = self.frame.size.height;
    imgCon = CGBitmapContextCreate(NULL, 2*W, 2*H, 8, 2*W*4, ccs
                                   , (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGContextSetLineWidth(imgCon, 2);
    CGColorSpaceRelease(ccs);
}


// Only override drawRect: if you perform custom drawing.q
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef cr = UIGraphicsGetCurrentContext();
    CGImageRef image = CGBitmapContextCreateImage(imgCon);
    CGContextDrawImage(cr, CGRectMake(0, 0, W, H), image);
    CGImageRelease(image);
    
    CGContextSetLineWidth(cr, Width);
    
    CGContextAddPath(cr, Path);
    CGContextSetStrokeColorWithColor(cr,col);
    CGContextStrokePath(cr);
}

-(void)setColor:(int)r :(int)g :(int)b
{
    CGFloat dat[]={r/255.0, g/255.0, b/255.0, 1};
    CGColorRelease(col);
    
    CGColorSpaceRef ccs = CGColorSpaceCreateDeviceRGB();
    col = CGColorCreate(ccs, dat);
    CGColorSpaceRelease(ccs);
    //CGPath
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint loc = [touch locationInView:self];
    CGPathMoveToPoint(Path, NULL, loc.x, loc.y);
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint loc = [touch locationInView:self];
    CGPathAddLineToPoint(Path, NULL, loc.x, loc.y);
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint loc = [touch locationInView:self];
    CGPathAddLineToPoint(Path, NULL, loc.x, loc.y);
    
    CGAffineTransform scaleTransform = CGAffineTransformIdentity;
    scaleTransform = CGAffineTransformScale(scaleTransform, 2, 2);
    CGPathRef tmp = CGPathCreateMutableCopyByTransformingPath(Path, &scaleTransform);
    
    CGContextAddPath(imgCon, tmp);
    CGContextSetStrokeColorWithColor(imgCon,col);
    CGContextStrokePath(imgCon);
    
    CGPathRelease(tmp);
    CGPathRelease(Path);
    Path = CGPathCreateMutable();
    [self setNeedsDisplay];
}

@end
