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
#import "FBGlobalConfig.h"
#import "ISRefreshControl.h"
#import "FBDataResult.h"
#import "NSDictionary+CaseIgnore.h"

@interface FBBillTableViewController ()

@end

@implementation FBBillTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.pageIndex = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bills = [NSMutableArray arrayWithCapacity:20];
    self.realbills =[[NSArray alloc] init];
    
    
    [self reloadBills];
    
    self.refreshControl = (id)[[ISRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(refresh)
                  forControlEvents:UIControlEventValueChanged];
    


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)refresh
{
    //int64_t delayInSeconds = 4.0;
    //dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    //dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //update view
        [self reloadBills];
    
    //});
}

-(void)reloadBills
{
    __block MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    FBGlobalConfig *config = [FBGlobalConfig sharedConfig];
    NSDictionary *parameters = @{@"page_index": [NSString stringWithFormat:@"%d",self.pageIndex ]};
    
    
    [FBGlobalConfig POST:config.billListUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        FBDataResult *result = [[FBDataResult alloc] initWithJSONResponse:responseObject];
        if (result.Error == ERROR_SUCCESS) {
            NSArray *billsList = result.Data;
            
            
            [self.refreshControl endRefreshing];
            [self bindBills:billsList];
            NSLog(@"查询成功 %@",self.bills);
            [hud hide:YES afterDelay:0.0f];
        }
        else
        {
            hud.mode = MBProgressHUDModeText;
            hud.labelText = result.ErrorMessage;
            [hud hide:YES afterDelay:1.5f];
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"Error: %@",error);
    }];
}

-(void)bindBills:(NSArray *) billsList
{
    FBBillByMonth *month = nil;
    
    int monthNumber = 0;
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    
    for (NSDictionary* billdic in billsList) {
        FBBill* bill = [[FBBill alloc] init];
        bill.amount = [[billdic objectForCaseInsensitiveKey:@"amount"] floatValue];
        bill.name = [billdic objectForCaseInsensitiveKey:@"username"];
        bill.phone =[billdic objectForCaseInsensitiveKey:@"mobile"];
        id paymethod =[billdic objectForCaseInsensitiveKey:@"pay_mothed"];
        if (paymethod != nil && paymethod != [NSNull null]) {
            bill.payMethod =[paymethod intValue];
        }
        id gocoin =[billdic objectForCaseInsensitiveKey:@"go_coin"];
        if (gocoin != nil && gocoin != [NSNull null]) {
            bill.goamount =[gocoin intValue];
        }
        
        NSLog(@"%@",[billdic objectForKey:@"create_time"]);
        NSDate *date= [NSDate date];
        id create =[billdic objectForCaseInsensitiveKey:@"create_time"];
        if (create != nil && create != [NSNull null]) {
            date=[NSDate dateWithTimeIntervalSince1970:[create intValue]];
        }
        
        [format setDateFormat:@"MM-dd hh:mm"];
        bill.date = [format stringFromDate:date];
        [format setDateFormat:@"yyyyMM"];
        monthNumber = [[format stringFromDate:date] intValue];
        if (month == nil) {
            FBBillByMonth *newmonth = [[FBBillByMonth alloc] init];
            [self.bills addObject:newmonth];
            month = newmonth;
            month.bills = [NSMutableArray arrayWithCapacity:20];
            month.monthNumber = monthNumber;
            month.month = [self dateAsMonth:monthNumber now:[[format stringFromDate:[NSDate date]] intValue]];
        }
        else if (month.monthNumber != monthNumber)
        {
            FBBillByMonth *newmonth = [[FBBillByMonth alloc] init];
            [self.bills addObject:newmonth];
            month = newmonth;
            month.bills = [NSMutableArray arrayWithCapacity:20];
            month.monthNumber = monthNumber;
            month.month = [self dateAsMonth:monthNumber now:[[format stringFromDate:[NSDate date]] intValue]];
        }

        [month.bills addObject:bill];
    }
    
    [self.tableView reloadData];
}

-(NSString *)dateAsMonth:(int)date now:(int)now
{
    NSLog(@"date:%d",date);
    NSLog(@"now:%d",now);
    if(now/100 == date/100)
    {
        if(now == date)
        {
            return @"本月";
        }
        else
        {
            return [NSString stringWithFormat:@"%d月",date - date/100*100];
        }
    }
    else
    {
        return [NSString stringWithFormat:@"%d年%d月",date/100,date - date/100*100];
    }
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
        cell.ibBillPayMethodLabel.text =@"GO币支付";
        cell.ibBillAmountLabel.text = [NSString stringWithFormat:@"%dGO币",bill.goamount];

    }
    else
    {
        cell.ibBillPayMethodLabel.text = @"拉卡拉";
        cell.ibBillAmountLabel.text = [FBGlobalConfig floatToDecimalString:bill.amount];
    }
    return cell;
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
