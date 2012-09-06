//
//  Ball.m
//  LabrynThing
//
//  Created by Stephanie Shupe on 9/3/12.
//  Copyright (c) 2012 burnOffBabes. All rights reserved.
//

#import "Ball.h"
#import <QuartzCore/QuartzCore.h>

@interface Ball ()
@end

@implementation Ball

+(Ball*)createBallAtPosition:(CGPoint)position withView:(UIView *)view withWeight: (double) weight withRadius:(double)radius andColor:(UIColor *)color
{
    Ball *ball = [Ball new];
    
    ball.layer = [CALayer new];
    ball.layer.bounds = CGRectMake( 0 , 0 , 2*radius , 2*radius );
    ball.layer.position = position;
    ball.layer.delegate = ball;
    [ball.layer setNeedsDisplay];
    [view.layer addSublayer:ball.layer];
    
    ball.layer.zPosition = 3.0;
    ball.color = color;
    ball.radius = radius;
    ball.weight = weight; // affects the speed at which the ball rolls.
    return ball;
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGRect ballRect = CGRectMake(self.layer.bounds.origin.x + 2, self.layer.bounds.origin.y + 2, self.layer.bounds.size.width - 4, self.layer.bounds.size.height - 4);
    
    CGContextSetFillColorWithColor(ctx, [self.color CGColor]);
    CGContextFillEllipseInRect(ctx, ballRect);
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.color forKey:@"color"];
    [aCoder encodeCGPoint:self.layer.position forKey:@"position"];
    [aCoder encodeDouble:self.weight forKey:@"weight"];
    [aCoder encodeDouble:self.radius forKey:@"radius"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self) {
        [aDecoder decodeObjectForKey:@"color"];
        [aDecoder decodeCGPointForKey:@"position"];
        [aDecoder decodeDoubleForKey:@"weight"];
        [aDecoder decodeDoubleForKey:@"radius"];
    }
    
    return self;
}

@end
