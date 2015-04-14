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
#import "EndGameView.h"

@interface ViewController () {
    float SPEED;
    bool END;
    
}

@property (nonatomic) Game * game;
@property (nonatomic) NSMutableArray * enemiesOnScreen;
@property (nonatomic) UIImageView * ship;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer * tapHandler = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapHandler];
    self.enemiesOnScreen = [[NSMutableArray alloc] init];
    self.game = [[Game alloc] initGame];
    SPEED = 0.015;
    END = false;
    UIImage *bk1 = [UIImage imageNamed:@"background"];
    UIImageView *v1 = [[UIImageView alloc] initWithFrame: CGRectMake(0, -700, 400, 700)];
    [v1 setImage: bk1];
    [self.view addSubview:v1];
    
    UIImage *bk2 = [UIImage imageNamed:@"background"];
    UIImageView *v2 = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 400, 700)];
    [v2 setImage:bk2];
    [self.view addSubview:v2];
    
    [self moveBackground:v1 and:v2];
    
    
    UIImage *earth = [UIImage imageNamed:@"myearth"];
    UIImageView *e = [[UIImageView alloc] initWithFrame:CGRectMake( -10, 400, 400, 400)];
    [e setImage:earth];
    [self.view addSubview:e];
    [self startIntro: e];
    
    UIImage *s = [UIImage imageNamed:@"ship1"];
    self.ship = [[UIImageView alloc] initWithFrame:CGRectMake( 160, 500, 100, 100)];
    [self.ship setImage:s];
    [self.view addSubview:self.ship];
    [self osolateShip: self.ship at: 0];
    
    
}

 
-(void) drawEnemies: (enemy *) enemyObject
{
        int p = enemyObject.position;
        UIImage *enemyImg = [UIImage imageNamed:@"enemyship"];
        UIImageView *enemyVw = [[UIImageView alloc] initWithFrame:CGRectMake( p, 0, 50, 50)];
        [enemyVw setImage:enemyImg];
        [self.view addSubview:enemyVw];
        //add enemy to enemiesOnScreen
        [self.enemiesOnScreen addObject:enemyVw];
        [self createEnemy:enemyVw];
    
}

-(void) createEnemy: (UIImageView *) enemyVw
{
    [self animateEnemy: enemyVw];
    [UIView animateWithDuration: 3 animations:^{
        [enemyVw setAlpha: 0.9];
    }
    completion:^(BOOL finished) {
        if (END == true)
            return;
        [self drawEnemies:[self.game startEnemies]];
        
    }];
    
}

-(void) endGame
{
    NSInteger size = [self.enemiesOnScreen count];
    for (int i = 0; i < size; i++)
        [[self.enemiesOnScreen objectAtIndex:i] removeFromSuperview];
    [self.enemiesOnScreen removeAllObjects];
    END = true;
    [self.ship removeFromSuperview];
    self.game = nil;
    EndGameView *endView = [[EndGameView alloc] init];
    [self.navigationController pushViewController:endView animated:YES];}

-(void) animateEnemy: (UIImageView *) view
{
    if (END == true)
        return;
    if (![self.view.subviews containsObject:view])
        return;
    else if (view.frame.origin.y >= 700) {
        [view removeFromSuperview];
        [self.enemiesOnScreen removeObject: view];
        [self endGame];
        return;
    }
    CGPoint labelPosition = CGPointMake(view.frame.origin.x, view.frame.origin.y + 10);
    [UIView animateWithDuration: 0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        view.frame = CGRectMake( labelPosition.x , labelPosition.y , view.frame.size.width, view.frame.size.height);
    }
    completion:^(BOOL finished) {
        [self animateEnemy:view];
    }];
}

-(BOOL) hitShip: (UIImageView *) view
{
    int x = view.frame.origin.x;
    int y = view.frame.origin.y;
    UIImageView * temp;
    int tempPositionX, tempPositionY;
    NSInteger size = [self.enemiesOnScreen count];
    for (int i = 0; i < size; i++) {
        temp = [self.enemiesOnScreen objectAtIndex:i];
        tempPositionX = temp.frame.origin.x;
        tempPositionY = temp.frame.origin.y;
        if (tempPositionX >= x + 10 && tempPositionX <= x + 100 && tempPositionY >= y + 10 && tempPositionY <= y + 100) {
            [self.enemiesOnScreen removeObject:temp];
            [temp removeFromSuperview];
            return true;
            
        }
    }
    return false;
}

-(void) handleTap: (UIGestureRecognizer *) sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {
        int x = self.ship.frame.origin.x + 50;
        int y = self.ship.frame.origin.y;
        shooter * s = [self.game startShooter:x and:y];
        [self drawShooter: s];
    }
    
}

-(void) drawShooter: (shooter *) s
{
    int x = s.xCoord;
    int y = s.yCoord;
    
    UIImage *shooterImg = [UIImage imageNamed:@"shipexpl1"];
    UIImageView *shooterVw = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, 10, 10)];
    [ shooterVw setImage:shooterImg];
    [self.view addSubview:shooterVw];
    [self animateShooter:shooterVw];
}

-(void) animateShooter: (UIImageView *) view
{
    if (view.frame.origin.y <= -10) {
        [view removeFromSuperview];
        return;
    }
    CGPoint labelPosition = CGPointMake(view.frame.origin.x, view.frame.origin.y - 10);
    [UIView animateWithDuration: 0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        view.frame = CGRectMake( labelPosition.x , labelPosition.y , view.frame.size.width, view.frame.size.height);
    }
    completion:^(BOOL finished) {
        BOOL temp = [self detectCollision:view];
        if (temp == true)
            return;
        [self animateShooter:view];
    }];
}

-(BOOL) detectCollision: (UIImageView *) shooter
{
    int x = shooter.frame.origin.x;
    int y = shooter.frame.origin.y;
    if (y <= -5)
        return true;
    UIImageView * temp;
    int tempPositionX, tempPositionY;
    NSInteger size = [self.enemiesOnScreen count];
    for (int i = 0; i < size; i++) {
        temp = [self.enemiesOnScreen objectAtIndex:i];
        tempPositionX = temp.frame.origin.x;
        tempPositionY = temp.frame.origin.y;
        if (tempPositionX + 50 >= x && tempPositionX <= x && tempPositionY  + 50 >= y && tempPositionY <= y) {
            [shooter removeFromSuperview];
            [self.enemiesOnScreen removeObject:temp];
            [temp removeFromSuperview];
            return true;
        }
    }
    return false;
}

-(void) startIntro: (UIImageView *) earth
{
    UILabel *count = [[UILabel alloc] initWithFrame:(CGRectMake(170, 150, 200, 200))];
    count.textColor = [UIColor whiteColor];
    [count setFont:[UIFont boldSystemFontOfSize: 80]];
    [self.view addSubview:count];
    [self countDown:count at:@"1"];
    CGPoint labelPosition = CGPointMake(earth.frame.origin.x, 700);
    [UIView animateWithDuration: 4 animations:^{
        earth.frame = CGRectMake( labelPosition.x , labelPosition.y , earth.frame.size.width, earth.frame.size.height);
    }
    completion:^(BOOL finished) {
        [earth removeFromSuperview];
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
        else {
            [label removeFromSuperview];
            [self drawEnemies:[self.game startEnemies]];
        }
    }];
}

-(void) osolateShip: (UIImageView *) ship at: (int) position
{
    CGPoint labelPosition;
    if (position == 0)
        labelPosition = CGPointMake(ship.frame.origin.x - 10, ship.frame.origin.y);
    else
        labelPosition = CGPointMake(ship.frame.origin.x + 10, ship.frame.origin.y);
    [UIView animateWithDuration: SPEED delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        ship.frame = CGRectMake( labelPosition.x , labelPosition.y , ship.frame.size.width, ship.frame.size.height);
    }
    completion:^(BOOL finished) {
        bool temp = [self hitShip:self.ship];
        if (temp == true) {
            [self endGame];
            return;
        }
        if (ship.frame.origin.x == 0) {
         //   if (SPEED > 0.004)
           //     SPEED = SPEED - 0.005;
            [self osolateShip: ship at: 270];
        }
        else if (ship.frame.origin.x == 270)
            [self osolateShip: ship at: 0];
        else
            [self osolateShip:ship at:position];
    }];
}

-(void) moveBackground: (UIImageView *) v1 and: (UIImageView *) v2
{
    if (END == true) {
        [v1 removeFromSuperview];
        [v2 removeFromSuperview];
        return;
    }
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
