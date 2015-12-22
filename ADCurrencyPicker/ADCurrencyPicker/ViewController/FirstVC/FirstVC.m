//
//  FirstVC.m
//  ADCurrencyPicker
//
//  Created by Adnan on 12/10/15.
//  Copyright © 2015 TheGoal. All rights reserved.
//

#import "FirstVC.h"
#import "Constants.h"
#import "CurrencySelectVC.h"


@interface FirstVC ()<CurrencyDelegate>

@property (weak, nonatomic) IBOutlet UILabel *currencyDetailLabel;

@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)currencyBtnPressed:(id)sender {
    CurrencySelectVC *currencySelectVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CurrencySelectVC"];
    [currencySelectVC setDelegate:self];
    [self.navigationController pushViewController:currencySelectVC animated:YES];
    
}

#pragma mark - CurrencyDelegate Method
-(void) country:(CurrencySelectVC *)country didChangeValue:(id)value{
      [country setDelegate:nil];
    NSDictionary *countryDict = value;
    self.currencyDetailLabel.text=[NSString stringWithFormat:@"Country Name:%@ CountryCode:%@ CurrencyCode:%@ CurrencySymbol:%@",[countryDict objectForKey:COUNTRY_NAME],[countryDict objectForKey:COUNTRY_CODE],[countryDict objectForKey:CURRENCY_CODE],[countryDict objectForKey:CURRENCY_SYMBOL]];
}


@end
