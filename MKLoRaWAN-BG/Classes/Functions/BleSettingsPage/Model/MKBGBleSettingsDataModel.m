//
//  MKBGBleSettingsDataModel.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/26.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGBleSettingsDataModel.h"

#import "MKMacroDefines.h"

@interface MKBGBleSettingsDataModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKBGBleSettingsDataModel

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
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
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
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
