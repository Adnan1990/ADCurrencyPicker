# IOSControls

ADCurrencyPicker is designed for choosing currency code,currency symbol, country code and country ,name from list of 106 countries.

![alt tag](https://raw.githubusercontent.com/Adnan1990/IOSControls/master/screen1.png)


![alt tag](https://raw.githubusercontent.com/Adnan1990/IOSControls/master/screen2.png)


![alt tag](https://raw.githubusercontent.com/Adnan1990/IOSControls/master/screen0.png)


# Usage

##### #import "CurrencySelectVC.h"
while presenting currencySelectVC you have to set delegate as self to get delegate method values against selected country.


###### #pragma mark - IBAction
```
- (IBAction)currencyBtnPressed:(id)sender {
    CurrencySelectVC *currencySelectVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CurrencySelectVC"];
    [currencySelectVC setDelegate:self];
    [self.navigationController pushViewController:currencySelectVC animated:YES];
    
}
```
you have to confirm CurrencyDelegate in ViewController where you want the selected country info.

`-(void) country:(CurrencySelectVC *)country didChangeValue:(id)value;` method will return the country details



###### #pragma mark - CurrencyDelegate Method
```
-(void) country:(CurrencySelectVC *)country didChangeValue:(id)value{
      [country setDelegate:nil];
    NSDictionary *countryDict = value;
    self.currencyDetailLabel.text=[NSString stringWithFormat:@"Country Name:%@ CountryCode:%@ CurrencyCode:%@ CurrencySymbol:%@",[countryDict objectForKey:COUNTRY_NAME],[countryDict objectForKey:COUNTRY_CODE],[countryDict objectForKey:CURRENCY_CODE],[countryDict objectForKey:CURRENCY_SYMBOL]];
}
```

