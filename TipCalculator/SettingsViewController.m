//
//  SettingsViewController.m
//  TipCalculator
//
//  Created by Leo Kong on 1/4/15.
//  Copyright (c) 2015 Leo Kong. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipPercent;
@property (weak, nonatomic) IBOutlet UILabel *customTipPercent;
@property (weak, nonatomic) IBOutlet UISlider *customTipSlider;
- (IBAction)customTipPercentChanged:(id)sender;
- (IBAction)onTapDefaultTip:(id)sender;
- (void)updateCustomTipPercent;
- (void)saveTipSelection;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    float customTipPercent = [[defaults objectForKey:@"customTipPercent"] floatValue];
    NSInteger indexValue = [defaults integerForKey:@"index"];
        
    if (customTipPercent > 0) {
        self.customTipSlider.value = customTipPercent * 100;
    } else {
        self.customTipSlider.value = 0;
    }
    [self updateCustomTipPercent];

    
    if (indexValue >= 0 || indexValue < 4)
    {
        self.defaultTipPercent.selectedSegmentIndex = indexValue;
        
    } else {
        self.defaultTipPercent.selectedSegmentIndex = 0;
    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)customTipPercentChanged:(id)sender {
    [self updateCustomTipPercent];
    [self saveTipSelection];
}

- (IBAction)onTapDefaultTip:(id)sender {
    [self saveTipSelection];
}

- (void)updateCustomTipPercent {
    self.customTipPercent.text = [NSString stringWithFormat:@"%0.0f%%", self.customTipSlider.value];
}

- (void)saveTipSelection {
    float customTipPercent = [self.customTipPercent.text floatValue] / 100;
    int currentDefaultTipSelectedIndex = (int) self.defaultTipPercent.selectedSegmentIndex;
    
    NSUserDefaults *defaultTipSettings = [NSUserDefaults standardUserDefaults];
    [defaultTipSettings setFloat:customTipPercent forKey:@"customTipPercent"];
    [defaultTipSettings setInteger:currentDefaultTipSelectedIndex forKey:@"index"];
    [defaultTipSettings synchronize];
}
@end
