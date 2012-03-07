//
//  BSCViewController.m
//  Tap Game
//
//  Created by Bruce Collie on 01/03/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import "BSCViewController.h"
#import "FlipViewController.h"

@interface BSCViewController ()

@end

@implementation BSCViewController
@synthesize resetButton;
@synthesize infoButton;
@synthesize player1Button;
@synthesize player2Button;
@synthesize p1ScoreLabel;
@synthesize p2ScoreLabel;
int p1count = 0;
int p2count = 0;
//@synthesize p1name;
//@synthesize p2name;
static NSString *p1name = @"Player 1";
static NSString *p2name = @"Player 2";
NSDate *start;
NSDate *end;
static NSTimeInterval elapsedTime = 0;
static NSString *winnerName = @"";
NSDate *lastTap;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0];
    player2Button.transform = CGAffineTransformRotate(player2Button.transform, M_PI);
    p2ScoreLabel.transform = CGAffineTransformRotate(p2ScoreLabel.transform, M_PI);
    [UIView commitAnimations];
    [p1ScoreLabel setText:[NSString stringWithFormat:@"%d", p1count]];
    [p2ScoreLabel setText:[NSString stringWithFormat:@"%d", p2count]];
    [player1Button setTitle:p1name forState:UIControlStateNormal];
    [player2Button setTitle:p2name forState:UIControlStateNormal];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setPlayer2Button:nil];
    [self setPlayer1Button:nil];
    [self setP1ScoreLabel:nil];
    [self setP2ScoreLabel:nil];
    [self setResetButton:nil];
    [self setInfoButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)player2ButtonTap:(id)sender {
    lastTap = [NSDate date];
    if (start == Nil) {
        start = [NSDate date];
    }
    p2count++;
    [p2ScoreLabel setText:[NSString stringWithFormat:@"%d", p2count]];
    if (p2count == 100) {
        end = [NSDate date];
        elapsedTime = [end timeIntervalSinceDate:start];
        winnerName = p2name;
        start = Nil;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ wins with a time of %.2f seconds!", p2name, (float)elapsedTime] message:@"Press OK to play again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)player1ButtonTap:(id)sender {
    lastTap = [NSDate date];
    if (start == Nil) {
        start = [NSDate date];
    }
    p1count++;
    [p1ScoreLabel setText:[NSString stringWithFormat:@"%d", p1count]];
    if (p1count == 100) {
        end = [NSDate date];
        elapsedTime = [end timeIntervalSinceDate:start];
        winnerName = p1name;
        start = Nil;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ wins with a time of %.2f seconds!", p1name, (float)elapsedTime] message:@"Press OK to play again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)resetTap:(id)sender {
    if ([[NSDate date] timeIntervalSinceDate:lastTap] > 0.5) {
        UIAlertView *resetAlert = [[UIAlertView alloc] initWithTitle:@"Reset" message:@"Do you really want to reset the scores?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        [resetAlert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self resetScores];
    }
}

- (void)resetP1Score {
    p1count = 0;
    [p1ScoreLabel setText:[NSString stringWithFormat:@"%d", p1count]];
}

- (void)resetP2Score {
    p2count = 0;
    [p2ScoreLabel setText:[NSString stringWithFormat:@"%d", p2count]];
}

- (void)resetScores {
    [self resetP1Score];
    [self resetP2Score];
    start = Nil;
}

+ (void)setp1Name:(NSString *)toName{
    p1name = toName;
}

+ (void)setp2Name:(NSString *)toName{
    p2name = toName;
}

+ (NSString *)p1Name {
    return p1name;
}

+ (NSString *)p2Name {
    return p2name;
}

+ (NSString *)winnerName {
    return winnerName;
}

+ (NSTimeInterval)elapsedTime {
    return elapsedTime;
}

+ (void)resetWinnerName {
    winnerName = @"";
}

+ (void)resetElapsedTime {
    elapsedTime = 0;
}
@end
