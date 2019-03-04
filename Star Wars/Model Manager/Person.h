//
//  Person.h
//  Star Wars
//
//  Created by Lotanna Igwe-Odunze on 3/2/19.
//  Copyright © 2019 Lotanna Igwe-Odunze. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *hairColor;
@property (nonatomic, copy) NSString *birthYear;
@property (nonatomic, copy) NSString *homeworld;
@property (nonatomic) NSInteger height;
@property (nonatomic) NSInteger mass;


@end

NS_ASSUME_NONNULL_END
