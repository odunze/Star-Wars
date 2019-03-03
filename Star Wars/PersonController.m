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
NSMutableArray *_savedPeople;

//Implementation of init method declared in H-File
- (instancetype)init {
    self = [super init]; //Self is an instance of NSObject - the superclass.
    if (self != nil) { //If that works
        _savedPeople = [NSMutableArray array]; //Initialise with an empty array
    }
    return self; //Present the class.
}

- (NSArray *)savedPeople {
    return [_savedPeople copy]; //Function to return the people array
}

//Implementation of Save Person method declared in H-File
- (void)savePerson: (Person *)person { //Take type of Person called person no return
    [_savedPeople addObject:person]; //Add person to the array.
}

//Implementation of Remove Saved Person method declared in H-File
- (void)removeSavedPerson: (Person *)person { //Take type of Person called person no return
    [_savedPeople removeObject:person]; //Delete person from the array
}

//Implementation of Save Person method declared in H-File
- (void)searchForPeopleMatchingTerm: (NSString *)term completion: (PersonCompletion)completion { //Take types of String called term, and PersonCompletion called completion, no return.
    
    //Construct a Search URL
    //Create an instance of NSURLComponents called urlComponents.
    NSURLComponents *urlComponents = [[NSURLComponents alloc] init];
    urlComponents.scheme = @"https"; //Set the scheme
    urlComponents.host = @"swapi.co"; //Set the host
    urlComponents.path = @"/api/people/"; //Set the path
    
    NSURLQueryItem *search = [NSURLQueryItem queryItemWithName: @"search" value: term];
    
    urlComponents.queryItems = @[ search ];
    
    //Set instance of NSURL called url to assembled components in urlComponents
    NSURL *url = urlComponents.URL;
    
    //Create the data task from that URL
    NSURLSessionDataTask *task = [[NSURLSession sharedSession]
        dataTaskWithURL: url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            [self processResponse: data error: error completion: completion];
        }];
    
    //Execute / Resume the data task
    [task resume];
}

- (void) processResponse: (NSData *)data error: (NSError *)error completion: (PersonCompletion)completion {
    //When the Data Task Completes:
    //Check for errors
    //Try to decode the JSON
    //Report back via the Completion Handler
    
    //What happens if there's an error.
    if (error != nil) {
        NSLog(@"Error fetching person information: %@", error);
        completion(nil, error);
        return;
    }
    
    //What happens if the data's missing
    if (data == nil) {
        NSLog(@"No error, but missing data");
        completion(nil, nil);
        return;
    }
}


@end
