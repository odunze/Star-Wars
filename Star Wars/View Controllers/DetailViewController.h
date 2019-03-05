//
//  DetailViewController.h
//  Star Wars
//
//  Created by Lotanna Igwe-Odunze on 3/4/19.
//  Copyright © 2019 Lotanna Igwe-Odunze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

//Declare properties the view controller needs. A person, and a person controller.
@property (nonatomic, strong, nullable) Person *person;

@property (nonatomic, strong) PersonController *personController;

@end

NS_ASSUME_NONNULL_END
