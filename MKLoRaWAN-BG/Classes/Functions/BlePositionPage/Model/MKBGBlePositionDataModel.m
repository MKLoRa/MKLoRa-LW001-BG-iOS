//
//  MKBGBlePositionDataModel.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/21.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGBlePositionDataModel.h"

#import "MKMacroDefines.h"

#import "MKBGInterface.h"
#import "MKBGInterface+MKBGConfig.h"

@interface MKBGBlePositionDataModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKBGBlePositionDataModel

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError * error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readPositioningTimeout]) {
            [self operationFailedBlockWithMsg:@"Read Positioning Timeout Error" block:failedBlock];
            return;
        }
        if (![self readNumberOfMAC]) {
            [self operationFailedBlockWithMsg:@"Read Number Of Mac Error" block:failedBlock];
            return;
        }
        if (![self readConditionAStatus]) {
            [self operationFailedBlockWithMsg:@"Read Filter Condition A Error" block:failedBlock];
            return;
        }
        if (![self readConditionBStatus]) {
            [self operationFailedBlockWithMsg:@"Read Filter Condition B Error" block:failedBlock];
            return;
        }
        if (![self readLogicalRelationship]) {
            [self operationFailedBlockWithMsg:@"Read Logical Relation Ship Error" block:failedBlock];
            return;
        }
        
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self checkParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        if (![self configPositioningTimeout]) {
            [self operationFailedBlockWithMsg:@"Config Positioning Timeout Error" block:failedBlock];
            return;
        }
        if (![self configNumberOfMAC]) {
            [self operationFailedBlockWithMsg:@"Config Number Of Mac Error" block:failedBlock];
            return;
        }
        if (![self configLogicalRelationship]) {
            [self operationFailedBlockWithMsg:@"Config Logical Relation Ship Error" block:failedBlock];
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
- (BOOL)readPositioningTimeout {
    __block BOOL success = NO;
    [MKBGInterface bg_readBLEPositioningTimeoutWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.interval = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPositioningTimeout {
    __block BOOL success = NO;
    [MKBGInterface bg_configBLEPositioningTimeout:[self.interval integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readNumberOfMAC {
    __block BOOL success = NO;
    [MKBGInterface bg_readBLENumberOfMacWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.numberOfMac = returnData[@"result"][@"number"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configNumberOfMAC {
    __block BOOL success = NO;
    [MKBGInterface bg_configBLENumberOfMac:[self.numberOfMac integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readConditionAStatus {
    __block BOOL success = NO;
    [MKBGInterface bg_readBLEFilterStatusWithType:mk_bg_filterRulesClassAType sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.conditionAIsOn = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readConditionBStatus {
    __block BOOL success = NO;
    [MKBGInterface bg_readBLEFilterStatusWithType:mk_bg_filterRulesClassBType sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.conditionBIsOn = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readLogicalRelationship {
    __block BOOL success = NO;
    [MKBGInterface bg_readBLELogicalRelationshipWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.ABIsOr = ([returnData[@"result"][@"type"] integerValue] == 0);
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configLogicalRelationship {
    __block BOOL success = NO;
    [MKBGInterface bg_configBLELogicalRelationship:(self.ABIsOr ? mk_bg_BLELogicalRelationshipOR : mk_bg_BLELogicalRelationshipAND) sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"blePositioningParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)checkParams {
    if (!ValidStr(self.interval) || [self.interval integerValue] < 1 || [self.interval integerValue] > 10) {
        return NO;
    }
    if (!ValidStr(self.numberOfMac) || [self.numberOfMac integerValue] < 1 || [self.numberOfMac integerValue] > 5) {
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
        _readQueue = dispatch_queue_create("blePositioningQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
