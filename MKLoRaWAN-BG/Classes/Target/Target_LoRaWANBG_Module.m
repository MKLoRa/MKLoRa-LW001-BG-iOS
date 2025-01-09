//
//  Target_LoRaWANBG_Module.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "Target_LoRaWANBG_Module.h"

#import "MKBGOptionsController.h"

#import "MKBGScanController.h"

#import "MKBGAboutController.h"

@implementation Target_LoRaWANBG_Module

/// 设备类型选择页面
- (UIViewController *)Action_LoRaWANBG_Module_OptionsController:(NSDictionary *)params {
    return [[MKBGOptionsController alloc] init];
}

/// 扫描页面
- (UIViewController *)Action_LoRaWANBG_Module_ScanController:(NSDictionary *)params {
    MKBGScanController *vc = [[MKBGScanController alloc] init];
    vc.needCharging = [params[@"needCharging"] boolValue];
    vc.proType = [params[@"proType"] integerValue];
    return [[MKBGScanController alloc] init];
}

/// 关于页面
- (UIViewController *)Action_LoRaWANBG_Module_AboutController:(NSDictionary *)params {
    return [[MKBGAboutController alloc] init];
}

@end
