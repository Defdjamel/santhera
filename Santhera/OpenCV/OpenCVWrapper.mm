//
//  OpenCVWrapper.m
//  Santhera
//
//  Created by Santhera on 03/05/2018.
//  Copyright © 2018 Bien Ouej. All rights reserved.
//

#import "OpenCVWrapper.h"

#import <opencv2/imgcodecs/ios.h>
#import <opencv2/opencv.hpp>
#include <iostream>
#include <string>
#include <vector>

using namespace cv;
using namespace std;

@implementation OpenCVWrapper {
    cv::Mat gtpl;
}

+ (NSString *)openCVVersionString {
    return [NSString stringWithFormat:@"OpenCV Version %s",  CV_VERSION];
}

- (UIImage *)processImage:(UIImage *)image {
    cv::Mat matImage;
    UIImageToMat(image, matImage);
    
    cv::medianBlur(matImage, matImage, 3);

    // Convert input image to HSV
    cv::Mat hsvImage;
    cv::cvtColor(matImage, hsvImage, cv::COLOR_RGB2HSV);
    
    // Threshold the HSV image, keep only the red pixels
    cv::Mat lowerRedHueRange;
    cv::Mat upperRedHueRange;
    cv::inRange(hsvImage, cv::Scalar(0, 100, 100), cv::Scalar(10, 255, 255), lowerRedHueRange);
    cv::inRange(hsvImage, cv::Scalar(160, 100, 100), cv::Scalar(179, 255, 255), upperRedHueRange);

    // Combine the above two images
    cv::Mat redHueImage;
    cv::addWeighted(lowerRedHueRange, 1.0, upperRedHueRange, 1.0, 0.0, redHueImage);

    //cv::GaussianBlur(redHueImage, redHueImage, cv::Size(9, 9), 2, 2);
    
    /// Find contours
    vector<vector<Point2i> > contours;
    vector<Vec4i> hierarchy;
    findContours( redHueImage, contours, hierarchy, CV_RETR_TREE, CV_CHAIN_APPROX_SIMPLE, Point2i(0, 0) );
    
    for (unsigned int i = 0;  i < contours.size();  i++) {
        std::cout << "# of contour points: " << contours[i].size() << std::endl;
        
        for (unsigned int j=0;  j<contours[i].size();  j++) {
            std::cout << "Point(x,y)=" << contours[i][j] << std::endl;
        }
        std::cout << " Area: " << contourArea(contours[i]) << std::endl;
    }
    
    return MatToUIImage(redHueImage);
}

@end
