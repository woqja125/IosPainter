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
    
    Paths = [[NSMutableDictionary alloc] init];
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
    
	for(id p in [Paths allValues])
	{
		CGMutablePathRef path = (__bridge CGMutablePathRef)(p);
		CGContextAddPath(cr, path);
		CGContextSetStrokeColorWithColor(cr,col);
		CGContextStrokePath(cr);
	}
}

-(void)setColor:(int)r :(int)g :(int)b
{
    CGFloat dat[]={r/255.0, g/255.0, b/255.0, 1};
    CGColorRelease(col);
    
    CGColorSpaceRef ccs = CGColorSpaceCreateDeviceRGB();
    col = CGColorCreate(ccs, dat);
    CGColorSpaceRelease(ccs);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    for(UITouch *touch in touches)
    {
        CGPoint l = [touch locationInView:self];
		NSString *key = [NSString stringWithFormat:@"%d", (int)touch];
		CGMutablePathRef path = CGPathCreateMutable();
		[Paths setValue:(__bridge id)(path) forKey:key];
		CGPathMoveToPoint(path, NULL, l.x, l.y);
	}
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesMoved:touches withEvent:event];
    for(UITouch *touch in touches)
    {
		CGPoint l = [touch locationInView:self];
		NSString *key = [NSString stringWithFormat:@"%d", (int)touch];
		CGMutablePathRef path = (__bridge CGMutablePathRef)([Paths objectForKey:key]);	
		CGPathAddLineToPoint(path, NULL, l.x, l.y);
	}
	[self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
	
    CGAffineTransform scaleTransform = CGAffineTransformIdentity;
    scaleTransform = CGAffineTransformScale(scaleTransform, 2, 2);
	for(UITouch *touch in touches)
    {
		CGPoint l = [touch locationInView:self];
		NSString *key = [NSString stringWithFormat:@"%d", (int)touch];
		CGMutablePathRef path = (__bridge CGMutablePathRef)([Paths objectForKey:key]);
		CGPathAddLineToPoint(path, NULL, l.x, l.y);
		
		CGPathRef tmp = CGPathCreateMutableCopyByTransformingPath(path, &scaleTransform);
		CGContextAddPath(imgCon, tmp);
		CGContextSetStrokeColorWithColor(imgCon,col);
		CGContextStrokePath(imgCon);
		
		CGPathRelease(tmp);
		
		[Paths removeObjectForKey:key];
		CGPathRelease(path);
	}
    [self setNeedsDisplay];
}

@end
