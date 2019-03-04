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
    
    //Creat an instance of NSURLQueryItem called search with search values - term.
    NSURLQueryItem *search = [NSURLQueryItem queryItemWithName: @"search" value: term];
    
    //Assign the contents of search above to the query items of the URL.
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
    
    //Create an error in case decoding fails
    NSError *decodingError = nil;
    
    //Try to decode the JSON
    id decodedObject = [NSJSONSerialization JSONObjectWithData: data options: 0 error: &decodingError];
    
    //What happens if something goes wrong decoding.
    if (decodingError != nil) {
        NSLog(@"Error decoding JSON: %@", decodingError);
        completion(nil, decodingError);
        return;
    }
    
    //What happens if JSON result doesn't come back as a dictionary.
    if ([decodedObject isKindOfClass:[NSDictionary class]] == NO) {
        NSLog(@"JSON result is not a dictionary");
        completion(nil, nil);
        return;
    }
    
    //Declare an array called results to hold the retrieved JSON
    NSArray *results = [decodedObject objectForKey: @"results"];
    
    //What happens if there's no information under the results key in the JSON.
    if ([results isKindOfClass: [NSArray class]] == NO) {
        NSLog(@"JSON doesn't have a results array");
        completion(nil, nil);
        return;
    }
    
    //Set results to be first object in the JSON dictionary i.e. first Person.
    NSDictionary *firstResult = [results firstObject];
    
    //Error if there's no information under first result.
    if ([firstResult isKindOfClass: [NSDictionary class]] == NO) {
        NSLog(@"First JSON result is not a dictionary");
        completion(nil, nil);
        return;
    }
    
    //Create an instance of Person using the info from the first result in JSON
    Person *person = [[Person alloc] init];
    person.name = [firstResult objectForKey: @"name"];
    person.birthYear = [firstResult objectForKey: @"birth_year"];
    person.hairColor = [firstResult objectForKey: @"hair_color"];
    
    //Convert height and mass which are primitives to strings
    NSString *heightString = [firstResult objectForKey: @"height"];
    NSString *massString = [firstResult objectForKey: @"mass"];
    
    person.height = [heightString integerValue];
    person.mass = [massString integerValue];
    
    //Convert homeworld which is a URL to string
    NSString *homeworldString = [firstResult objectForKey:@"homeworld"];
    person.homeworld = [NSURL URLWithString:homeworldString];
    
    //Put all the films for each person JSON result in an array.
    NSArray *filmStrings = [firstResult objectForKey:@"films"];
    
    //Create an array to hold the film urls after building below.
    NSMutableArray *filmURLS = [NSMutableArray array];
    
    for (NSString *filmString in filmStrings) {
        //Convert each film string into a film url.
        NSURL *filmURL = [NSURL URLWithString: filmString];
        //Append the film url to the array
        [filmURLS addObject:filmURL];
    }

    
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
