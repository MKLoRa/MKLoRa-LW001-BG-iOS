//
//  MKBGDevicePageModel.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/20.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGDevicePageModel.h"

#import "MKMacroDefines.h"

#import "MKBGConnectModel.h"

#import "MKBGInterface.h"
#import "MKBGInterface+MKBGConfig.h"

@interface MKBGDevicePageModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKBGDevicePageModel

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readCurrentTimeZone]) {
            [self operationFailedBlockWithMsg:@"Read Current Time Zone Error" block:failedBlock];
            return;
        }
        if (![self readShutdownPayload]) {
            [self operationFailedBlockWithMsg:@"Read Shutdown Payload Error" block:failedBlock];
            return;
        }
        if ([MKBGConnectModel shared].deviceType == 2) {
            //V2充电版
            if (![self readLowPowerPayload]) {
                [self operationFailedBlockWithMsg:@"Read Low Power Payload Error" block:failedBlock];
                return;
            }
            if (![self readLowPowerPrompt]) {
                [self operationFailedBlockWithMsg:@"Read Low Power Prompt Error" block:failedBlock];
                return;
            }
        }else {
            //V1+V2非充电版
            if (![self readLowPowerParams]) {
                [self operationFailedBlockWithMsg:@"Read Low Power Params Error" block:failedBlock];
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
- (BOOL)readCurrentTimeZone {
    __block BOOL success = NO;
    [MKBGInterface bg_readTimeZoneWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSInteger timeZone = [returnData[@"result"][@"timeZone"] integerValue];
        self.currentTimeZone = timeZone + 12;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readShutdownPayload {
    __block BOOL success = NO;
    [MKBGInterface bg_readShutdownPayloadStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.shutdownPayload = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readLowPowerParams {
    __block BOOL success = NO;
    [MKBGInterface bg_readLowPowerParamsWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.prompt = [returnData[@"result"][@"prompt"] integerValue];
        self.lowPowerPayload = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configLowPowerParams {
    __block BOOL success = NO;
    [MKBGInterface bg_configLowPowerPayload:self.lowPowerPayload prompt:self.prompt sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readLowPowerPayload {
    __block BOOL success = NO;
    [MKBGInterface bg_readLowPowerPayloadStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.lowPowerPayload = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configLowPowerPayload {
    __block BOOL success = NO;
    [MKBGInterface bg_configLowPowerPayloadStatus:self.lowPowerPayload sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readLowPowerPrompt {
    __block BOOL success = NO;
    [MKBGInterface bg_readLowPowerPromptWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.prompt = [returnData[@"result"][@"prompt"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configLowPowerPrompt {
    __block BOOL success = NO;
    [MKBGInterface bg_configLowPowerPrompt:self.prompt sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"deviceSettingsParams"
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
        _readQueue = dispatch_queue_create("deviceSettingsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
