//
//  ViewController.m
//  Painter
//
//  Created by 이재범 on 2014. 8. 25..
//  Copyright (c) 2014년 jb. All rights reserved.
//

#import "ViewController.h"
#import "PainterView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    width = 1;
    slider.value = 0;
    [label setText:@"1"];
	// Do any additional setup after loading the view, typically from a nib. So I am Bogyu.
}

- (void)didReceiveMemoryWarning
{
    printf("aa\n");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)draw:(id)sender
{
    [v setColor:0 :0 :0];
}
-(IBAction)erase:(id)sender
{
    [v setColor:255 :255 :255];
}
-(IBAction)widthChanged:(id)sender
{
    width = slider.value;
    width = width*9+1;
    [label setText:[NSString stringWithFormat:@"%.1lf", width]];
    [v setWidth:width];
}

@end
