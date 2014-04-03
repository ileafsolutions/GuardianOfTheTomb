//
//  CSGameModel.m
//  GuardianOfTheTomb
//
//  Created by Evan Gould on 4/3/14.
//  Copyright (c) 2014 The Evan & The Jason. All rights reserved.
//

#import "CSGameModel.h"

@implementation CSGameModel
{
    NSDate * _currenTime;
    double _shootingPhaseLength;
    double _protectingPhaseLength;
    
}

@synthesize shootingPhaseLength = _shootingPhaseLength;

-(id) init
{
    self = [super init];
    
    if (self == nil)
        return nil;
    
    //Length of the waves
    _shootingPhaseLength = 30 + sqrt(self.currentWave);
    _protectingPhaseLength = 10;
    
    return self;
}

-(double) shootingPhaseLength
{
    return 30 + 2 * sqrt(self.currentWave);
}

-(double) protectingPhaseLength
{
    return 10 + 2 * sqrt(self.currentWave);
}

-(void) startGame
{
    
}


-(void) pauseGame
{
    
}


-(void) resumeGame
{
    
}
@end
