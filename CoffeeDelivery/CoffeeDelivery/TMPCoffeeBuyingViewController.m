//
//  TMPCoffeeBuyingViewController.m
//  TakeMePayExample
//
//  Created by tianren.zhu on 2019/1/2.
//  Copyright © 2019 JapanFoodie. All rights reserved.
//

#import "TMPCoffeeBuyingViewController.h"

typedef NS_ENUM(NSInteger, TMPExampleResult) {
    TMPCoffeeDeliveryPaymentSuccessResult,
    TMPCoffeeDeliveryPaymentFailedResult,
    TMPCoffeeDeliveryPaymentCanceled
};

@interface TMPCoffeeBuyingViewController ()

@property (nonatomic, assign) BOOL inProgress;

@end

@implementation TMPCoffeeBuyingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.    
}

- (IBAction)pay:(id)sender {
    
}

#pragma mark - private

- (void)alertWithResult:(TMPExampleResult)result {
    NSDictionary<NSNumber *, NSString *> *titles = @{
                                                     @(TMPCoffeeDeliveryPaymentFailedResult) : @"Payment failed",
                                                     @(TMPCoffeeDeliveryPaymentCanceled) : @"Payment canceled",
                                                     @(TMPCoffeeDeliveryPaymentSuccessResult) : @"Payment success"
                                                     };
    
    NSDictionary<NSNumber *, NSString *> *messages = @{
                                                      @(TMPCoffeeDeliveryPaymentFailedResult) : @"Payment error with specific payment method, please check the logs",
                                                      @(TMPCoffeeDeliveryPaymentCanceled) : @"You canceled the payment",
                                                      @(TMPCoffeeDeliveryPaymentSuccessResult) : @"You got a coffee :)"
                                                      };
    
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:titles[@(result)] message:messages[@(result)] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertViewController addAction:cancel];
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

@end
