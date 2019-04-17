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
    TMPExamplePaymentSuccessResult,
    TMPExamplePaymentFailedResult
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
    TMPSourceParams *params = [[TMPSourceParams alloc] initWithDescription:@"Coffee Delivery Service" amount:1 currency:@"JPY"];
    
    // 2. create TMPPayment from sourceParams, ephemerKeyProvider and delegate.
    TMPPayment *payment = [[TMPPayment alloc] initWithSourceParams:params delegate:self];
    
    // 3. start payment action. ( with optional tapic engine impact )
    [payment startPaymentAction:@{@"useTapicEngine" : @(YES)}];
}

#pragma mark - private

- (void)alertWithResult:(TMPExampleResult)result {
    NSDictionary<NSNumber *, NSString *> *titles = @{
                                                     @(TMPExamplePaymentFailedResult) : @"Payment error",
                                                     @(TMPExamplePaymentSuccessResult) : @"Payment success"
                                                     };
    
    NSDictionary<NSNumber *, NSString *> *messages = @{
                                                      @(TMPExamplePaymentFailedResult) : @"Payment error with specific payment method, please check the logs",
                                                      @(TMPExamplePaymentSuccessResult) : @"You got a coffee :)"
                                                      };
    
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:titles[@(result)] message:messages[@(result)] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertViewController addAction:cancel];
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

#pragma mark - TMPPaymentDelegate

- (void)payment:(TMPPayment *)payment didFinishWithState:(TMPPaymentRequestState)state userInfo:(NSDictionary *)userInfo {
    // reset inProgress flag
    self.inProgress = NO;
    
    if (state == TMPPaymentRequestStateSuccess) {
        [self alertWithResult:TMPExamplePaymentSuccessResult];
    } else {
        [self alertWithResult:TMPExamplePaymentFailedResult];
    }
}

@end
