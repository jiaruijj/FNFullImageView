//
//  UIImage+NamedInBundle.m
//  Pods
//
//  Created by JR on 16/9/6.
//
//

#import "UIImage+NamedInBundle.h"
#import "NSBundle+MyLibrary.h"
#import "FNFullImageViewController.h"

@implementation UIImage (NamedInBundle)

+ (nullable UIImage *)imageNamedBD:(NSString *)name {
    NSString *scaleStr = nil;
    if ([UIScreen mainScreen].scale == 1) {
        scaleStr = @"";
    } else if ([UIScreen mainScreen].scale == 2) {
        scaleStr = @"@2x";
    } else if ([UIScreen mainScreen].scale == 3) {
        scaleStr = @"@3x";
    }
    NSString *newName = [NSString stringWithFormat:@"%@%@",name,scaleStr];
    NSString *imagePath = [[NSBundle myLibraryBundle] pathForResource:newName ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}



@end
