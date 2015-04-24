//
//  Game.h
//  470Proj
//
//  Created by Helen San on 4/6/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "enemy.h"
#import "shooter.h"


@interface Game : NSObject

-(NSMutableArray *) enemies;

-(id) initGame;
-(enemy *) startEnemies;
-(enemy *) returnEnemyAtIndex: (int) ind;
-(shooter *) startShooter: (int) a and: (int) b;
-(void) increasePowerLevel;
-(void) decrementPowerLevel;
-(int) getPowerLevel;

@end
