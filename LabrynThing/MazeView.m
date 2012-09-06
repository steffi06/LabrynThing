//
//  MazeView.m
//  LabrynThing
//
//  Created by Stephanie Shupe on 9/3/12.
//  Copyright (c) 2012 burnOffBabes. All rights reserved.
//

#import "MazeView.h"
#import "Ball.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreMotion/CoreMotion.h>

@interface MazeView ()

@end

@implementation MazeView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGRect winBox = CGRectMake(rect.size.width - 60,rect.size.height - 60, 60, 60);
//    CGContextSetFillColorWithColor(context, [[UIColor redColor]CGColor]);
//    CGContextFillRect(context, winBox);
    
//    CGRect line = CGRectMake(100, 100, 20, 5);
    
}


@end
