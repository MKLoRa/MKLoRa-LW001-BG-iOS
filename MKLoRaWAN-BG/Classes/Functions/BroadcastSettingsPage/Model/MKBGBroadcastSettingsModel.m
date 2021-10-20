//
//  MKBGBroadcastSettingsModel.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/26.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGBroadcastSettingsModel.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKBGInterface.h"
#import "MKBGInterface+MKBGConfig.h"

@interface MKBGBroadcastSettingsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKBGBroadcastSettingsModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readADVName]) {
            [self operationFailedBlockWithMsg:@"Read Adv Name Error" block:failedBlock];
            return;
        }
        if (![self readUUID]) {
            [self operationFailedBlockWithMsg:@"Read UUID Error" block:failedBlock];
            return;
        }
        if (![self readMajor]) {
            [self operationFailedBlockWithMsg:@"Read Major Error" block:failedBlock];
            return;
        }
        if (![self readMinor]) {
            [self operationFailedBlockWithMsg:@"Read Minor Error" block:failedBlock];
            return;
        }
        if (![self readRssi]) {
            [self operationFailedBlockWithMsg:@"Read Rssi@1m Error" block:failedBlock];
            return;
        }
        if (![self readTxPower]) {
            [self operationFailedBlockWithMsg:@"Read Tx Power Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self checkParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        if (![self configADVName]) {
            [self operationFailedBlockWithMsg:@"Config Adv Name Error" block:failedBlock];
            return;
        }
        if (![self configUUID]) {
            [self operationFailedBlockWithMsg:@"Config UUID Error" block:failedBlock];
            return;
        }
        if (![self configMajor]) {
            [self operationFailedBlockWithMsg:@"Config Major Error" block:failedBlock];
            return;
        }
        if (![self configMinor]) {
            [self operationFailedBlockWithMsg:@"Config Minor Error" block:failedBlock];
            return;
        }
        if (![self configRssi]) {
            [self operationFailedBlockWithMsg:@"Config Rssi@1m Error" block:failedBlock];
            return;
        }
        if (![self configTxPower]) {
            [self operationFailedBlockWithMsg:@"Config Tx Power Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface
- (BOOL)readADVName {
    __block BOOL success = NO;
    [MKBGInterface bg_readDeviceNameWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.advName = returnData[@"result"][@"deviceName"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configADVName {
    __block BOOL success = NO;
    [MKBGInterface bg_configDeviceName:self.advName sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readUUID {
    __block BOOL success = NO;
    [MKBGInterface bg_readBeaconProximityUUIDWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.uuid = [returnData[@"result"][@"uuid"] stringByReplacingOccurrencesOfString:@"-" withString:@""];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configUUID {
    __block BOOL success = NO;
    [MKBGInterface bg_configBeaconProximityUUID:self.uuid sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMajor {
    __block BOOL success = NO;
    [MKBGInterface bg_readBeaconMajorWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.major = returnData[@"result"][@"major"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMajor {
    __block BOOL success = NO;
    [MKBGInterface bg_configMajor:[self.major integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMinor {
    __block BOOL success = NO;
    [MKBGInterface bg_readBeaconMinorWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.minor = returnData[@"result"][@"minor"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMinor {
    __block BOOL success = NO;
    [MKBGInterface bg_configMinor:[self.minor integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readRssi {
    __block BOOL success = NO;
    [MKBGInterface bg_readMeasuredPowerWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.measuredPower = [returnData[@"result"][@"measuredPower"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configRssi {
    __block BOOL success = NO;
    [MKBGInterface bg_configMeasuredPower:self.measuredPower sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readTxPower {
    __block BOOL success = NO;
    [MKBGInterface bg_readTxPowerWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSString *txPower = returnData[@"result"][@"txPower"];
        self.txPower = [self fetchTxPower:txPower];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configTxPower {
    __block BOOL success = NO;
    [MKBGInterface bg_configTxPower:self.txPower sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"bleSettingsParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (NSInteger)fetchTxPower:(NSString *)txPower {
    if ([txPower isEqualToString:@"-40dBm"]) {
        return 0;
    }
    if ([txPower isEqualToString:@"-20dBm"]) {
        return 1;
    }
    if ([txPower isEqualToString:@"-16dBm"]) {
        return 2;
    }
    if ([txPower isEqualToString:@"-12dBm"]) {
        return 3;
    }
    if ([txPower isEqualToString:@"-8dBm"]) {
        return 4;
    }
    if ([txPower isEqualToString:@"-4dBm"]) {
        return 5;
    }
    if ([txPower isEqualToString:@"0dBm"]) {
        return 6;
    }
    if ([txPower isEqualToString:@"2dBm"]) {
        return 7;
    }
    if ([txPower isEqualToString:@"3dBm"]) {
        return 8;
    }
    if ([txPower isEqualToString:@"4dBm"]) {
        return 9;
    }
    if ([txPower isEqualToString:@"5dBm"]) {
        return 10;
    }
    if ([txPower isEqualToString:@"6dBm"]) {
        return 11;
    }
    if ([txPower isEqualToString:@"7dBm"]) {
        return 12;
    }
    if ([txPower isEqualToString:@"8dBm"]) {
        return 13;
    }
}

- (BOOL)checkParams {
    if (self.advName.length > 13) {
        return NO;
    }
    if (!ValidStr(self.uuid) || ![self.uuid regularExpressions:isHexadecimal] || self.uuid.length != 32) {
        return NO;
    }
    if (!ValidStr(self.major) || [self.major integerValue] < 0 || [self.major integerValue] > 65535) {
        return NO;
    }
    if (!ValidStr(self.minor) || [self.minor integerValue] < 0 || [self.minor integerValue] > 65535) {
        return NO;
    }
    if (self.txPower < 0 || self.txPower > 13) {
        return NO;
    }
    if (self.measuredPower < -127 || self.measuredPower > 0) {
        return NO;
    }
    return YES;
}

#pragma mark - getter
- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

- (dispatch_queue_t)readQueue {
    if (!_readQueue) {
        _readQueue = dispatch_queue_create("bleSettingsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
