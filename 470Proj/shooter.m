//
//  shooter.m
//  470Proj
//
//  Created by Helen San, Brandon Mondo, Justin Guarino on 4/9/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "shooter.h"

@interface shooter() {
    int x;
    int y;
}


@end

@implementation shooter

-(id) initShooter: (int) a and: (int) b
{
    x = a;
    y = b;
    if( (self = [super init]) == nil )
        return nil;
    return self;
}

-(int) xCoord
{
    return x;
}

-(int) yCoord
{
    return y;
}





@end
