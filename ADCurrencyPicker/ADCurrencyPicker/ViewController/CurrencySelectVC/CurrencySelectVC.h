//
//  CurrencySelectVC.h
//  ADCurrencyPicker
//
//  Created by Adnan on 12/10/15.
//  Copyright © 2015 TheGoal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CurrencySelectVC;

@protocol CurrencyDelegate <NSObject>

@optional

-(void)country:(CurrencySelectVC *)country didChangeValue:(id)value;

@end


@interface CurrencySelectVC : UIViewController

@property (nonatomic, assign) id<CurrencyDelegate> delegate;

@end
