//
//  TMPCoffeeBuyingViewController.m
//  TakeMePayExample
//
//  Created by tianren.zhu on 2019/1/2.
//  Copyright © 2019 JapanFoodie. All rights reserved.
//

#import "TMPCoffeeBuyingViewController.h"
#import <TakeMePaySDK/TakeMePaySDK.h>
#import <TakeMePaySDK/TMPPaymentServiceClient.h>

typedef NS_ENUM(NSInteger, TMPExampleResult) {
    TMPCoffeeDeliveryPaymentSuccessResult,
    TMPCoffeeDeliveryPaymentFailedResult,
    TMPCoffeeDeliveryPaymentCanceled
};

@interface TMPCoffeeBuyingViewController () <TMPPaymentDelegate>

@property (nonatomic, assign) BOOL inProgress;

@end

@implementation TMPCoffeeBuyingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.    
}

- (IBAction)pay:(id)sender {
    if (self.inProgress) {
        return;
    }
    
    // avoid double-touch behavior
    self.inProgress = YES;
    
    // 1. init a source params with necessary information.
    TMPSourceParams *params = [[TMPSourceParams alloc] initWithDescription:@"Coffee Delivery Service" amount:10 currency:@"JPY"];
    
    // 2. create TMPPayment from sourceParams, ephemerKeyProvider and delegate.
    TMPPayment *payment = [[TMPPayment alloc] initWithSourceParams:params delegate:self];
    
    // 3. start payment action. ( with optional tapic engine impact )
    [payment startPaymentAction:@{@"useTapicEngine" : @(YES)}];
}

#pragma mark - private

- (void)alertWithResult:(TMPExampleResult)result {
    NSDictionary<NSNumber *, NSString *> *titles = @{
                                                     @(TMPCoffeeDeliveryPaymentFailedResult) : @"Payment failed",
                                                     @(TMPCoffeeDeliveryPaymentCanceled) : @"Payment canceled",
                                                     @(TMPCoffeeDeliveryPaymentSuccessResult) : @"Payment succeeded"
                                                     };
    
    NSDictionary<NSNumber *, NSString *> *messages = @{
                                                      @(TMPCoffeeDeliveryPaymentFailedResult) : @"Payment failed with specific payment method, please check the logs",
                                                      @(TMPCoffeeDeliveryPaymentCanceled) : @"You canceled the payment",
                                                      @(TMPCoffeeDeliveryPaymentSuccessResult) : @"You got a coffee :)"
                                                      };
    
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:titles[@(result)] message:messages[@(result)] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertViewController addAction:cancel];
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

#pragma mark - TMPPaymentDelegate

- (void)payment:(TMPPayment *)payment didFinishWithState:(TMPPaymentResultState)state userInfo:(NSDictionary *)userInfo {
    // reset inProgress flag
    self.inProgress = NO;
    
    if (state == TMPPaymentResultStateSuccess) {
        [self alertWithResult:TMPCoffeeDeliveryPaymentSuccessResult];
    } else if (state == TMPPaymentResultStateCanceled) {
        [self alertWithResult:TMPCoffeeDeliveryPaymentCanceled];
    } else {
        [self alertWithResult:TMPCoffeeDeliveryPaymentFailedResult];
    }
}

@end
