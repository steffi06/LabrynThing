//
//  StartScreenViewController.m
//  LabrynThing
//
//  Created by Stephanie Shupe on 9/5/12.
//  Copyright (c) 2012 burnOffBabes. All rights reserved.
//

#import "StartScreenViewController.h"
#import "GameViewController.h"
#import <GameKit/GameKit.h>
#import "Player.h"

@interface StartScreenViewController () <GKPeerPickerControllerDelegate, GKSessionDelegate>

@property (strong, nonatomic) GameViewController *gameVC;
@property (strong, nonatomic) GKPeerPickerController *peerPickerController;

@end

@implementation StartScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)onePlayerButton:(id)sender {
    GameViewController *gameVC = [[GameViewController alloc] initWithNumPlayers:1];
    
//    self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:gameVC animated:NO completion:nil];
    
}

- (IBAction)twoPlayerButton:(id)sender {


    self.peerPickerController = [[GKPeerPickerController alloc] init];
    self.peerPickerController.delegate = self;
    self.peerPickerController.connectionTypesMask = GKPeerStateAvailable;
    [self.peerPickerController isVisible];
    [self.peerPickerController show];
    
    
    self.gameVC = [[GameViewController alloc] initWithNumPlayers:2];
    

}


// stuff from gvc

#pragma mark - GKPeerPickerController Delegate Methods
-(GKSession *)peerPickerController:(GKPeerPickerController *)picker sessionForConnectionType:(GKPeerPickerConnectionType)type
{
    self.gameVC.session = [[GKSession alloc] initWithSessionID:@"LabrynThing" displayName:nil sessionMode:GKSessionModePeer];
    [self.gameVC.session setDataReceiveHandler:self withContext:nil];
    self.gameVC.session.delegate = self.gameVC;
    
    return self.gameVC.session;
}

-(void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session
{
    Player *player = [[Player alloc] init];
    player.peerID = self.gameVC.session.peerID;
    NSData *playerData = [NSKeyedArchiver archivedDataWithRootObject:player];
    [session setDataReceiveHandler:self withContext:nil];
    [session sendData:playerData toPeers:@[ peerID ] withDataMode:GKSendDataReliable error:nil];
    
    [self.gameVC.players addObject:player];
    
}

-(void) receiveData: (NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context
{
    if (self.gameVC.players.count < 2) {
        Player *otherPlayer = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [self.gameVC.players addObject:otherPlayer];
    }
    
    NSLog(@"%@",self.gameVC.players);
    
    [self.peerPickerController dismiss];
    
    [self presentViewController:self.gameVC animated:NO completion:nil];
}

-(void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker
{
    [self presentViewController:[[GameViewController alloc] initWithNumPlayers:1] animated:NO completion:nil];
}





@end
