//
//  Player.m
//  LabrynThing
//
//  Created by Stephanie Shupe on 9/4/12.
//  Copyright (c) 2012 burnOffBabes. All rights reserved.
//

#import "Player.h"
#import "WinBox.h"
#import "Ball.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation Player

@synthesize balls = _balls;
@synthesize winBoxes = _winBoxes;
@synthesize peerID = _peerID;

-(Player*)init {
    self = [super init];
    if (self) {
        self.balls = [NSMutableArray new]; // create ball object in 'viewDidAppear'
        self.winBoxes = [NSMutableArray new];
    }
    return self;
}

- (void)makeBallAndWinBoxWithRadius: (double) radius inView: (UIView*) view
{
    float redness = (double)arc4random()/UINT_MAX;
    float greenness = (double)arc4random()/UINT_MAX;
    float blueness = (double)arc4random()/UINT_MAX;
    
    UIColor *color = [UIColor colorWithRed:redness green:greenness blue:blueness alpha:1];
    UIColor *colorLighter = [UIColor colorWithRed:redness green:greenness blue:blueness alpha:0.7];
        
    CGPoint winBoxCenter = generatePosition(view,2*radius);
    WinBox *winBox = [WinBox createWinBoxAtPosition: winBoxCenter withView:view withWidth:2*radius andColor:colorLighter];
    
    [self.winBoxes addObject:winBox];
    
    CGPoint nextBallCenter = generatePosition(view, 2*radius);
    Ball *nextBall = [Ball createBallAtPosition:nextBallCenter withView:view withWeight:10*radius withRadius:radius andColor:color];
    [self.balls addObject:nextBall];
}

CGPoint (^generatePosition)(UIView *, double) = ^CGPoint(UIView * view, double size){
    double xPos = arc4random() % (int) view.bounds.size.width;
    double yPos = arc4random() % (int) view.bounds.size.height;
    
    if (xPos + size/2 >= view.bounds.size.width) {
        xPos = view.bounds.size.width - size/2;
    } else if (xPos - size/2 <= 0 ){
        xPos = size/2;
    }
    
    if (yPos + size/2 >= view.bounds.size.height) {
        yPos = view.bounds.size.height - size/2;
    } else if (yPos - size/2 <= 0 ){
        yPos = size/2;
    }
    
    return CGPointMake(xPos, yPos);
};

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.balls forKey:@"balls"];
    [aCoder encodeObject:self.winBoxes forKey:@"winBoxes"];
    [aCoder encodeObject:self.peerID forKey:@"peerID"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self) {
        self.balls = [aDecoder decodeObjectForKey:@"balls"];
        self.winBoxes = [aDecoder decodeObjectForKey:@"winBoxes"];
        self.peerID = [aDecoder decodeObjectForKey:@"peerID"];
    }
    return self;
}


@end
