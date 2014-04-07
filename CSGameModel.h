//
//  CSGameModel.h
//  GuardianOfTheTomb
//
//  Created by Evan Gould on 4/3/14.
//  Copyright (c) 2014 The Evan & The Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSWaveTimer.h"

@class CSGameModel;

@protocol CSGameModelDelegate <NSObject>

-(void) waveStarted:(CSGameModel*) gameModel;
-(void) spawnMonsters:(CSGameModel*) gameModel meleeSkeletons:(int) melee andRangedSkeletons:(int) ranged;
-(void) waveEnded:(CSGameModel*) gameModel;
-(void) gameOver:(CSGameModel*) gameModel;

@end

//This class implements the CSWaveTimerDelegate
@interface CSGameModel : NSObject <CSWaveTimerDelegate>

//Delegate for the game model
@property (nonatomic, weak) id<CSGameModelDelegate> delegate;

//Returns the current wave
@property int currentWave;

//Can return or set the state of the game. Used to stop timers and clear enemies from the screen.
@property BOOL gameIsOngoing;

//Returns 0 if the game is in the shooting phase, or 1 if the game is in the protecting phase, or 2 if the game is between waves
@property int gameState;

//Timer for the first part of a wave where a player is shooting outwards
@property CSWaveTimer * timer;



-(void) startGame;
-(void) pauseGame;
-(void) resumeGame;
-(void) saveGame;

@end
