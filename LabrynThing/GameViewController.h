//
//  GameViewController.h
//  LabrynThing
//
//  Created by Stephanie Shupe on 9/3/12.
//  Copyright (c) 2012 burnOffBabes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface GameViewController : UIViewController <GKSessionDelegate>

-(id)initWithNumPlayers: (int) numPlayers;
@property (strong) GKSession *session;
@property (strong) NSMutableArray *players;

@end
