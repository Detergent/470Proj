//
//  game.m
//  470Proj
//
//  Created by Helen San on 4/6/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"
#import "enemy.h"
#import "shooter.h"

@interface Game() {
    int powerLevel;
}

@property (nonatomic) NSMutableArray * enemyArr;

@end

@implementation Game

-(id) initGame {
    powerLevel = 6;
    if( (self = [super init]) == nil )
        return nil;
    return self;
    
}

-(void) increasePowerLevel
{
    if (powerLevel >= 6)
        return;
    powerLevel += 1;
}

-(void) decrementPowerLevel
{
    if (powerLevel <= 0)
        return;
    powerLevel = powerLevel - 1;
}

-(int) getPowerLevel
{
    return powerLevel;
}

-(enemy *) startEnemies
{
    enemy *e1 = [[enemy alloc] initEnemy];
    
    //NSMutableArray *r = [NSMutableArray arrayWithObjects: e1, nil];
    return e1;
}

-(NSMutableArray *) enemies
{
    return self.enemyArr;
}

-(enemy *) returnEnemyAtIndex: (int) ind
{
    return [self.enemyArr objectAtIndex: ind];
}

-(shooter *) startShooter: (int) a and: (int) b
{
    shooter * s = [[shooter alloc] initShooter:a and:b];
    return s;
    
}







@end
