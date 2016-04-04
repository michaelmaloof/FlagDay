//
//  ViewController.m
//  FlagDay
//
//  Created by Michael Maloof on 4/3/16.
//  Copyright © 2016 Jetpack Dinosaur. All rights reserved.
//

#import "ViewController.h"
#import "Flag.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flagEmoji;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *streakLabel;
@property (weak, nonatomic) IBOutlet UILabel *highscoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *incorrectLabel;
@property (weak, nonatomic) IBOutlet UILabel *correctLabel;
@property (weak, nonatomic) IBOutlet UILabel *displayTimer;

@property NSTimer* answerTimer;
@property int timerSeconds;
@property int totalCorrectAnswers;
@property int totalIncorrectAnswers;
@property int streak;
@property int emojiInt;
@property NSString* answer;
@property NSString* userAnswer;
@property NSUserDefaults* defaults;
@property int theHighScore;
@property Flag *flagObject;
@property (weak, nonatomic) IBOutlet UILabel *medal;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //hide the elements when the app first loads to only show the highscore, start button, and medal
    [self hideElementsForStart];
    
    //load the user's highscore using NSUserDefaults
    [self loadHighscore];
    
    //ints always start at zero so this isn't necersarry, but lets leave it here to remind ourselves that we could save the current streak the user is on so they could continue from where they left off if they leave the app
    self.streak = 0;
}

-(void)hideElementsForStart{
    self.medal.hidden = YES;
    self.flagEmoji.hidden = YES;
    self.answerTextField.hidden = YES;
    self.submitButton.hidden = YES;
    self.streakLabel.hidden = YES;
    self.correctLabel.hidden = YES;
    self.incorrectLabel.hidden = YES;
    self.displayTimer.hidden = YES;
    
    //prevents seeing the text from the storyboard when we unhide
    self.medal.text = @"";
    self.streakLabel.text = @"0";
    self.correctLabel.text = @"";
    self.incorrectLabel.text = @"";
    self.displayTimer.text = @"";

}

-(void)loadHighscore{
    self.defaults = [NSUserDefaults standardUserDefaults];
    self.theHighScore = (int)[self.defaults integerForKey:@"HighScore"];
    self.highscoreLabel.text = [NSString stringWithFormat:@"Highscore: %d",self.theHighScore];
}

//user tapped the start button, begin the game now
- (IBAction)startWasTapped:(id)sender {
    //get the UI ready for the game (mostly unhiding)
    [self prepareGameUI];
    //puts the user into texting mode without them having to click the label
    [self.answerTextField becomeFirstResponder];
    
    //ask the first question
    [self askQuestion];
}

-(void)prepareGameUI {
    self.flagEmoji.hidden = NO;
    self.answerTextField.hidden = NO;
    self.startButton.hidden = YES;
    self.submitButton.hidden = NO;
    self.streakLabel.hidden = NO;
    self.correctLabel.hidden = NO;
    self.incorrectLabel.hidden = NO;
    self.displayTimer.hidden = NO;
}

-(void)askQuestion{
    //the line below alloc and inits the flagObject of the viewController.
    self.flagObject = [[Flag alloc] init];
    //flabObject uses custom class to assign itself a country
    [self.flagObject assignCountry];
    //update the label to show the flags emoji
    self.flagEmoji.text = self.flagObject.emoji;
    
    //add a timer, this time lets count down from 10
    self.timerSeconds = 10;
    self.answerTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                        target: self
                                                      selector:@selector(lessSecond)
                                                      userInfo: nil
                                                       repeats:YES];
}

//subtract one second from the timer
- (void)lessSecond {
    //subtract one and update the lavel
    self.timerSeconds -= 1;
    self.displayTimer.text = [NSString stringWithFormat:@"%d",self.timerSeconds];
    
    //if it hits 0, the answer is wrong and reset the timer
    if (self.timerSeconds == 0) {
        [self.answerTimer invalidate];
        self.streak = 0;
        self.streakLabel.text = [NSString stringWithFormat:@"%d", self.streak];
        [self medalUpdate];
        self.totalIncorrectAnswers += 1;
        self.incorrectLabel.text = [NSString stringWithFormat:@"Total Incorrect: %d", self.totalIncorrectAnswers];
        self.answerTextField.text = nil;
        [self askQuestion];
    }
}

//logic on if you should see the medal next to the high score
-(void)medalUpdate{
    //we dont want the label to have text
    self.medal.text = @"";
    
    //make the label round
    self.medal.layer.cornerRadius = 5.0;
    self.medal.layer.masksToBounds = YES;
    
    //based on the score, change the color of the label
    if (self.theHighScore > 29){
        self.medal.backgroundColor = [UIColor colorWithRed:222.0/255.0 green:185.0/255.0 blue:24.0/255.0 alpha:1.0];
        self.medal.hidden = NO;
    } else if (self.theHighScore > 19){
        self.medal.backgroundColor = [UIColor colorWithRed:193.0/255.0 green:185.0/255.0 blue:186.0/255.0 alpha:1.0];
        self.medal.hidden = NO;
    } else if (self.theHighScore > 9){
        self.medal.backgroundColor = [UIColor colorWithRed:174.0/255.0 green:89.0/255.0 blue:15.0/255.0 alpha:1.0];
        self.medal.hidden = NO;
    } else {
        self.medal.hidden = YES;
    }
}

//user submitted their answer
- (IBAction)submitWasTapped:(id)sender {
    [self resetTimer];
    
    self.userAnswer = self.answerTextField.text;
    //convert to all lowercases to remove casing requirments and take into account the space that auto correct adds while typing
    NSString *countryWithSpace = [NSString stringWithFormat:@"%@ ",self.flagObject.country];
    NSString *lowerUserAnswer = [self.userAnswer lowercaseString];
    NSString *lowerUserAnswerWithSpace = [NSString stringWithFormat:@"%@",lowerUserAnswer];
    
    //answer is correct
    if ([self.flagObject.country isEqualToString: lowerUserAnswer] || [lowerUserAnswerWithSpace isEqualToString:countryWithSpace]) {
        //change the background color to show the answer was correct
        self.view.backgroundColor =  self.view.backgroundColor = [UIColor colorWithRed:171.0/255.0 green:222.0/255.0 blue:165.0/255.0 alpha:1.0];
        //add one to the streak
        self.streak += 1;
        //update streak label
        self.streakLabel.text = [NSString stringWithFormat:@"%d", self.streak];
        //add one to total correct answers
        self.totalCorrectAnswers += 1;
        //update correct label
        self.correctLabel.text = [NSString stringWithFormat:@"Total Correct: %d", self.totalCorrectAnswers];
        //update the medal
        [self medalUpdate];
        //update highscore if applicable
        if (self.streak > self.theHighScore)
        {
            [self saveHighscore];
            [self loadHighscore];
        }
        
        //clear the text field
        self.answerTextField.text = nil;
        //ask another question
        [self askQuestion];
        
    } else {
        //change background color to red to show they were wrong
        self.view.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1.0];
        //update highscore if applicable
        if (self.streak > self.theHighScore) {
            
            [self saveHighscore];
            [self loadHighscore];
        }
        //reset streak and update label
        self.streak = 0;
        self.streakLabel.text = [NSString stringWithFormat:@"%d", self.streak];
        //update medal
        [self medalUpdate];
        //add one to incorrect answers and update label
        self.totalIncorrectAnswers += 1;
        self.incorrectLabel.text = [NSString stringWithFormat:@"Total Incorrect: %d", self.totalIncorrectAnswers];
        //rest text field
        self.answerTextField.text = nil;
        //ask another question
        [self askQuestion];
        
    }

}

//rest the timer
-(void)resetTimer {
    [self.answerTimer invalidate];
    self.answerTimer = nil;
    self.answerTimer = [[NSTimer alloc] init];
    self.timerSeconds = 10;
    self.displayTimer.text = [NSString stringWithFormat:@"%d",self.timerSeconds];
}

//save the highscore
-(void)saveHighscore {
    self.defaults = [NSUserDefaults standardUserDefaults];
    [self.defaults setInteger:self.streak forKey:@"HighScore"];
    [self.defaults synchronize];
}






@end
