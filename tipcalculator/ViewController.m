//
//  ViewController.m
//  tipcalculator
//
//  Created by Vijay Ramakrishnan on 12/21/14.
//  Copyright (c) 2014 Vijay Ramakrishnan. All rights reserved.
//

#import "ViewController.h"
#import "SettingsViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
- (IBAction)onTap:(id)sender;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateValues];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [self getandSetSegmentValues];
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)getandSetSegmentValues {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *keys = @[@"p1", @"p2", @"p3"];
    bool areAllZeroTillNow = true;
    for (int i = 0; i < keys.count; i++) {
        NSString *key = [keys objectAtIndex:i];
        int segment = [defaults integerForKey:key];
        areAllZeroTillNow = areAllZeroTillNow && (segment == 0);
        [self.tipControl setTitle:[NSString stringWithFormat:@"%d%%", segment]
                forSegmentAtIndex:i];
        [defaults setInteger:segment forKey:key];
    }
    
    if (areAllZeroTillNow) {
        //set defaults
        NSArray *defaultValues = @[@10, @15, @20];
        for (int i = 0; i<keys.count; i++) {
            NSString *key = [keys objectAtIndex:i];
            NSNumber *val = [defaultValues objectAtIndex:i];
            [self.tipControl setTitle:[NSString stringWithFormat:@"%@%%", val]
                    forSegmentAtIndex:i];
            [defaults setInteger:[val integerValue] forKey:key];
        }
    }
}

- (void)updateValues {
    float billAmount = [self.billTextField.text floatValue];
    float segmentValue = [self.tipControl titleForSegmentAtIndex: self.tipControl.selectedSegmentIndex].floatValue/100.0;
    
    float tipAmount = billAmount * segmentValue;
    float totalAmount = tipAmount + billAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

@end
