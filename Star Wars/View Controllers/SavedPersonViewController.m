//
//  SavedPersonViewController.m
//  Star Wars
//
//  Created by Lotanna Igwe-Odunze on 3/4/19.
//  Copyright © 2019 Lotanna Igwe-Odunze. All rights reserved.
//

#import "SavedPersonViewController.h"
#import "PersonController.h" //Import Person Controller so I can refer to it.
#import "DetailViewController.h"
#import "SearchViewController.h"

@interface SavedPersonViewController ()

//Assign instance of Person Controller to property
@property (nonatomic, readonly)PersonController *personController;

@end

@implementation SavedPersonViewController

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
        
        DetailViewController *dvc = segue destinationViewController;
        
        
        
    } else if ([segue.identifier isEqualToString:@"searchSegue"]){
        
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
