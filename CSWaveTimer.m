//
//  CSWaveTimer.m
//  GuardianOfTheTomb
//
//  Created by Evan Gould on 4/6/14.
//  Copyright (c) 2014 The Evan & The Jason. All rights reserved.
//

#import "CSWaveTimer.h"

@implementation CSWaveTimer
{
    NSDate * startingTime;
    NSDate * tempDate;
    BOOL currentlyPaused;
}



-(id) initWithLongInterval:(float)longInterval andShortInterval:(float)shortInterval andDelegate:(id<CSWaveTimerDelegate>)delegate
{
    self = [super init];
    
    if (self)
    {
        self.shortInterval = shortInterval;
        self.longInterval = longInterval;
        self.delegate = delegate;
        startingTime = nil;
        tempDate = nil;
        currentlyPaused = FALSE;
        
    }
    
    
    return self;
}

//time since the timer has started
-(float) time
{
    return -[startingTime  timeIntervalSinceNow];
}

//called when the timer expired
-(void) longTimerExpired
{
    [self stopTimer];
    [self shortTimerExpired];
    
    //call the delegate
    [self.delegate longTimerExpired:self];
    
}

//called when the shorttimer expires
-(void) shortTimerExpired
{
    if (self.longTimer != nil)
    {
        [self.delegate shortTimerExpired:self time:[self time] longInterval:[self longInterval]];
    }
}

//Stop all the timers
-(void) stopTimer
{
    [self.shortTimer invalidate];
    [self.longTimer invalidate];
    
    self.longTimer = nil;
    self.shortTimer = nil;
    
    startingTime = nil;
    tempDate = nil;
    
    currentlyPaused = FALSE;

}


//Starts the timer
-(void) startTimer
{
    [self stopTimer];
    
    self.shortTimer = [NSTimer scheduledTimerWithTimeInterval:self.shortInterval target:self selector:@selector(shortTimerExpired) userInfo:nil repeats:TRUE];
    self.longTimer = [NSTimer scheduledTimerWithTimeInterval:self.longInterval target:self selector:@selector(longTimerExpired) userInfo:nil repeats:FALSE];
    startingTime = [[NSDate alloc] init];
    
    currentlyPaused = FALSE;
    tempDate = nil;
    
    //pauses and unpauses when the application is put into and revived from background
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pauseTimer) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unPauseTimer) name:UIApplicationDidBecomeActiveNotification object:nil];
}

//Pause the timer
-(void) pauseTimer
{
    [self.longTimer invalidate];
    self.longTimer = nil;
    
    if (currentlyPaused == FALSE)
        tempDate = [[NSDate alloc] init];
    
    currentlyPaused = TRUE;
}

//Unpauses the timer 
-(void) unPauseTimer
{
    if (currentlyPaused == FALSE)
        return;
    
    NSTimeInterval totalElapsedTime = [startingTime timeIntervalSinceNow];
    NSTimeInterval elapsedPauseTime = [tempDate timeIntervalSinceNow];
    
    startingTime = [startingTime dateByAddingTimeInterval:-elapsedPauseTime];
    tempDate = nil;
    
    //create new longtimer
    self.longTimer = [NSTimer scheduledTimerWithTimeInterval:(self.longInterval + totalElapsedTime - elapsedPauseTime) target:self selector:@selector(longTimerExpired) userInfo:nil repeats:FALSE];
    
    
}

@end
