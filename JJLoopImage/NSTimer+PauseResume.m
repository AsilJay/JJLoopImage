//
//  NSTimer+PauseResume.m
//  JJLoopImage
//
//  Created by myjawdrops on 2016/12/15.
//  Copyright © 2016年 MyJawDrops. All rights reserved.
//

#import "NSTimer+PauseResume.h"

@implementation NSTimer (PauseResume)

-(void)pauseTimer{
    
    if (![self isValid]) {
        return ;
    }
    
    [self setFireDate:[NSDate distantFuture]]; //如果给我一个期限，我希望是4001-01-01 00:00:00 +0000
    
    
}


-(void)resumeTimer{
    
    if (![self isValid]) {
        return ;
    }
    
    //[self setFireDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    [self setFireDate:[NSDate date]];
    
}

@end
