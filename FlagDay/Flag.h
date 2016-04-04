//
//  Flag.h
//  FlagDay
//
//  Created by Michael Maloof on 4/4/16.
//  Copyright © 2016 Jetpack Dinosaur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Flag : NSObject;

@property NSString *emoji;
@property NSString *country;
@property NSString *capital;
- (void)assignCountry;


@end
