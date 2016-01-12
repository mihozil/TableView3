//
//  TableViewController.m
//  UITableView3
//
//  Created by Apple on 1/10/16.
//  Copyright (c) 2016 AMOSC. All rights reserved.
//

#import "TableViewController.h"
#import "Person.h"

@interface TableViewController ()<UIAlertViewDelegate> <UITextFieldDelegate>;

@end

@implementation TableViewController{
    NSMutableArray* dataarray;
}

- (void) initProject{
        self.navigationController.navigationBarHidden = false;
    dataarray= [[NSMutableArray alloc]initWithCapacity:10];
    self.tableView.allowsMultipleSelectionDuringEditing = true;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProject];
    [self arrayCreating];
    [self OnAdding];
    [self groupDelete];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void) groupDelete{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(OnEditing)];
}
- (void) OnEditing{
    
    [self.tableView setEditing:true animated:YES];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Delete" style:UIBarButtonItemStylePlain target:self action:@selector(onDelete)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(onDone)];

    
}
- (void) onDone{
    
      [self.tableView setEditing:false animated:YES];
    
    if (dataarray.count>0) self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(OnEditing)];
    else self.navigationItem.leftBarButtonItem = nil;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(addOn)];
    
}

- (void) onDelete{
    // choose clicks
    NSArray* selectedrows= self.tableView.indexPathsForSelectedRows;
    
    NSMutableIndexSet *dataremove = [[NSMutableIndexSet alloc]init];
    
    // delete from array
    for (int i=0; i<selectedrows.count; i++){
        NSIndexPath* path = selectedrows[i];
        [dataremove addIndex:path.row];
    }
    [dataarray removeObjectsAtIndexes:dataremove];
    
    [self.tableView deleteRowsAtIndexPaths:selectedrows withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // delete from tableview
}


- (void) OnAdding{
  
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(addOn)];
}
- (void) addOn{
    if (dataarray.count==0){
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(OnEditing)];
    }
    
    UIAlertView*alertview = [[UIAlertView alloc]initWithTitle:@"Enter detail" message:@"Full name and Age" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    
    alertview.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    
    UITextField*fullname = [alertview textFieldAtIndex:0];
    fullname.placeholder = @"Enter Full Name";
    
    UITextField*age = [alertview textFieldAtIndex:1];
    age.placeholder = @"Enter Age";
    age.secureTextEntry = NO;

    
    [alertview show];
    
    // add to array
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    UITextField*fullname = [alertView textFieldAtIndex:0];
    
    UITextField*age = [alertView textFieldAtIndex:1];
    
    Person* person= [[Person alloc]init];
    
    person.name =fullname.text;// [NSString stringWithFormat:fullname.text];
    person.age = [age.text intValue];
    
    [dataarray addObject:person];
    
    [self.tableView reloadData];
    
}


- (void) arrayCreating{
    for (int i=0; i<5; i++){
        Person* person = [[Person alloc]init];
        [dataarray addObject:person];
    }
    
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    Person *person = dataarray[sourceIndexPath.row];
    
    [dataarray removeObjectAtIndex:sourceIndexPath.row];
    [dataarray insertObject:person atIndex:destinationIndexPath.row];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return dataarray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    Person* person = dataarray[indexPath.row];
    
    cell.textLabel.text = person.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",(long)person.age];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [dataarray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
