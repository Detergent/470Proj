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
    
}

@property (nonatomic) NSMutableArray * enemyArr;

@end

@implementation Game

-(id) initGame {
    
    if( (self = [super init]) == nil )
        return nil;
    return self;
    
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
