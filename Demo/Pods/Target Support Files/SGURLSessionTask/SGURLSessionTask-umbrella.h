#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SGBaseResponse.h"
#import "SGURLSessionTask.h"
#import "SGURLTaskConfigure.h"

FOUNDATION_EXPORT double SGURLSessionTaskVersionNumber;
FOUNDATION_EXPORT const unsigned char SGURLSessionTaskVersionString[];

