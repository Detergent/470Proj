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

@interface Game() {
    
}

@property (nonatomic) NSMutableArray * enemies;

@end

@implementation Game

-(id) initGame {
    
    if( (self = [super init]) == nil )
        return nil;
    return self;
    
}

-(NSMutableArray *) startEnemies
{
    enemy *e1 = [[enemy alloc] initEnemy];
    
    NSMutableArray *r = [NSMutableArray arrayWithObjects: e1, nil];
    return r;
}

-(NSMutableArray *) enemies
{
    return self.enemies;
}
@end
