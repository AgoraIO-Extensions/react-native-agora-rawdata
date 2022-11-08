#ifdef __cplusplus
#import "plugin_c_api.h"
#endif

#ifdef RCT_NEW_ARCH_ENABLED
#import "RNAgoraRawdataSpec.h"

@interface AgoraRawdata : NSObject <NativeAgoraRawdataSpec>
#else
#import <React/RCTBridgeModule.h>

@interface AgoraRawdata : NSObject <RCTBridgeModule>
#endif

@end
