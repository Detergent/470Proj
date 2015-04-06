//
//  ViewController.m
//  470Proj
//
//  Created by Helen San on 3/31/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import "ViewController.h"
#import "enemy.h"
#import "Game.h"

@interface ViewController () {
    float SPEED;
}

@property (nonatomic) Game * game;
@property (nonatomic) NSMutableArray * enemies;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.game = [[Game alloc] initGame];
    SPEED = 1;
    UIImage *bk1 = [UIImage imageNamed:@"background"];
    UIImageView *v1 = [[UIImageView alloc] initWithFrame: CGRectMake(0, -700, 400, 700)];
    [v1 setImage: bk1];
    [self.view addSubview:v1];
    
    UIImage *bk2 = [UIImage imageNamed:@"background"];
    UIImageView *v2 = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 400, 700)];
    [v2 setImage:bk2];
    [self.view addSubview:v2];
    
    [self moveBackground:v1 and:v2];
    
    
    UIImage *earth = [UIImage imageNamed:@"earth"];
    UIImageView *e = [[UIImageView alloc] initWithFrame:CGRectMake( -10, 400, 400, 400)];
    [e setImage:earth];
    [self.view addSubview:e];
    [self startIntro: e];
    
    UIImage *s = [UIImage imageNamed:@"ship1"];
    UIImageView *ship = [[UIImageView alloc] initWithFrame:CGRectMake( 160, 500, 100, 100)];
    [ship setImage:s];
    [self.view addSubview:ship];
    [self osolateShip: ship at: 0];
    
    
    
}
/*
-(void) startEnemies
{
    enemy *e1 = [[enemy alloc] initEnemy];
    
    NSMutableArray *r = [NSMutableArray arrayWithObjects: e1, nil];
    [self drawEnemies:r];

}
*/
 
-(void) drawEnemies: (NSMutableArray *) r
{
    NSUInteger size = [r count];
    for (int i = 0; i < size; i++) {
        enemy * e = [r objectAtIndex:i];
        int p = e.position;
        UIImage *enemy1 = [UIImage imageNamed:@"shipexpl1"];
        UIImageView *en1 = [[UIImageView alloc] initWithFrame:CGRectMake( p, 0, 20, 20)];
        [en1 setImage:enemy1];
        [self.view addSubview:en1];
        [self animateEnemy:en1 in:r atIndex: i];
    }
    
}

-(void) animateEnemy: (UIImageView *) e in: (NSMutableArray *) arr atIndex: (int) num
{
    CGPoint labelPosition = CGPointMake(e.frame.origin.x, 700);
    
    [UIView animateWithDuration: 5 animations:^{
        e.frame = CGRectMake( labelPosition.x , labelPosition.y , e.frame.size.width, e.frame.size.height);
    }
    completion:^(BOOL finished) {
        [arr removeObjectAtIndex:num];
    }];
    
    
    [UIView animateWithDuration: 1 animations:^{
        [e setAlpha: 0.9];
    }
    completion:^(BOOL finished) {
        [self drawEnemies:[self.game startEnemies]];
    }];
    
}

-(void) startIntro: (UIImageView *) e
{
    UILabel *count = [[UILabel alloc] initWithFrame:(CGRectMake(170, 150, 200, 200))];
    count.textColor = [UIColor whiteColor];
    count.text = @"one";
    [count setFont:[UIFont boldSystemFontOfSize: 80]];
    [self.view addSubview:count];
    [self countDown:count at:@"1"];
    CGPoint labelPosition = CGPointMake(e.frame.origin.x, 700);
    [UIView animateWithDuration: 4 animations:^{
        e.frame = CGRectMake( labelPosition.x , labelPosition.y , e.frame.size.width, e.frame.size.height);
    }
    completion:^(BOOL finished) {
      
                     }];
}

-(void) countDown: (UILabel *) label at: (NSString *) num
{
    label.text = num;
    [label setAlpha: 1];
    [UIView animateWithDuration: 1.3 animations:^{
        [label setAlpha:0.9];
    }
    completion:^(BOOL finished) {
        [label setAlpha: 0];
        if ([num isEqualToString: @"1"])
            [self countDown:label at:@"2"];
        else if ([num isEqualToString: @"2"])
            [self countDown:label at:@"3"];
        else
            [self drawEnemies:[self.game startEnemies]];
    }];
}

-(void) osolateShip: (UIImageView *) ship at: (int) position
{
    CGPoint labelPosition = CGPointMake(position, ship.frame.origin.y);
    [UIView animateWithDuration: SPEED animations:^{
        ship.frame = CGRectMake( labelPosition.x , labelPosition.y , ship.frame.size.width, ship.frame.size.height);
    }
    completion:^(BOOL finished) {
        if (SPEED > 0.3)
            SPEED = SPEED - 0.03;
        if (position == 0)
            [self osolateShip: ship at: 275];
        else
            [self osolateShip: ship at: 0];
    }];
}

-(void) moveBackground: (UIImageView *) v1 and: (UIImageView *) v2
{
    
    if (v1.frame.origin.y == 0)
        v2.frame = CGRectMake( 0 , -700 , v2.frame.size.width, v2.frame.size.height);
    else if (v2.frame.origin.y == 0)
        v1.frame = CGRectMake( 0 , -700 , v1.frame.size.width, v1.frame.size.height);
     
    CGPoint labelPosition1 = CGPointMake(v1.frame.origin.x, v1.frame.origin.y + 100);
    CGPoint labelPosition2 = CGPointMake(v2.frame.origin.x, v2.frame.origin.y + 100);
    [UIView animateWithDuration: 0.1 animations:^{
        v1.frame = CGRectMake( labelPosition1.x , labelPosition1.y , v1.frame.size.width, v1.frame.size.height);
        
        v2.frame = CGRectMake( labelPosition2.x , labelPosition2.y , v2.frame.size.width, v2.frame.size.height);
    } completion:^(BOOL finished) {
        [self moveBackground:v1 and:v2];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
