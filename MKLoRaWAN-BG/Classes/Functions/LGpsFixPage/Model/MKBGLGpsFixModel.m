//
//  MKBGLGpsFixModel.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2022/11/10.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBGLGpsFixModel.h"

#import "MKMacroDefines.h"
#import "NSObject+MKModel.h"
#import "NSString+MKAdd.h"

#import "MKBGInterface.h"
#import "MKBGInterface+MKBGConfig.h"

@interface MKBGLGpsFixModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKBGLGpsFixModel

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readCoarseTimeout]) {
            [self operationFailedBlockWithMsg:@"Read Coarse Timeout Error" block:failedBlock];
            return;
        }
        if (![self readPDOPLimit]) {
            [self operationFailedBlockWithMsg:@"Read PDOP Limit Error" block:failedBlock];
            return;
        }
        if (![self readTimeBudget]) {
            [self operationFailedBlockWithMsg:@"Read Time Budget Error" block:failedBlock];
            return;
        }
        if (![self readExtremeMode]) {
            [self operationFailedBlockWithMsg:@"Read Extreme mode Error" block:failedBlock];
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
        if (![self validParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return ;
        }
        
        if (![self configCoarseTimeout]) {
            [self operationFailedBlockWithMsg:@"Config Coarse Timeout Error" block:failedBlock];
            return;
        }
        
        if (![self configPDOPLimit]) {
            [self operationFailedBlockWithMsg:@"Config PDOP Limit Error" block:failedBlock];
            return;
        }
        
        if (![self configTimeBudget]) {
            [self operationFailedBlockWithMsg:@"Config Time Budget Error" block:failedBlock];
            return;
        }
        if (![self configExtremeMode]) {
            [self operationFailedBlockWithMsg:@"Config Extreme mode Error" block:failedBlock];
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

- (BOOL)readCoarseTimeout {
    __block BOOL success = NO;
    [MKBGInterface bg_readGpsCoarseTimeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.timeout = returnData[@"result"][@"time"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configCoarseTimeout {
    __block BOOL success = NO;
    [MKBGInterface bg_configGpsCoarseTime:[self.timeout integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readPDOPLimit {
    __block BOOL success = NO;
    [MKBGInterface bg_readGpsPDOPLimitWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.pdop = returnData[@"result"][@"value"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPDOPLimit {
    __block BOOL success = NO;
    [MKBGInterface bg_configGpsPDOPLimit:[self.pdop integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readTimeBudget {
    __block BOOL success = NO;
    [MKBGInterface bg_readGpsTimeBudgetWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.timeBudget = returnData[@"result"][@"time"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configTimeBudget {
    __block BOOL success = NO;
    [MKBGInterface bg_configGpsTimeBudget:[self.timeBudget longLongValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readExtremeMode {
    __block BOOL success = NO;
    [MKBGInterface bg_readGpsExtremeModeStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.extremeMode = [returnData[@"result"][@"extremeMode"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configExtremeMode {
    __block BOOL success = NO;
    [MKBGInterface bg_configGpsExtremeModeStatus:self.extremeMode sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)validParams {
    if (!ValidStr(self.timeout) || [self.timeout integerValue] < 1 || [self.timeout integerValue] > 7620) {
        return NO;
    }
    if (!ValidStr(self.pdop) || [self.pdop integerValue] < 25 || [self.pdop integerValue] > 100) {
        return NO;
    }
    if (!ValidStr(self.timeBudget) || [self.timeBudget integerValue] < 0 || [self.timeBudget integerValue] > 76200) {
        return NO;
    }
    return YES;
}

#pragma mark - private method
- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"gpsParams"
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
        _readQueue = dispatch_queue_create("gpsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
