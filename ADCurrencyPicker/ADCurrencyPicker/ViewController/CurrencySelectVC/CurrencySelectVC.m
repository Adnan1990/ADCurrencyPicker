//
//  CurrencySelectVC.m
//  ADCurrencyPicker
//
//  Created by Adnan on 12/10/15.
//  Copyright © 2015 TheGoal. All rights reserved.
//

#import "CurrencySelectVC.h"
#import "Constants.h"

@interface CurrencySelectVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSMutableArray *countryList;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation CurrencySelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//If you did not specify delegate and data source in story board,uncomment below lines
//    [self.tableView setDelegate:self];
//    [self.tableView setDataSource:self];
    
    self.selectedIndex = -1;
    [self setUpNavigationBar];
    [self loadCountries];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custum methods

-(void) setUpNavigationBar {
    
    UIButton *rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn addTarget:self action:@selector(doneBtnAction:) forControlEvents:UIControlEventTouchDown];
    rightBtn.frame=CGRectMake(0, 3.0, 60.0, 30.0);
    [rightBtn setTitle:@"Done" forState:UIControlStateNormal];

    UIBarButtonItem *rightbarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightbarButtonItem;
}

-(void) loadCountries{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"currency" ofType:@"plist"];
    self.countryList =[NSMutableArray arrayWithContentsOfFile:filePath];
    [self.tableView reloadData];
}

-(void) doneBtnAction:(UIButton *) sender{
    
    if (self.selectedIndex !=-1) {
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(country:didChangeValue:)]){
            [self.delegate country:self didChangeValue:[self.countryList objectAtIndex:self.selectedIndex]];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        UIAlertController *alert=   [UIAlertController
                                      alertControllerWithTitle:@"oooops"
                                      message:@"You have not selected any currency.Please select some currency!"
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
   
}

-(void) backbuttonAction:(id) sender{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.countryList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"countyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *country = [self.countryList objectAtIndex:indexPath.row] ;
    
    UILabel *countryNameLabel = (UILabel *)[cell viewWithTag:100];
    countryNameLabel.text = [country objectForKey:COUNTRY_NAME];
    
    UIImageView *flagImageView = (UIImageView *)[cell viewWithTag:101];
    flagImageView.image = [UIImage imageNamed:[country objectForKey:COUNTRY_CODE]];
    flagImageView.contentMode = UIViewContentModeScaleAspectFit;
    flagImageView.clipsToBounds =YES;
    
    UILabel *currencysymbolLabel = (UILabel *)[cell viewWithTag:102];
    currencysymbolLabel.text = [NSString stringWithFormat:@"%@ %@",[country objectForKey:CURRENCY_CODE],[country objectForKey:CURRENCY_SYMBOL]];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if (self.selectedIndex == indexPath.row)
       cell.accessoryType =UITableViewCellAccessoryCheckmark;
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndex =indexPath.row;
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndex =-1;
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}


@end
