//
//  DetailViewController.h
//  Star Wars
//
//  Created by Lotanna Igwe-Odunze on 3/4/19.
//  Copyright © 2019 Lotanna Igwe-Odunze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "PersonController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

//Person property to receive index path and build details
@property (nonatomic, strong, nullable) Person *person;
@property (nonatomic, strong, nullable) PersonController * personController;



@end

NS_ASSUME_NONNULL_END
