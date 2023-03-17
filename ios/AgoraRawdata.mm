#import "AgoraRawdata.h"

@interface AgoraRawdata ()
@property(nonatomic) PluginPtr plugin;
@end

@implementation AgoraRawdata
RCT_EXPORT_MODULE()

- (instancetype)init {
    if (self = [super init]) {
        _plugin = nullptr;
    }
    return self;
}

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(createPlugin: (NSString *)engineHandle)
{
    if (!_plugin) {
        _plugin = CreateSamplePlugin((void *)engineHandle.longLongValue);
    }
    return [NSNull null];
}

RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(destroyPlugin)
{
    if (_plugin) {
        DestroySamplePlugin(_plugin);
        _plugin = nullptr;
    }
    return [NSNull null];
}

RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(enablePlugin)
{
    if (_plugin) {
        return @(EnablePlugin(_plugin));
    }
    return @(NO);
}

RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(disablePlugin)
{
    if (_plugin) {
        return @(DisablePlugin(_plugin));
    }
    return @(NO);
}

@end
