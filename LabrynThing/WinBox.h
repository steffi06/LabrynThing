//
//  WinBox.h
//  LabrynThing
//
//  Created by Stephanie Shupe on 9/3/12.
//  Copyright (c) 2012 burnOffBabes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WinBox : NSObject <NSCoding>
@property (strong, nonatomic)  CALayer *layer;
@property double width;
@property (strong) UIColor * color;
+(WinBox*)createWinBoxAtPosition:(CGPoint)position withView:(UIView *)view withWidth:(double)width andColor:(UIColor *) color;
@end
