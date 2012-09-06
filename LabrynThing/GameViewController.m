//
//  GameViewController.m
//  LabrynThing
//
//  Created by Stephanie Shupe on 9/3/12.
//  Copyright (c) 2012 burnOffBabes. All rights reserved.
//

#import "GameViewController.h"
#import <CoreMotion/CoreMotion.h>
#import <QuartzCore/QuartzCore.h>
#import "MazeView.h"
#import "Ball.h"
#import "WinBox.h"
#import "Player.h"
#import <GameKit/GameKit.h>

@interface GameViewController () <UIAlertViewDelegate>
-(void) startDeviceMotionDetection;
-(void) updateBallPositionWithMotion:(CMDeviceMotion*) motion;
@property CMMotionManager *motionManager;
@property int level;

@property (strong) NSString *connectAlertText;
@end

@implementation GameViewController
//@synthesize balls = _balls;
//@synthesize winBoxes = _winBoxes;
@synthesize motionManager = _motionManager;

-(id)initWithNumPlayers: (int) numPlayers
{
    self = [super init];
    if (self) {
        self.level = 0;
        self.players = [NSMutableArray new];
        
        if (numPlayers == 1)
            [self.players addObject:[[Player alloc] init]];
        
    }
    return self;
}

-(void)loadView
{
    MazeView* mazeView = [MazeView new];
    self.view = mazeView;
    
}

#pragma mark - GKPeerPickerController Delegate Methods

-(void) receiveData: (NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context
{
    if (self.players.count < 2) {
        Player *otherPlayer = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [self.players addObject:otherPlayer];
    }

    NSLog(@"%@",self.players);
        
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.connectAlertText = @"";

}

-(void)connectAlert:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request to Play!"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"No Thanks"
                                          otherButtonTitles:@"Start Game!", nil ];
    [alert show];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self generateNewGame];
    
}

- (void)generateNewGame
{
    self.level++;
    //make num players
    
    
    self.view.layer.sublayers = nil;

    for (Player *player in self.players) {
        for (int i = 0; i < self.level; i++) {
            [player makeBallAndWinBoxWithRadius: arc4random() % 20 + 10 inView:self.view];
        }
    }
    
    [self startDeviceMotionDetection];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark GYROSCOPE STUFF
-(void)startDeviceMotionDetection
{
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.deviceMotionUpdateInterval = 1.0/10.0;
    CMAttitudeReferenceFrame attRefFrame = CMAttitudeReferenceFrameXArbitraryZVertical;
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    
    void(^gyroHandler)(CMDeviceMotion*, NSError*) = ^void(CMDeviceMotion *motion, NSError *error){
        [self updateBallPositionWithMotion:motion];

    };
    
    [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:attRefFrame
                                                            toQueue:queue
                                                        withHandler:gyroHandler];
}

-(void)updateBallPositionWithMotion:(CMDeviceMotion*) motion
{
    for (Player* player in self.players) {
        for(int counter = 0; counter < player.balls.count; counter ++) {
            // returns the difference compared to base-state
            Ball* ball = [player.balls objectAtIndex:counter];
            
            CGFloat roll = motion.attitude.roll;
            CGFloat pitch = motion.attitude.pitch;
            
            double newXPos = ball.layer.position.x + ball.weight * roll;
            double newYPos = ball.layer.position.y + ball.weight * pitch;
                        
            // keep the ball on the screen
            if ( newXPos >= self.view.bounds.size.width - ball.radius) {
                newXPos = self.view.bounds.size.width - ball.radius;
            }  else if (newXPos <= 0 + ball.radius) {
                newXPos = 0 + ball.radius;
            }

            if ( newYPos >= self.view.bounds.size.height - ball.radius) {
                newYPos = self.view.bounds.size.height - ball.radius;
            }  else if (newYPos <= 0 + ball.radius) {
                newYPos = 0 + ball.radius;
            }

            ball.layer.position = CGPointMake(newXPos, newYPos);
            
            [self allIDoIsWinWinWinNoMatterWhat];

        }
    }
}

-(void)allIDoIsWinWinWinNoMatterWhat
{
    
    for (Player* player in self.players) {
        for (int counter = 0; counter < player.balls.count; counter++)
        {
            Ball* ball = [player.balls objectAtIndex:counter];
            WinBox* targetBox = [player.winBoxes objectAtIndex:counter];
            if (CGRectContainsPoint(targetBox.layer.frame, ball.layer.position)
                ){
                ball.layer.position = CGPointMake(targetBox.layer.position.x, targetBox.layer.position.y);
                ball.layer.zPosition = 2.0;
                [player.balls removeObjectAtIndex:counter];
                [player.winBoxes removeObjectAtIndex:counter];
                counter--;
                
            }
        }
    
        if (player.balls.count ==0) {
            UIAlertView* win = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"You won Level %d", self.level]
                                                          message:@"Think you're cool? Try the next level!"
                                                         delegate:self
                                                cancelButtonTitle:[NSString stringWithFormat:@"Level %d", self.level +1]
                                                otherButtonTitles:nil, nil];
            [win show];
            [self.motionManager stopDeviceMotionUpdates];
            // return;
        }
    }
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.title == @"Request to Play!") {
        if (buttonIndex == 1) {
            NSLog(@"Multi-player game initiated");
        }
    } else {
        [self generateNewGame];
    }
}

@end
