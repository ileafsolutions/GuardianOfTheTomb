//
//  CSGameModel.m
//  GuardianOfTheTomb
//
//  Created by Evan Gould on 4/3/14.
//  Copyright (c) 2014 The Evan & The Jason. All rights reserved.
//

#import "CSGameModel.h"

//Timing related variables
static const int timeBeforeWaveStarts = 2;
static const int lengthOfFirstWaveHalf = 15;
static const int lengthOfSecondWaveHalf = 10;
static const int respawnRate = 3;



@implementation CSGameModel
{
    
    double _shootingPhaseLength;
    double _protectingPhaseLength;
    
}



-(id) init
{
    self = [super init];
    
    if (self == nil)
        return nil;
    
    _shootingPhaseLength = lengthOfFirstWaveHalf;
    _protectingPhaseLength = lengthOfSecondWaveHalf;
    
    //Returns 0 if the game is in the shooting phase, or 1 if the game is in the protecting phase, or 2 if the game is between waves
    self.gameState = 2;
    //Create the timer with the length of the first wave and the respawn rate of the skeletons
    self.timer = [[CSWaveTimer alloc] initWithLongInterval:_shootingPhaseLength andShortInterval:respawnRate andDelegate:self];
    
    return self;
}

#pragma mark Timing delegate methods

//This is a delegate method called when the timer's over arching time limit is reached
-(void) longTimerExpired:(CSWaveTimer *)gameTimer
{
 
    //Check to see which part of the wave expired
    //If the timer that just expired was for the wave intermissions
    if (self.timer.longInterval == timeBeforeWaveStarts)
    {
        
    }
    //If the timer that expired was for the shooting phase
    else if (self.timer.longInterval == _shootingPhaseLength)
    {
        
    }
    //If the timer that expired was for the protecting phase
    else if (self.timer.longInterval == _protectingPhaseLength)
    {
        
    }
    
    
}

//This is a timer's delegate method that is called when the period timer is called, usually several times per longtimer
//This method will probably be used to spawn new enemies for every wave
-(void) shortTimerExpired:(CSWaveTimer *)gameTimer time:(float)time longInterval:(float)longInterval
{
    [self.delegate spawnMonsters:self meleeSkeletons:1 andRangedSkeletons:1];
}


#pragma mark Game model methods

-(void) startGame
{
    [self.timer startTimer];
}

-(void) saveGame
{
    
}


-(void) pauseGame
{
    self.gameIsOngoing = FALSE;
    [self.timer pauseTimer];
}


-(void) resumeGame
{
    self.gameIsOngoing = TRUE;
    [self.timer unPauseTimer];
}
@end
