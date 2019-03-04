//
//  DetailViewController.m
//  Star Wars
//
//  Created by Lotanna Igwe-Odunze on 3/4/19.
//  Copyright © 2019 Lotanna Igwe-Odunze. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *heightLabel;
@property (weak, nonatomic) IBOutlet UILabel *massLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthYearLabel;
@property (weak, nonatomic) IBOutlet UIButton *savePersonButton;



@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar.delegate = self;
    [self hideViews];
    [self updateViews];
}

//Equivalent of DidSet in Swift for person property
- (void)setPerson: (Person *)person {
    _person = person;
    [self updateViews];
}

//Hide the search bar and the save button for detail viewing
- (void)hideViews {
    self.savePersonButton.hidden = YES;
    if (self.person == nil) { return; }
    self.searchBar.hidden = YES;
}

//Saves the person found to the list / array.
- (IBAction)savePerson: (id)sender { //IBAction with sender Any. id means Any.
    if (self.person == nil) { return; } //Don't save unless a person has been loaded
    
    [self.personController savePerson: self.person];
    [self.navigationController popViewControllerAnimated:YES]; //Return to list view
}

//Put the information about the person found or viewed on the screen.
- (void)updateViews {
    if (self.isViewLoaded == NO) { return; }
    
    if (self.person == nil) {
        self.title = @"Person Search";
        self.nameLabel.text = @"";
        self.heightLabel.text = @"";
        self.massLabel.text = @"";
        self.birthYearLabel.text = @"";
    } else {
        self.title = self.person.name;
        self.nameLabel.text = self.person.name;
        self.birthYearLabel.text = self.person.birthYear;
        
        //Must convert these to strings since they are primitives
        
        NSNumber *massNumber = @(self.person.mass); //Primitive to NSNumber
        NSString *mass = [NSNumberFormatter localizedStringFromNumber:massNumber numberStyle: NSNumberFormatterDecimalStyle]; //Number to String
        self.massLabel.text = mass; //Assign String

        NSNumber *heightNumber = @(self.person.mass); //Primitive to NSNumber
        NSString *height = [NSNumberFormatter localizedStringFromNumber:heightNumber numberStyle: NSNumberFormatterDecimalStyle]; //Number to String
        self.heightLabel.text = height; //Assign String
    }
}


//Search Delegate Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    NSString *text = searchBar.text;
    if (text.length == 0) { return; }
    
    [self.personController searchForPeopleMatchingTerm: text completion:^(Person * _Nullable person, NSError * _Nullable error) {
        self.person = person;
        self.savePersonButton.hidden = NO;
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
