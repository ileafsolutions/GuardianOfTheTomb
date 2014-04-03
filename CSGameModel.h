//
//  CSGameModel.h
//  GuardianOfTheTomb
//
//  Created by Evan Gould on 4/3/14.
//  Copyright (c) 2014 The Evan & The Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSGameModel;

@protocol CSGameModelDelegate <NSObject>

-(void) waveStarted:(CSGameModel*) gameModel;
-(void) waveEnded:(CSGameModel*) gameModel;
-(void) gameOver:(CSGameModel*) gameModel;

@end

@interface CSGameModel : NSObject

@property double currentWave;

@property (nonatomic) double shootingPhaseLength;
@property (nonatomic) double protectingPhaseLength;


-(void) startGame;
-(void) pauseGame;
-(void) resumeGame;
-(void) saveGame;

@end
