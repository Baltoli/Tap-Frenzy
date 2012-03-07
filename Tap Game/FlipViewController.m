//
//  FlipViewController.m
//  Tap Game
//
//  Created by Bruce Collie on 01/03/2012.
//  Copyright (c) 2012 Balerno High School. All rights reserved.
//

#import "FlipViewController.h"
#import "BSCViewController.h"

@interface FlipViewController ()

@end

@implementation FlipViewController
@synthesize player1NameEntry;
@synthesize player2NameEntry;
@synthesize maxScoreStepper;
@synthesize maxScoreLabel;
@synthesize adBanner;
@synthesize score1Name;
@synthesize score2Name;
@synthesize score3Name;
@synthesize score4Name;
@synthesize score5Name;
@synthesize score1Score;
@synthesize score2Score;
@synthesize score3Score;
@synthesize score4Score;
@synthesize score5Score;
NSDictionary *scoresData;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self player1NameEntry] setText:[BSCViewController p1Name]];
    [[self player2NameEntry] setText:[BSCViewController p2Name]];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    scoresData = [FlipViewController loadScoresPlist];
    NSString *winnerName = [BSCViewController winnerName];
    NSTimeInterval elapsedTime = [BSCViewController elapsedTime];
    if (([BSCViewController winnerName] != @"") && ([BSCViewController elapsedTime] != 0)) {
        [self addScoreWithName:winnerName withScore:[NSNumber numberWithFloat:elapsedTime] toScoreList:scoresData];
        [BSCViewController resetWinnerName];
        [BSCViewController resetElapsedTime];
    }
    //NSLog([[[scoresData objectForKey:@"Root"] objectForKey:@"Names"] objectAtIndex:0]);
    [self updateHighScoreTable];
    /*for (int i = 0; i < [[[scoresData objectForKey:@"Root"] objectForKey:@"Names"] count]; i++) {
     NSLog([self getNameFromData:scoresData forIndex:i]);
     NSLog([[self getScoreFromData:scoresData forIndex:i] stringValue]);
     }*/
    //NSLog(@"%@", [[[scoresData objectForKey:@"Root"] objectForKey:@"Names"] objectAtIndex:0]);
    [self writeScoresToPlistWithScores:scoresData];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setPlayer1NameEntry:nil];
    [self setPlayer2NameEntry:nil];
    [self setMaxScoreStepper:nil];
    [self setMaxScoreLabel:nil];
    [self setScore1Name:nil];
    [self setScore2Name:nil];
    [self setScore3Name:nil];
    [self setScore4Name:nil];
    [self setScore5Name:nil];
    [self setScore1Score:nil];
    [self setScore2Score:nil];
    [self setScore3Score:nil];
    [self setScore4Score:nil];
    [self setScore5Score:nil];
    [self setAdBanner:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)doneButtonPressed:(id)sender {
    if ([[[self player1NameEntry] text] length] > 0) {
        [BSCViewController setp1Name:[[self player1NameEntry] text]];
    }
    else {
        [BSCViewController setp1Name:@"Player 1"];
    }
    if ([[[self player2NameEntry] text] length] > 0) {
        [BSCViewController setp2Name:[[self player2NameEntry] text]];
    }
    else {
        [BSCViewController setp2Name:@"Player 2"];
    }
    [self writeScoresToPlistWithScores:scoresData];
    [self performSegueWithIdentifier:@"settingsToMainGame" sender:self];
}

- (IBAction)resetButtonPressed:(id)sender {
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"Really reset scores?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Reset" otherButtonTitles: nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        for (int i = 0; i < 5; i++) {
            [self addScoreWithName:@"N/A" withScore:[NSNumber numberWithInt:0] toScoreList:scoresData];
        }
        [self updateHighScoreTable];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if ((theTextField == self.player1NameEntry) || (theTextField == self.player2NameEntry)) {
        [theTextField resignFirstResponder];
    }
    return YES;
}

- (void)updateHighScoreTable {
    //NSLog([[[scoresData objectForKey:@"Root"] objectForKey:@"Names"] objectAtIndex:0]);
    [score1Name setText:[[[scoresData objectForKey:@"Root"] objectForKey:@"Names"] objectAtIndex:0]];
    [score2Name setText:[[[scoresData objectForKey:@"Root"] objectForKey:@"Names"] objectAtIndex:1]];
    [score3Name setText:[[[scoresData objectForKey:@"Root"] objectForKey:@"Names"] objectAtIndex:2]];
    [score4Name setText:[[[scoresData objectForKey:@"Root"] objectForKey:@"Names"] objectAtIndex:3]];
    [score5Name setText:[[[scoresData objectForKey:@"Root"] objectForKey:@"Names"] objectAtIndex:4]];
    float score1val = [[[[scoresData objectForKey:@"Root"] objectForKey:@"Scores"] objectAtIndex:0] floatValue];
    float score2val = [[[[scoresData objectForKey:@"Root"] objectForKey:@"Scores"] objectAtIndex:1] floatValue];
    float score3val = [[[[scoresData objectForKey:@"Root"] objectForKey:@"Scores"] objectAtIndex:2] floatValue];
    float score4val = [[[[scoresData objectForKey:@"Root"] objectForKey:@"Scores"] objectAtIndex:3] floatValue];
    float score5val = [[[[scoresData objectForKey:@"Root"] objectForKey:@"Scores"] objectAtIndex:4] floatValue];
    [score1Score setText:[NSString stringWithFormat:@"%.2f", score1val]];
    [score2Score setText:[NSString stringWithFormat:@"%.2f", score2val]];
    [score3Score setText:[NSString stringWithFormat:@"%.2f", score3val]];
    [score4Score setText:[NSString stringWithFormat:@"%.2f", score4val]];
    [score5Score setText:[NSString stringWithFormat:@"%.2f", score5val]];
}

-(void)addScoreWithName:(NSString *)name withScore:(NSNumber *)score toScoreList:(NSDictionary *)scoreList{
    NSMutableArray *names = (NSMutableArray *)[[scoreList objectForKey:@"Root"] objectForKey:@"Names"];
    NSMutableArray *scores = (NSMutableArray *)[[scoreList objectForKey:@"Root"] objectForKey:@"Scores"];
    for (int i = 0; i < [scores count]; i++) {
        if ([score floatValue] <= [[scores objectAtIndex:i] floatValue]) {
            [scores insertObject:score atIndex:i];
            [names insertObject:name atIndex:i];
            break;
        }
        else if ([[scores objectAtIndex:i] floatValue] == 0){
            [scores insertObject:score atIndex:i];
            [names insertObject:name atIndex:i];
            break;
        }
    }
    while ([scores count] > 5) {
        [scores removeLastObject];
    }
    while ([names count] > 5) {
        [names removeLastObject];
    }
}

+ (NSDictionary *)loadScoresPlist {
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:@"scores.plist"];
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];
    [[NSFileManager defaultManager] removeItemAtPath:plistPath error:Nil];
    if (!temp) {
        NSArray *players = [[NSArray alloc] initWithObjects:@"Player 1", @"Player 2", nil];
        NSArray *names = [[NSArray alloc] initWithObjects:@"N/A", @"N/A", @"N/A", @"N/A", @"N/A", nil];
        NSArray *scores = [[NSArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:0],
                           [[NSNumber alloc] initWithInt:0],
                           [[NSNumber alloc] initWithInt:0],
                           [[NSNumber alloc] initWithInt:0],
                           [[NSNumber alloc] initWithInt:0],nil];
        NSArray *objects = [[NSArray alloc] initWithObjects:names, scores, players, nil];
        NSDictionary *newPlist = [[NSDictionary alloc] initWithObjects:objects forKeys:
                                  [[NSArray alloc] initWithObjects:@"Names", @"Scores", @"Players", nil]];
        NSDictionary *finalPlist = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:newPlist, nil] forKeys:[[NSArray alloc] initWithObjects:@"Root", nil]];
        [finalPlist writeToFile:plistPath atomically:YES];
        NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
        NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                              propertyListFromData:plistXML
                                              mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                              format:&format
                                              errorDescription:&errorDesc];
        return temp;
        //NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
    //NSLog(@"Read from %@", plistPath);
    return temp;
}

- (NSString *)getNameFromData:(NSDictionary *)plistData forIndex:(NSUInteger)index {
    NSString *ret = [[[plistData objectForKey:@"Root"] objectForKey:@"Names"] objectAtIndex:index];
    return ret;
}

- (NSNumber *)getScoreFromData:(NSDictionary *)plistData forIndex:(NSUInteger)index {
    NSNumber *ret = [[[plistData objectForKey:@"Root"] objectForKey:@"Scores"] objectAtIndex:index];
    return ret;
}

- (void)updateScoresRow:(NSUInteger)row WithScores:(NSDictionary *)scores andName:(NSString *)name andScore:(NSNumber *)score {
    [[[scores objectForKey:@"Root"] objectForKey:@"Names"] replaceObjectAtIndex:row withObject:name];
    [[[scores objectForKey:@"Root"] objectForKey:@"Scores"] replaceObjectAtIndex:row withObject:score];
}

- (void)writeScoresToPlistWithScores:(NSDictionary *)scores {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"scores.plist"];
    [scores writeToFile:plistPath atomically:YES];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [banner setHidden:YES];
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    [banner setHidden:NO];
}
@end
