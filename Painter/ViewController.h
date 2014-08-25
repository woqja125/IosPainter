//
//  ViewController.h
//  Painter
//
//  Created by 이재범 on 2014. 8. 25..
//  Copyright (c) 2014년 jb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PainterView;

@interface ViewController : UIViewController
{
    IBOutlet PainterView *v;
    IBOutlet UISlider *slider;
    IBOutlet UILabel *label;
    float width;
}
-(IBAction)draw:(id)sender;
-(IBAction)erase:(id)sender;
-(IBAction)widthChanged:(id)sender;

@end
