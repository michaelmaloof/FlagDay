//
//  Flag.m
//  FlagDay
//
//  Created by Michael Maloof on 4/4/16.
//  Copyright © 2016 Jetpack Dinosaur. All rights reserved.
//

#import "Flag.h"

@implementation Flag

- (void) assignCountry {
    
    int emojiInt = arc4random_uniform(11);
    
    if (emojiInt == 0) {
        
        self.emoji = @"🇩🇪";//Germany
        self.country = @"germany";
        
    }else if (emojiInt == 1) {
        
        self.emoji = @"🇫🇷";//France
        self.country = @"france";
        
    }else if (emojiInt == 2) {
        
        self.emoji = @"🇨🇭";//Switzerland
        self.country = @"switzerland";
        
    }else if (emojiInt == 3) {
        
        self.emoji = @"🇧🇷";//Brazil
        self.country = @"brazil";
        
    }else if (emojiInt == 4) {
        
        self.emoji = @"🇬🇷";//Greece
        self.country = @"greece";
        
    }else if (emojiInt == 5) {
        
        self.emoji = @"🇧🇪";//Belgium
        self.country = @"belgium";
    }else if (emojiInt == 6) {
        
        self.emoji = @"🇯🇵";//Japan
        self.country = @"japan";
    }else if (emojiInt == 7) {
        
        self.emoji = @"🇳🇱";//Netherlands
        self.country = @"netherlands";
    }else if (emojiInt == 8) {
        
        self.emoji = @"🇦🇺";//Australia
        self.country = @"australia";
    }else if (emojiInt == 9) {
        
        self.emoji = @"🇨🇦";//Canada
        self.country = @"canada";
    }else if (emojiInt == 10) {
        
        self.emoji = @"🇺🇸";//United States of America
        self.country = @"usa";
        
    }else if (emojiInt == 11) {
        
        self.emoji = @"🇮🇹";//Italy
        self.country = @"italy";
        
    }else if (emojiInt == 12) {
        
        self.emoji = @"🇵🇪";//Peru
        self.country = @"peru";
        
    }else if (emojiInt == 13) {
        
        self.emoji = @"🇹🇷";//Turkey
        self.country = @"turkey";
        
    }else if (emojiInt == 14) {
        
        self.emoji = @"🇳🇴";//Norway
        self.country = @"norway";
        
    }else if (emojiInt == 15) {
        
        self.emoji = @"🇨🇱";//Chile
        self.country = @"chile";
        
    }else if (emojiInt == 16) {
        
        self.emoji = @"🇩🇰";//Denmark
        self.country = @"denmark";
        
    }else if (emojiInt == 17) {
        
        self.emoji = @"🇨🇳";//China
        self.country = @"china";
        
    }else if (emojiInt == 18) {
        
        self.emoji = @"🇨🇺";//Cuba
        self.country = @"cuba";
        
    }else if (emojiInt == 19) {
        
        self.emoji = @"🇫🇮";//Finland
        self.country = @"finland";
        
    }else if (emojiInt == 20) {
        
        self.emoji = @"🇬🇪";//Georgia
        self.country = @"georgia";
        
    }else if (emojiInt == 21) {
        
        self.emoji = @"🇲🇽";//Mexico
        self.country = @"mexico";
        
    }
    
}

@end
