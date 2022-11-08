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

RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(createPlugin: (NSString *)engineHandle)
{
    if (!_plugin) {
        _plugin = CreatePlugin((void *)engineHandle.longLongValue);
    }
    return [NSNull null];
}

RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(destroyPlugin)
{
    if (_plugin) {
        DestroyPlugin(_plugin);
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

// Don't compile this code when we build for the old architecture.
#ifdef RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
(const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeAgoraRawdataSpecJSI>(params);
}
#endif

@end
