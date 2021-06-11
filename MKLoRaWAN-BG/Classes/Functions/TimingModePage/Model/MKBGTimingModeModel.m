//
//  MKBGTimingModeModel.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGTimingModeModel.h"

#import "MKMacroDefines.h"

#import "MKBGInterface.h"

@implementation MKBGTimingModeTimePointModel
@end

@interface MKBGTimingModeModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKBGTimingModeModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readStrategy]) {
            [self operationFailedBlockWithMsg:@"Read Positioning Strategy Error" block:failedBlock];
            return;
        }
        if (![self readReportingTimePoint]) {
            [self operationFailedBlockWithMsg:@"Read Reporting Time Point Error" block:failedBlock];
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
- (BOOL)readStrategy {
    __block BOOL success = NO;
    [MKBGInterface bg_readTimingModePositioningStrategyWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.strategy = [self getPositioningStrategy:[returnData[@"result"][@"strategy"] integerValue]];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readReportingTimePoint {
    __block BOOL success = NO;
    [MKBGInterface bg_readTimingModeReportingTimePointWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSArray *pointList = returnData[@"result"][@"pointList"];
        NSMutableArray *tempList= [NSMutableArray array];
        for (NSInteger i = 0; i < pointList.count; i ++) {
            NSDictionary *params = pointList[i];
            MKBGTimingModeTimePointModel *pointModel = [[MKBGTimingModeTimePointModel alloc] init];
            pointModel.hour = [params[@"hour"] integerValue];
            pointModel.minuteGear = [params[@"minuteGear"] integerValue];
            [tempList addObject:pointModel];
        }
        self.pointList = [NSArray arrayWithArray:tempList];
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
        NSError *error = [[NSError alloc] initWithDomain:@"timingModeParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (NSInteger)getPositioningStrategy:(NSInteger)deviceValue {
    if (deviceValue == 1) {
        return 0;
    }
    if (deviceValue == 2) {
        return 1;
    }
    if (deviceValue == 3) {
        return 5;
    }
    if (deviceValue == 4) {
        return 2;
    }
    if (deviceValue == 5) {
        return 3;
    }
    if (deviceValue == 6) {
        return 4;
    }
    if (deviceValue == 7) {
        return 6;
    }
    return 0;
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
        _readQueue = dispatch_queue_create("timingModeQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
