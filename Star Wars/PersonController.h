//
//  PersonController.h
//  Star Wars
//
//  Created by Lotanna Igwe-Odunze on 3/2/19.
//  Copyright © 2019 Lotanna Igwe-Odunze. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Person; //Forward declaration to use Person here. Can also #import Person.h

//Typealias called PersonCompletion, of completion closure that expects either a Person or an Error. Addition of _Nullable allows for nil value for each.
typedef void(^PersonCompletion)(Person * _Nullable, NSError * _Nullable);

NS_ASSUME_NONNULL_BEGIN

//Class declaration of PersonController
@interface PersonController : NSObject

//Declaration of a mutable array to hold people
@property (nonatomic, readonly) NSArray *savedPeople;

//Init function with return - instancetype to return an instance.
- (instancetype)init;

//Functions with no return but take person parameter.
-(void)savePerson: (Person *) person;

-(void)removeSavedPerson: (Person *) person;

//Function that takes String called term, with completion closure that takes type PersonCompletion called completion.
-(void)searchForPeopleMatchingTerm: (NSString *)term completion: (PersonCompletion)completion;

@end

NS_ASSUME_NONNULL_END
