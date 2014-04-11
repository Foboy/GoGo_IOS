//
//  FBBillTableViewController.m
//  GoGoPay-IOS
//
//  Created by cray on 4/3/14.
//  Copyright (c) 2014 foboy. All rights reserved.
//

#import "FBBillTableViewController.h"
#import "FBBill.h"
#import "FBBillByMonth.h"
#import "FBBillCell.h"

@interface FBBillTableViewController ()

@end

@implementation FBBillTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bills = [NSMutableArray arrayWithCapacity:20];
    
    FBBillByMonth *current = [[FBBillByMonth alloc] init];
    current.bills = [NSMutableArray arrayWithCapacity:20];
    current.month = @"本月";
    FBBill *bill = [[FBBill alloc] init];
    bill.name = @"张三";
    bill.phone = @"187*****987";
    bill.date =@"04-09 12:34";
    bill.payMethod = 1;
    bill.amount = 3235332.32f;
    [current.bills addObject:bill];
    
    FBBill *bill2 = [[FBBill alloc] init];
    bill2.name = @"张三";
    bill2.phone = @"187*****987";
    bill2.date =@"04-09 12:34";
    bill2.payMethod = 2;
    bill2.goamount = 10;
    [current.bills addObject:bill2];
    
    FBBillByMonth *current2 = [[FBBillByMonth alloc] init];
    current2.bills = [NSMutableArray arrayWithCapacity:20];
    current2.month = @"三月";
    FBBill *bill3 = [[FBBill alloc] init];
    bill3.name = @"张三";
    bill3.phone = @"187*****987";
    bill3.date =@"04-09 12:34";
    bill3.payMethod = 1;
    bill3.amount = 223.03f;
    [current2.bills addObject:bill3];
    
    FBBill *bill21 = [[FBBill alloc] init];
    bill21.name = @"张三";
    bill21.phone = @"187*****987";
    bill21.date =@"04-09 12:34";
    bill21.payMethod = 2;
    bill21.goamount = 254;
    [current2.bills addObject:bill21];
    
    [self.bills addObject:current];
    [self.bills addObject:current2];
    
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return self.bills.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return ((FBBillByMonth *)[self.bills objectAtIndex:section]).bills.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BillCell";
    FBBillCell *cell = (FBBillCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    FBBill *bill = ((FBBillByMonth *)self.bills[indexPath.section]).bills[indexPath.row];
    // Configure the cell...
    cell.ibBillNameAndPhoneLabel.text = [NSString stringWithFormat:@"%@(%@)",bill.name,bill.phone];
    cell.ibBillDateLabel.text = bill.date;
    if (bill.payMethod == 1) {
        cell.ibBillPayMethodLabel.text = @"拉卡拉";
        cell.ibBillAmountLabel.text = [self floatToDecimalString:bill.amount];
    }
    else
    {
        cell.ibBillPayMethodLabel.text =@"GO币支付";
        cell.ibBillAmountLabel.text = [NSString stringWithFormat:@"%dGO币",bill.goamount];
    }
    return cell;
}

-(NSString *)floatToDecimalString:(float)amount
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:amount]];
    return [NSString stringWithFormat:@"%@元",formattedNumberString];
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return ((FBBillByMonth *)self.bills[section]).month;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
