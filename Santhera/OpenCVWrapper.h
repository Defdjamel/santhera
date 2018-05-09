//
//  OpenCVWrapper.h
//  Santhera
//
//  Created by Santhera on 03/05/2018.
//  Copyright © 2018 Bien Ouej. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface OpenCVWrapper : NSObject
+ (NSString *)openCVVersionString;
- (UIImage *)processImage:(UIImage *)image;
@end
