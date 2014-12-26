//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Vijay Ramakrishnan on 12/22/14.
//  Copyright (c) 2014 Vijay Ramakrishnan. All rights reserved.
//

#import "SettingsViewController.h"
#import "utils.h"

@interface SettingsViewController ()
@property (nonatomic, strong) IBOutletCollection(UITextField) NSArray *percentages;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self setPercentagesInUI];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self setPercentagesInUserDictionary];
}

- (IBAction)onSettingsTap:(id)sender {
    [self.view endEditing:YES];
    [self setPercentagesInUserDictionary];
}

- (void)setPercentagesInUI {
    NSMutableArray * test = [utils getTipPercentages];
    int index = 0;
    for (UITextField *textField in self.percentages) {
        textField.text = [NSString stringWithFormat:@"%@", [test objectAtIndex:index]];
        index++;
    }
}

-(void)setPercentagesInUserDictionary {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *keys = @[@"p1", @"p2", @"p3"];
    
    int index = 0;
    for (UITextField *textField in self.percentages) {
        NSInteger n = [textField.text integerValue];
        [defaults setInteger:n forKey:[keys objectAtIndex:index]];
        index++;
    }
    [defaults synchronize];
}

@end
