//
//  Game.h
//  470Proj
//
//  Created by Helen San on 4/6/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Game : NSObject

-(NSMutableArray *) enemies;

-(id) initGame;
-(NSMutableArray *) startEnemies;

@end
