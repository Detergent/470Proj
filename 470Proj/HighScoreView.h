//
//  HighScoreView.h
//  470Proj
//
//  Created by Helen San on 5/2/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface HighScoreView : PFQueryTableViewController

-(void) setScore: (int) time print: (NSString *) text;

@end
