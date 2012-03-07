//
//  FlipViewController.h
//  Tap Game
//
//  Created by Bruce Collie on 01/03/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAD.h>

@interface FlipViewController : UIViewController <UITextFieldDelegate, ADBannerViewDelegate, UIActionSheetDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *player1NameEntry;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *player2NameEntry;
@property (unsafe_unretained, nonatomic) IBOutlet UIStepper *maxScoreStepper;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *maxScoreLabel;
@property (unsafe_unretained, nonatomic) IBOutlet ADBannerView *adBanner;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *score1Name;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *score2Name;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *score3Name;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *score4Name;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *score5Name;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *score1Score;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *score2Score;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *score3Score;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *score4Score;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *score5Score;

- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)resetButtonPressed:(id)sender;
- (void)writeScoresToPlistWithScores:(NSDictionary *)scores;
+ (NSDictionary *)loadScoresPlist;
@end
