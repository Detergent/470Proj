//
//  TitleView.m
//  470Proj
//
//  Created by Justin Guarino on 4/11/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import "TitleView.h"
#import "ViewController.h"
#import "EndGameView.h"
#import <AVFoundation/AVFoundation.h>
#import <Parse/Parse.h>

@interface TitleView () {
    
}

@property (nonatomic) UIButton *startButton;
@property (nonatomic) UIButton *endButton;
@property (nonatomic) AVAudioPlayer *bgm;

@end

@implementation TitleView : UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
    
    //The title is definitely a work in progress, we should come up with something together
    UIImage *title = [UIImage imageNamed:@"title"];
    UIImageView *t = [[UIImageView alloc] initWithFrame:CGRectMake(85, 40, 200, 200)];
    [t setImage:title];
    [self.view addSubview:t];
    
    UIImage *startButtonImage = [UIImage imageNamed:@"startbutton"];
    UIImageView *start = [[UIImageView alloc] initWithFrame:CGRectMake(110, 200, 150, 50)];
    [start setImage:startButtonImage];
    [self.view addSubview:start];
    
    UIImage *endButtonImage = [UIImage imageNamed:@"endbutton"];
    UIImageView *end = [[UIImageView alloc] initWithFrame:CGRectMake(110, 300, 150, 50)];
    [end setImage:endButtonImage];
    [self.view addSubview:end];
    
    self.startButton = [[UIButton alloc] initWithFrame:CGRectMake(110, 200, 150, 50)];
    [self.startButton addTarget:self action:@selector(pressedStart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startButton];
    
    self.endButton = [[UIButton alloc] initWithFrame:CGRectMake(110, 300, 150, 50)];
    [self.endButton addTarget:self action:@selector(pressedEnd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.endButton];
    
    NSString *musicLoc = [NSString stringWithFormat:@"%@/EarthDefenderMenuLoop.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *musicURL = [NSURL fileURLWithPath:musicLoc];
    self.bgm = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    self.bgm.numberOfLoops=-1;
    [self.bgm play];
}

-(void)viewDidAppear:(BOOL)animated {
    [self.bgm play];
}

-(void) moveBackground: (UIImageView *) v1 and: (UIImageView *) v2
{
    
    if (v1.frame.origin.y == 0)
        v2.frame = CGRectMake( 0 , -700 , v2.frame.size.width, v2.frame.size.height);
    else if (v2.frame.origin.y == 0)
        v1.frame = CGRectMake( 0 , -700 , v1.frame.size.width, v1.frame.size.height);
    
    CGPoint labelPosition1 = CGPointMake(v1.frame.origin.x, v1.frame.origin.y + 3.5);
    CGPoint labelPosition2 = CGPointMake(v2.frame.origin.x, v2.frame.origin.y + 3.5);
    [UIView animateWithDuration: 0.1 animations:^{
        v1.frame = CGRectMake( labelPosition1.x , labelPosition1.y , v1.frame.size.width, v1.frame.size.height);
        
        v2.frame = CGRectMake( labelPosition2.x , labelPosition2.y , v2.frame.size.width, v2.frame.size.height);
    } completion:^(BOOL finished) {
        [self moveBackground:v1 and:v2];
    }];
}

-(void) pressedStart
{
    [self.bgm stop];
    ViewController *viewCont = [[ViewController alloc] init];
    [self.navigationController pushViewController:viewCont animated:YES];
}

-(void) pressedEnd
{
    EndGameView *endView = [[EndGameView alloc] init];
    [self.navigationController pushViewController:endView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end