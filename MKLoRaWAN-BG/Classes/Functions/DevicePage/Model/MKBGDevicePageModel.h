//
//  MKBGDevicePageModel.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/20.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBGDevicePageModel : NSObject

/*
 @[@"UTC-12",@"UTC-11",@"UTC-10",@"UTC-9",
 @"UTC-8",@"UTC-7",@"UTC-6",@"UTC-5",
 @"UTC-4",@"UTC-3",@"UTC-2",@"UTC-1",
 @"UTC",@"UTC+1",@"UTC+2",@"UTC+3",
 @"UTC+4",@"UTC+5",@"UTC+6",@"UTC+7",
 @"UTC+8",@"UTC+9",@"UTC+10",@"UTC+11",
 @"UTC+12"];
 */
@property (nonatomic, assign)NSInteger currentTimeZone;

@property (nonatomic, assign)BOOL shutdownPayload;

@property (nonatomic, assign)BOOL lowPowerPayload;

@property (nonatomic, assign)NSInteger prompt;

- (void)readWithSucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configLowPowerParamsWithSucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
