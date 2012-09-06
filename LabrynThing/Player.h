//
//  Player.h
//  LabrynThing
//
//  Created by Stephanie Shupe on 9/4/12.
//  Copyright (c) 2012 burnOffBabes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject <NSCoding>

@property NSMutableArray* balls;
@property NSMutableArray* winBoxes;
@property NSString *peerID;

- (void)makeBallAndWinBoxWithRadius: (double) radius inView: (UIView*) view;


@end
