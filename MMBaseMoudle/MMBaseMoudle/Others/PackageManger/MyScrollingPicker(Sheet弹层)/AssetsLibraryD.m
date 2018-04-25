//
//  AssetsLibraryD.m
//  TestProject
//
//  Created by Apple on 15/6/25.
//  Copyright (c) 2015年 YUNSHANG ALERATION. All rights reserved.
//

#import "AssetsLibraryD.h"
#import <AssetsLibrary/AssetsLibrary.h>

NSInteger const AlbumCount = 100;
@interface AssetsLibraryD()

@property (nonatomic,strong) NSMutableArray *assets;

@end

@implementation AssetsLibraryD

-(instancetype)init{
    
    self = [super init];
    if (self) {
        [self getCameraRollImages];
    }
    return self;
}

- (void)getCameraRollImages {
    /*
     // Block called for every asset selected
     void (^selectionBlock)(ALAsset*, NSUInteger, BOOL*) = ^(ALAsset* asset,
     NSUInteger index,
     BOOL* innerStop) {
     // The end of the enumeration is signaled by asset == nil.
     if (asset == nil) {
     return;
     }
     
     ALAssetRepresentation* representation = [asset defaultRepresentation];
     
     // Retrieve the image orientation from the ALAsset
     UIImageOrientation orientation = UIImageOrientationUp
     NSNumber* orientationValue = [asset valueForProperty:@"ALAssetPropertyOrientation"];
     if (orientationValue != nil) {
     orientation = [orientationValue intValue];
     }
     
     CGFloat scale  = 1;
     UIImage* image = [UIImage imageWithCGImage:[representation fullResolutionImage]
     scale:scale orientation:orientation];
     
     // do something with the image
     };
     
     // Block called when enumerating asset groups
     void (^enumerationBlock)(ALAssetsGroup*, BOOL*) = ^(ALAssetsGroup* group, BOOL* stop) {
     // Within the group enumeration block, filter to enumerate just photos.
     [group setAssetsFilter:[ALAssetsFilter allPhotos]];
     
     // Get the photo at the last index
     NSUInteger index              = [group numberOfAssets] - 1;
     NSIndexSet* lastPhotoIndexSet = [NSIndexSet indexSetWithIndex:index];
     [group enumerateAssetsAtIndexes:lastPhotoIndexSet options:0 usingBlock:selectionBlock];
     };
     */
    _assets = [@[] mutableCopy];
   // __block NSMutableArray *tmpAssets = [@[] mutableCopy];
    //NSMutableArray *albumData;
    ALAssetsLibrary *assetsLibrary = [AssetsLibraryD defaultAssetsLibrary];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
       
        if ([_assets count]) return ;///  为了防止重复
        
        ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
        [group setAssetsFilter:onlyPhotosFilter];
       
        if ([group numberOfAssets] > AlbumCount) {
            NSRange range = NSMakeRange([group numberOfAssets]-AlbumCount, AlbumCount);
            //取相册后面100个元素
            NSIndexSet* lastPhotoIndexSet = [NSIndexSet indexSetWithIndexesInRange:range];
            [group enumerateAssetsAtIndexes:lastPhotoIndexSet options:0 usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if(result){
                    [_assets addObject:result];
                }
            }];
        }else{
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if(result){
                    [_assets addObject:result];
                }
            }];
        }
        //   倒序排序
        _assets = (NSMutableArray *)[[_assets reverseObjectEnumerator] allObjects];
       
        //   返回值
        if (self.GetImageBlock) {
            self.GetImageBlock(_assets);
        }

    } failureBlock:^(NSError *error) {
        DLog(@"Error loading images %@", error);
    }];
}

+ (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}


@end
