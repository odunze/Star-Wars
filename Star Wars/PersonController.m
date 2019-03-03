//
//  PersonController.m
//  Star Wars
//
//  Created by Lotanna Igwe-Odunze on 3/2/19.
//  Copyright © 2019 Lotanna Igwe-Odunze. All rights reserved.
//

#import "PersonController.h"

@implementation PersonController

//Implementation of 

//Implementation of init method declared in H-File
- (instancetype)init {
    self = [super init]; //Self is an instance of NSObject - the superclass.
    if (self != nil) { //If that works
        
    }
    return self; //Present the class.
}

//Implementation of Save Person method declared in H-File
- (void)savePerson: (Person *)person { //Take type of Person called person no return
    
}

//Implementation of Remove Saved Person method declared in H-File
- (void)removeSavedPerson: (Person *)person { //Take type of Person called person no return
    
}

//Implementation of Save Person method declared in H-File
- (void)searchForPeopleMatchingTerm: (NSString *)term completion: (PersonCompletion)completion { //Take types of String called term, and PersonCompletion called completion, no return.
    
}


@end
