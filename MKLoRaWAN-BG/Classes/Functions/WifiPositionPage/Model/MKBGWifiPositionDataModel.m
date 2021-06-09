//
//  MKBGWifiPositionDataModel.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/21.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGWifiPositionDataModel.h"

#import "MKMacroDefines.h"

#import "MKBGInterface.h"
#import "MKBGInterface+MKBGConfig.h"

@interface MKBGWifiPositionDataModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKBGWifiPositionDataModel
- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readPositioningTimeout]) {
            [self operationFailedBlockWithMsg:@"Read positioning timeout error" block:failedBlock];
            return;
        }
        if (![self readNumberOfBSSID]) {
            [self operationFailedBlockWithMsg:@"Read number of BSSID error" block:failedBlock];
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
            [self operationFailedBlockWithMsg:@"Config positioning timeout error" block:failedBlock];
            return;
        }
        if (![self configNumberOfBSSID]) {
            [self operationFailedBlockWithMsg:@"Config number of BSSID error" block:failedBlock];
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
    [MKBGInterface bg_readWifiPositioningTimeoutWithSucBlock:^(id  _Nonnull returnData) {
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
    [MKBGInterface bg_configWifiPositioningTimeout:[self.interval integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readNumberOfBSSID {
    __block BOOL success = NO;
    [MKBGInterface bg_readWifiNumberOfBSSIDWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.number = returnData[@"result"][@"number"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configNumberOfBSSID {
    __block BOOL success = NO;
    [MKBGInterface bg_configWifiNumberOfBSSID:[self.number integerValue] sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"wifiPositionParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)checkParams {
    if (!ValidStr(self.interval) || [self.interval integerValue] < 1 || [self.interval integerValue] > 5) {
        return NO;
    }
    if (!ValidStr(self.number) || [self.number integerValue] < 1 || [self.number integerValue] > 5) {
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
        _readQueue = dispatch_queue_create("wifiPositionQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
