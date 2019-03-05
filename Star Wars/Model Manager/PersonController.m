//
//  PersonController.m
//  Star Wars
//
//  Created by Lotanna Igwe-Odunze on 3/2/19.
//  Copyright © 2019 Lotanna Igwe-Odunze. All rights reserved.
//

#import "PersonController.h"

@implementation PersonController {
    NSMutableArray *_savedPeople; //Implementation of

}

//Implementation of init method declared in H-File
- (instancetype)init {
    self = [super init]; //Self is an instance of NSObject - the superclass.
    if (self != nil) {   //If it exists...
        _savedPeople = [NSMutableArray array]; //Initialise with an empty array
    }
    return self; //Present the class.
}

//Function with no parameters but returns the people array
- (NSArray *)savedPeople {
    return [_savedPeople copy];
}

//Implementation of Save Person method declared in H-File
- (void)savePerson:(Person *)person { //Takes parameter of type Person called person. No return
    [_savedPeople addObject:person]; //Add person to the array.
}

//Implementation of Remove Saved Person method declared in H-File
- (void)removeSavedPerson:(Person *)person { //Takes type of Person called person no return

    [_savedPeople removeObject:person]; //Delete person from the array

}

//Implementation of Search for Person method declared in H-File

- (void)searchForPeopleMatchingTerm:(NSString *)term completion:(PersonCompletion)completion { //Take types of String called term, and PersonCompletion called completion, no return.
    
    //Construct a Search URL
    NSURLComponents *urlComponents = [[NSURLComponents alloc] init]; //Create an instance of NSURLComponents called urlComponents.
    
    urlComponents.scheme = @"https"; //Set the scheme
    urlComponents.host = @"swapi.co"; //Set the host
    urlComponents.path = @"/api/people/"; //Set the path
    
    //Create an instance of NSURLQueryItem called search with search value term above
    NSURLQueryItem *search = [NSURLQueryItem queryItemWithName:@"search" value:term];
    
    //Assign the contents of search above to the query items of the URL.
    urlComponents.queryItems = @[ search ];
    
    //Set instance of NSURL called url to assembled components in urlComponents
    NSURL *url = urlComponents.URL;
    
    //Create the data task from that URL
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //Call the process Response function and pass in the data, error, and person
        [self processResponse:data error:error completion:^(Person *person, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(person, error);
            }); //End of Dispatch Queue Async
            
        }]; //End of processing response
        
    }]; //End of Data Task.
//Execute / Resume the Data Task
    [task resume];
}

#pragma mark - Private Methods

//When the Data Task Completes:













//Implement a function to process the resulting JSON.
- (void)processResponse:(NSData *)data error:(NSError *)error completion:(PersonCompletion)completion {
    
    //What happens if there's an error.
    if (error != nil) {
        NSLog(@"Error fetching person information: %@", error);
        completion(nil, error);
        return;
    }
    
    //What happens if the data's missing
    if (data == nil) {
        NSLog(@"No error, but missing data???");
        // maybe i should create an NSError to report here?
        completion(nil, nil);
        return;
    }
    
    //Create an error in case decoding fails
    NSError *decodingError = nil;
    
    //Try to decode the JSON
    NSDictionary *decodedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&decodingError];
    
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
    
    //Create an array called results to hold the retrieved JSON.
    //Assign the list of people contained under the results key to results array.
    NSArray *results = [decodedObject objectForKey:@"results"];
    
    //What happens if there's no information under the results key in the JSON.
    if ([results isKindOfClass:[NSArray class]] == NO) {
        NSLog(@"JSON does not have results array");
        completion(nil, nil);
        return;
    }
    
    //Set results to be first object in the JSON dictionary i.e. first Person.
    NSDictionary *firstResult = [results firstObject];
    
    //Error if there's no information under first result.
    if ([firstResult isKindOfClass:[NSDictionary class]] == NO) {
        NSLog(@"First JSON result is not a dictionary");
        completion(nil, nil);
        return;
    }
    
    //Create an instance of Person using the info from the first result in JSON
    Person *person = [[Person alloc] init];
    person.name = [firstResult objectForKey:@"name"];
    person.birthYear = [firstResult objectForKey:@"birth_year"];
    person.hairColor = [firstResult objectForKey:@"hair_color"];
    
    //Convert height and mass which are primitives to strings
    NSString *heightString = [firstResult objectForKey:@"height"];
    NSString *massString = [firstResult objectForKey:@"mass"];
    
    person.height = [heightString integerValue];
    person.mass = [massString integerValue];
    
    //Convert homeworld which is a URL to string
    NSString *homeworldString = [firstResult objectForKey:@"homeworld"];
    person.homeworld = [NSURL URLWithString:homeworldString];
    
    //Put all the films for each person JSON result in an array.
    NSArray *filmStrings = [firstResult objectForKey:@"films"];
    
    //Create an array to hold the film urls after building below.
    NSMutableArray *filmURLs = [NSMutableArray array];
    
    for (NSString *filmString in filmStrings) {
        
        //Convert each film string into a film url.
        NSURL *filmURL = [NSURL URLWithString:filmString];
        
        //Append the film url to the array
        [filmURLs addObject:filmURL]; 
    }
    person.films = filmURLs; //Assign the film array to the person's films.
    
    //Report back what happened via the Completion Handler
    completion(person, nil);
}

@end







    

    





