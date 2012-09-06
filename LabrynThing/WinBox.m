//
//  WinBox.m
//  LabrynThing
//
//  Created by Stephanie Shupe on 9/3/12.
//  Copyright (c) 2012 burnOffBabes. All rights reserved.
//

#import "WinBox.h"
#import <QuartzCore/QuartzCore.h>

@interface WinBox()
@end

@implementation WinBox

+(WinBox*)createWinBoxAtPosition:(CGPoint)position withView:(UIView *)view withWidth:(double)width andColor:(UIColor *)color;
{
    WinBox *winBox = [WinBox new];
    winBox.layer = [CALayer new];
    
    winBox.layer.bounds = CGRectMake( 0 , 0 , width , width );
    winBox.layer.position = position;
    winBox.layer.delegate = winBox;
    [winBox.layer setNeedsDisplay];
    [view.layer addSublayer:winBox.layer];
    
    winBox.width = width;
    winBox.color = color;
    winBox.layer.zPosition = 1.0;
    
    return winBox;
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGRect winBoxRect = CGRectMake(self.layer.bounds.origin.x + 2, self.layer.bounds.origin.y + 2, self.layer.bounds.size.width - 4, self.layer.bounds.size.height - 4);
    CGContextSetFillColorWithColor(ctx, [self.color CGColor]);
    CGContextFillRect(ctx, winBoxRect);
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeDouble:self.width forKey:@"width"];
    [aCoder encodeCGPoint:self.layer.position forKey:@"position"];
    [aCoder encodeObject:self.color forKey:@"color"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        [aDecoder decodeDoubleForKey:@"width"];
        [aDecoder decodeCGPointForKey:@"position"];
        [aDecoder decodeObjectForKey:@"color"];
    }
    return self;
}



@end
