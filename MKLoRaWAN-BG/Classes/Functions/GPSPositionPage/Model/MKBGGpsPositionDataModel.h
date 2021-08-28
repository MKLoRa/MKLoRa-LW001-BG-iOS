//
//  MKBGGpsPositionDataModel.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/21.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBGGpsPositionDataModel : NSObject

@property (nonatomic, copy)NSString *coldStardTime;

@property (nonatomic, copy)NSString *coarseAccuracyMask;

@property (nonatomic, copy)NSString *coarseTime;

@property (nonatomic, copy)NSString *fineAccuracyTarget;

@property (nonatomic, copy)NSString *fineTime;

@property (nonatomic, copy)NSString *PDOPLimit;

@property (nonatomic, assign)BOOL autonomousAiding;

@property (nonatomic, copy)NSString *adingAccuracy;

@property (nonatomic, copy)NSString *aidingTime;

/// 0:2D  1:3D  2:Auto
@property (nonatomic, assign)NSInteger fixMode;

/*
 0:Portable
 1:Stationary
 2:Pedestrian
 3:Automotive
 4:At sea
 5:Airborne<1g
 6:Airborne<2g
 7:Airborne<4g
 8:Wrist
 9:Bike
 */
@property (nonatomic, assign)NSInteger gpsMode;

@property (nonatomic, copy)NSString *timeBudget;

@property (nonatomic, assign)BOOL extremeMode;

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
