//
//  ClientForm.m
//  Nestle base client
//
//  Created by Cesar Jacquet on 22/01/2015.
//  Copyright (c) 2015 c-bleu. All rights reserved.
//

#import "ClientForm.h"
#import "DBManager.h"

@interface ClientForm ()

@property (nonatomic, strong) DBManager *dbManager;

-(void)loadInfoToEdit;

@end


@implementation ClientForm

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	
	// Make self the delegate of the textfields.
	self.txtFirstname.delegate = self;
	self.txtLastname.delegate = self;
	self.txtEmail.delegate = self;
	
	
	// Check if should load specific record for editing.
	if (self.recordIDToEdit != -1) {
		// Load the record with the specific ID from the database.
		[self loadInfoToEdit];
	}

}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


#pragma mark - UITextFieldDelegate method implementation

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return YES;
}


#pragma mark - IBAction method implementation

- (IBAction)saveInfo:(id)sender {
	// Prepare the query string.
	// If the recordIDToEdit property has value other than -1, then create an update query. Otherwise create an insert query.
	NSString *query;
	if (self.recordIDToEdit == -1) {
		query = [NSString stringWithFormat:@"insert into clientInfo values(null, '%@', '%@', '%@')", self.txtFirstname.text, self.txtLastname.text, self.txtEmail.text];
	}
	else{
		query = [NSString stringWithFormat:@"update clientInfo set firstname='%@', lastname='%@', email='%@' where clientInfoID=%d", self.txtFirstname.text, self.txtLastname.text, self.txtEmail.text, self.recordIDToEdit];
	}
	
	
	// Execute the query.
	[self.dbManager executeQuery:query];
	
	// If the query was successfully executed then pop the view controller.
	if (self.dbManager.affectedRows != 0) {
		NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
		
		// Pop the view controller.
		[self.navigationController popViewControllerAnimated:YES];
	}
	else{
		NSLog(@"Could not execute the query.");
	}
}


#pragma mark - Private method implementation

-(void)loadInfoToEdit{
	// Create the query.
	NSString *query = [NSString stringWithFormat:@"select * from clientInfo where clientInfoID=%d", self.recordIDToEdit];
	
	// Load the relevant data.
	NSArray *results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
	
	// Set the loaded data to the textfields.
	self.txtFirstname.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"firstname"]];
	self.txtLastname.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"lastname"]];
	self.txtEmail.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"email"]];
}

@end
