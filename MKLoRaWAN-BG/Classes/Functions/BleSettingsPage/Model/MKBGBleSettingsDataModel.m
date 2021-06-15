//
//  MKBGBleSettingsDataModel.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/26.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGBleSettingsDataModel.h"

#import "MKMacroDefines.h"

#import "MKBGInterface.h"
#import "MKBGInterface+MKBGConfig.h"

@interface MKBGBleSettingsDataModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKBGBleSettingsDataModel

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readBeaconMode]) {
            [self operationFailedBlockWithMsg:@"Read Beacon Mode Error" block:failedBlock];
            return;
        }
        if (![self readConnectable]) {
            [self operationFailedBlockWithMsg:@"Read Connectable Error" block:failedBlock];
            return;
        }
        if (![self readADVInterval]) {
            [self operationFailedBlockWithMsg:@"Read Adv Interval Error" block:failedBlock];
            return;
        }
        if (![self readBroadcastTimeout]) {
            [self operationFailedBlockWithMsg:@"Read Broadcast Timeout Error" block:failedBlock];
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
        NSString *checkMsg = [self checkParam];
        if (ValidStr(checkMsg)) {
            [self operationFailedBlockWithMsg:checkMsg block:failedBlock];
            return;
        }
        if (self.beaconModeIsOn) {
            if (![self configADVInterval]) {
                [self operationFailedBlockWithMsg:@"Config Adv Interval Error" block:failedBlock];
                return;
            }
        }else {
            if (![self configBroadcastTimeout]) {
                [self operationFailedBlockWithMsg:@"Config Broadcast Timeout Error" block:failedBlock];
                return;
            }
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface
- (BOOL)readBeaconMode {
    __block BOOL success = NO;
    [MKBGInterface bg_readBeaconModeStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.beaconModeIsOn = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readConnectable {
    __block BOOL success = NO;
    [MKBGInterface bg_readDeviceConnectableWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.connectable = [returnData[@"result"][@"connectable"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readADVInterval {
    __block BOOL success = NO;
    [MKBGInterface bg_readBeaconAdvIntervalWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.advInterval = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configADVInterval {
    __block BOOL success = NO;
    [MKBGInterface bg_configBeaconAdvInterval:[self.advInterval integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readBroadcastTimeout {
    __block BOOL success = NO;
    [MKBGInterface bg_readDeviceBroadcastTimeoutWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.broadcastTimeout = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configBroadcastTimeout {
    __block BOOL success = NO;
    [MKBGInterface bg_configDeviceBroadcastTimeout:[self.broadcastTimeout integerValue] sucBlock:^{
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

- (NSString *)checkParam {
    if (self.beaconModeIsOn) {
        if (!ValidStr(self.advInterval) || [self.advInterval integerValue] < 1 || [self.advInterval integerValue] > 100) {
            return @"ADV Interval range is 1~100";
        }
    }else {
        if (!ValidStr(self.broadcastTimeout) || [self.broadcastTimeout integerValue] < 1 || [self.broadcastTimeout integerValue] > 60) {
            return @"Broadcast Timeout range is 1~60";
        }
    }
    
    return @"";
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
