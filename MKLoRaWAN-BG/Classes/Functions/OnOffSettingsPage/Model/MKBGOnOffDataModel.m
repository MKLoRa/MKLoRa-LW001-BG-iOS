//
//  MKBGOnOffDataModel.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/27.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGOnOffDataModel.h"

#import "MKMacroDefines.h"

#import "MKBGConnectModel.h"

#import "MKBGInterface.h"

@interface MKBGOnOffDataModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKBGOnOffDataModel

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if ([[MKBGConnectModel shared] firmwareVersion107]) {
            if (![self readOnOffMethod]) {
                [self operationFailedBlockWithMsg:@"Read On/Off Method Error" block:failedBlock];
                return;
            }
        }
        if (![self readOffByMagnet]) {
            [self operationFailedBlockWithMsg:@"Read Off By Magnet Error" block:failedBlock];
            return;
        }
        if (![self readDefaultMode]) {
            if (![self readOffByMagnet]) {
                [self operationFailedBlockWithMsg:@"Read Default Mode Error" block:failedBlock];
                return;
            }
        }
        if ([MKBGConnectModel shared].deviceType == 2) {
            if (![self readAutoPowerOn]) {
                [self operationFailedBlockWithMsg:@"Read Auto Power On Error" block:failedBlock];
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

- (BOOL)readOnOffMethod {
    __block BOOL success = NO;
    [MKBGInterface bg_readOnOffMethodWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.method = [returnData[@"result"][@"method"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readOffByMagnet {
    __block BOOL success = NO;
    [MKBGInterface bg_readOffByMagnetStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readDefaultMode {
    __block BOOL success = NO;
    [MKBGInterface bg_readRepoweredDefaultModeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.mode = [returnData[@"result"][@"mode"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readAutoPowerOn {
    __block BOOL success = NO;
    [MKBGInterface bg_readAutoPowerOnAfterChargingWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.autoPowerOn = [returnData[@"result"][@"isOn"] boolValue];
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
        NSError *error = [[NSError alloc] initWithDomain:@"onOffParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
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
        _readQueue = dispatch_queue_create("onOffQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
