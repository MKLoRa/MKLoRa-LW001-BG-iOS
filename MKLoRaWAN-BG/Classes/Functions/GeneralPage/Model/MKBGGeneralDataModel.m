//
//  MKBGGeneralDataModel.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/20.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGGeneralDataModel.h"

#import "MKMacroDefines.h"

#import "MKBGInterface.h"
#import "MKBGInterface+MKBGConfig.h"

@interface MKBGGeneralDataModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKBGGeneralDataModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readHeartbeatInterval]) {
            [self operationFailedBlockWithMsg:@"Read Heartbeat Interval Error" block:failedBlock];
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
        if (![self validParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        if (![self configHeartbeatInterval]) {
            [self operationFailedBlockWithMsg:@"Config Heartbeat Interval Error" block:failedBlock];
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
- (BOOL)readHeartbeatInterval {
    __block BOOL success = NO;
    [MKBGInterface bg_readDeviceHeartbeatIntervalWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.heartbeatInterval = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configHeartbeatInterval {
    __block BOOL success = NO;
    [MKBGInterface bg_configHeartbeatInterval:[self.heartbeatInterval longLongValue] sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"GeneralParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
    if (!ValidStr(self.heartbeatInterval) || [self.heartbeatInterval integerValue] < 300 || [self.heartbeatInterval integerValue] > 86400) {
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
        _readQueue = dispatch_queue_create("GeneralQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
