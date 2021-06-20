//
//  Target_LoRaWANBG_Module.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "Target_LoRaWANBG_Module.h"

#import "MKBGScanController.h"

#import "MKBGAboutController.h"

@implementation Target_LoRaWANBG_Module

/// 扫描页面
- (UIViewController *)Action_LoRaWANBG_Module_ScanController:(NSDictionary *)params {
    return [[MKBGScanController alloc] init];
}

/// 关于页面
- (UIViewController *)Action_LoRaWANBG_Module_AboutController:(NSDictionary *)params {
    return [[MKBGAboutController alloc] init];
}

@end
