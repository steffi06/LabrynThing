//
//  Ball.h
//  LabrynThing
//
//  Created by Stephanie Shupe on 9/3/12.
//  Copyright (c) 2012 burnOffBabes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ball : NSObject <NSCoding>
@property (strong, nonatomic)  CALayer *layer;
@property double weight;
@property double radius;
@property (strong) UIColor *color;
+(Ball*)createBallAtPosition:(CGPoint)position withView:(UIView *)view withWeight:(double)weight withRadius:(double)radius andColor: (UIColor*) color;

@end
