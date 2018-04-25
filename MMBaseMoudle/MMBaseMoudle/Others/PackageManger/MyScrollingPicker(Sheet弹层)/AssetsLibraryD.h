//
//  AssetsLibraryD.h
//  TestProject
//
//  Created by Apple on 15/6/25.
//  Copyright (c) 2015年 YUNSHANG ALERATION. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSInteger const AlbumCount;
typedef void(^UpDataBlock)(NSArray *ImgsData);

@interface AssetsLibraryD : NSObject

@property (nonatomic,strong) UpDataBlock GetImageBlock;

@property (nonatomic,strong) NSMutableArray *UpDataImages;

-(instancetype) init;

@end
