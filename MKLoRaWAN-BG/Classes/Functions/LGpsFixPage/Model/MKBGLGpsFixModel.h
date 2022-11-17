//
//  MKBGLGpsFixModel.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2022/11/10.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBGLGpsFixModel : NSObject

@property (nonatomic, copy)NSString *timeout;

@property (nonatomic, copy)NSString *pdop;

@property (nonatomic, copy)NSString *timeBudget;

@property (nonatomic, assign)BOOL extremeMode;

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
