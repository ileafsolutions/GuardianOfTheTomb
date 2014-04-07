//
//  CSWaveTimer.h
//  GuardianOfTheTomb
//
//  Created by Evan Gould on 4/6/14.
//  Copyright (c) 2014 The Evan & The Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  CSWaveTimer;

@protocol CSWaveTimerDelegate <NSObject>

-(void) longTimerExpired:(CSWaveTimer*) gameTimer;
-(void) shortTimerExpired:(CSWaveTimer*) gameTimer time:(float) time longInterval:(float) longInterval;

@end

@interface CSWaveTimer : NSObject

@property (weak, nonatomic) id<CSWaveTimerDelegate> delegate;

//How often the short and periodic timer will fire
@property float shortInterval;

//How long the overarching timer is
@property float longInterval;

//The current amount of elapsed time
@property (nonatomic, readonly) float time;

//The two timer objects
@property (strong, nonatomic) NSTimer * longTimer;
@property (strong, nonatomic) NSTimer * shortTimer;

-(id) initWithLongInterval:(float) longInterval andShortInterval:(float) shortInterval andDelegate:(id<CSWaveTimerDelegate>) delegate;

-(void) stopTimer;
-(void) startTimer;
-(void) pauseTimer;
-(void) unPauseTimer;

@end
