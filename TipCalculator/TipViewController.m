//
//  TipViewController.m
//  TipCalculator
//
//  Created by Leo Kong on 12/31/14.
//  Copyright (c) 2014 Leo Kong. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

- (IBAction)onTap:(id)sender;
- (void)updateValues;
- (void)onSettingsButton;
@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    // Call the init method implemented by the superclass
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator";
    }
    
    //Return the address of the new object
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger indexValue = [defaults integerForKey:@"index"];
    if (indexValue >= 0 || indexValue < 4) {
        self.tipControl.selectedSegmentIndex = indexValue;
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
    [self updateValues];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues {
    float billAmount = [self.billTextField.text floatValue];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    float customTipPercent = [[defaults objectForKey:@"customTipPercent"] floatValue];
    
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2), @(customTipPercent)];
    if (customTipPercent > 0) {
        [self.tipControl setTitle:[NSString stringWithFormat:@"%0.0f%%", customTipPercent * 100] forSegmentAtIndex:3];
    }
    
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = tipAmount + billAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
};

- (void)onSettingsButton; {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}
@end
