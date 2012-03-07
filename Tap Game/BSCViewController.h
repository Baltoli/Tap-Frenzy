//
//  BSCViewController.h
//  Tap Game
//
//  Created by Bruce Collie on 01/03/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSCViewController : UIViewController <UIAlertViewDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *player1Button;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *player2Button;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *p1ScoreLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *p2ScoreLabel;
//@property (unsafe_unretained, nonatomic) NSString *p1name;
//@property (unsafe_unretained, nonatomic) NSString *p2name;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;

- (IBAction)player2ButtonTap:(id)sender;
- (IBAction)player1ButtonTap:(id)sender;
- (IBAction)resetTap:(id)sender;
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)resetP2Score;
- (void)resetP1Score;
+ (NSString *)p1Name;
+ (NSString *)p2Name;
+ (NSString *)winnerName;
+ (NSTimeInterval)elapsedTime;
+ (void)setp1Name:(NSString *)toName;
+ (void)setp2Name:(NSString *)toName;
+ (void)resetWinnerName;
+ (void)resetElapsedTime;
@end
