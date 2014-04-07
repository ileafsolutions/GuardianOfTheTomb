//
//  CSViewController.m
//  GuardianOfTheTomb
//
//  Created by Evan Gould on 4/1/14.
//  Copyright (c) 2014 The Evan & The Jason. All rights reserved.
//

#import "CSViewController.h"
#import "CSMyScene.h"
#import "CSMyScene.h"

@implementation CSViewController
{
    SKView* _gameView;
    CSMyScene* _gameScene;
    CSGameModel* _model;
}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//
//    // Configure the view.
//    SKView * skView = (SKView *)self.view;
//    skView.showsFPS = YES;
//    skView.showsNodeCount = YES;
//    
//    // Create and configure the scene.
//    SKScene * scene = [CSMyScene sceneWithSize:skView.bounds.size];
//    scene.scaleMode = SKSceneScaleModeAspectFill;
//    
//    // Present the scene.
//    [skView presentScene:scene];
//}





//use this instead of viewdidload to make sure everything is loaded
-(void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    

    
    // Configure the view.
    _gameView = (SKView *)self.view;
    _gameView.showsFPS = YES;
    _gameView.showsNodeCount = YES;
    
    
    //create and initialize the game model
    _model = [[CSGameModel alloc] init];
    [_model setDelegate:self];
    [_model startGame];

    
    // Create and configure the scene.
    _gameScene = [CSMyScene sceneWithSize:_gameView.bounds.size];
    _gameScene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Set the rate of fire to the default rate.
    _gameScene.rateOfFire = 1.0f;
    
    
    // Present the scene.
    [_gameView presentScene:_gameScene];
    
    
    
    
}


#pragma mark CSGameModel delegate methods

-(void) waveEnded:(CSGameModel *)gameModel
{
    
}

-(void) waveStarted:(CSGameModel *)gameModel
{
    
}

-(void) spawnMonsters:(CSGameModel *)gameModel meleeSkeletons:(int)melee andRangedSkeletons:(int)ranged
{
    [_gameScene spawnMeleeSkeletons:melee andRangedSkeletons:ranged];

}

-(void) gameOver:(CSGameModel *)gameModel
{
    
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
