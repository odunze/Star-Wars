//
//  SavedPersonListController.m
//  Star Wars
//
//  Created by Lotanna Igwe-Odunze on 3/4/19.
//  Copyright © 2019 Lotanna Igwe-Odunze. All rights reserved.
//

#import "SavedPersonListController.h"
//Import Person Controller and Detail View Controller so I can refer to them.
#import "DetailViewController.h"
#import "PersonController.h"

@interface SavedPersonListController ()

//Assign instance of Person Controller to property
@property (nonatomic, readonly) PersonController *personController;

@end

@implementation SavedPersonListController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Initialise the instance of Person Controller declared above
    _personController = [[PersonController alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //Reload the table view data to reflect each change.
    [self.tableView reloadData];
}

#pragma mark - Table view data source

//Set up the rows.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.personController.savedPeople.count;
}

//Set up the cell.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Dequeue the cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCell" forIndexPath:indexPath];
    
    //Create a local instance of Person called person
    Person *person = [self.personController.savedPeople objectAtIndex:indexPath.row];
    
    //Assign the cell's title label text to the person's name.
    cell.textLabel.text = person.name;
    
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Create a local instance of the Person
        Person *person = [self.personController.savedPeople objectAtIndex:indexPath.row];
        
        //Delete it from the array
        [self.personController removeSavedPerson:person];
        
        // Delete the row from the table view.
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Navigation

//Retrieve the instance of Person at the row index in the array
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqual:@"ShowPerson"]) {
        
        //Assign the segue destination view controller to a property
        DetailViewController *dvc = segue.destinationViewController;
        
        //Create an instance of the index path of the row.
        NSIndexPath *selectedRow = self.tableView.indexPathForSelectedRow;
        
        //Isolate the row number
        NSInteger row = selectedRow.row; //Don't use pointer * here.

        //Pull the instance of person at the row index array
        Person *person = [self.personController.savedPeople objectAtIndex:row];
        
        //Assign the person to the detail view controller's person
        dvc.person = person;
        
        //Make sure the detail view controller is using the same person controller.
        dvc.personController = self.personController;
        
    } else if ([segue.identifier isEqualToString:@"searchSegue"]) {
        //Assign the segue destination view controller to a property
        DetailViewController *dvc = segue.destinationViewController;
        
        //Make sure the detail view controller is using the same person controller.
        dvc.personController = self.personController;
    }
    
}

@end
