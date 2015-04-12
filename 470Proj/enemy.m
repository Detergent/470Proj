//
//  enemy.m
//  470Proj
//
//  Created by Helen San on 4/6/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "enemy.h"
//#import "ViewController.h"

@interface enemy() {
    int position;
}


@end

@implementation enemy

-(id) initEnemy {
    position = (arc4random() % 230) + 60;
    
    
    if( (self = [super init]) == nil )
        return nil;
    return self;
    
    
}

-(int) position
{
    return position;
}





@end
