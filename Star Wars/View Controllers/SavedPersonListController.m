//
//  SavedPersonListController.m
//  Star Wars
//
//  Created by Lotanna Igwe-Odunze on 3/4/19.
//  Copyright © 2019 Lotanna Igwe-Odunze. All rights reserved.
//

#import "SavedPersonListController.h"
#import "PersonController.h" //Import Person Controller so I can refer to it.
#import "DetailViewController.h"

@interface SavedPersonListController ()

//Assign instance of Person Controller to property
@property (nonatomic, readonly)PersonController *personController;

@end

@implementation SavedPersonListController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Initialise instance of Person Controller declared above
    _personController = [[PersonController alloc] init];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.personController.savedPeople.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"starCell" forIndexPath:indexPath];
    
    
    //Create a local instance of Perosn called person
    Person *person = [self.personController.savedPeople objectAtIndex: indexPath.row];
    
    //Assign the cell's title label text to the person's name.
    cell.textLabel.text = person.name;
    
    return cell;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Create a local instance of the Person
        Person *person = [self.personController.savedPeople objectAtIndex: indexPath.row];
        //Delete it from the array
        [self.personController removeSavedPerson:person];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a local instance of the Person
        Person *person = [self.personController.savedPeople objectAtIndex: indexPath.row];
        //Insert it into the array
        [self.personController savePerson:person];
        
        //Add a new row to the table view
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

    }   
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqual:@"viewSegue"]) {
        
        //Assign the segue destination view controller to a property
        DetailViewController *dvc = segue.destinationViewController;
        
        //Create an instance of the index path of the row.
        NSIndexPath *selectedRow = self.tableView.indexPathForSelectedRow;
        
        //Isolate the row number
        NSInteger row = selectedRow.row; //Don't use pointer * here.
        
        //Retrieve the instance of Person at the row index in the array
        Person *person = [self.personController.savedPeople objectAtIndex:row];
        
        dvc.person = person;
        dvc.personController = self.personController;
        
    } else if ([segue.identifier isEqualToString:@"searchSegue"]){
        
        DetailViewController *dvc = segue.destinationViewController;
        
        dvc.personController = self.personController;
        
    }
}


@end
