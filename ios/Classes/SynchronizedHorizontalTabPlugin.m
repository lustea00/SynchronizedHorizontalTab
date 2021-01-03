#import "SynchronizedHorizontalTabPlugin.h"
#if __has_include(<synchronized_horizontal_tab/synchronized_horizontal_tab-Swift.h>)
#import <synchronized_horizontal_tab/synchronized_horizontal_tab-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "synchronized_horizontal_tab-Swift.h"
#endif

@implementation SynchronizedHorizontalTabPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSynchronizedHorizontalTabPlugin registerWithRegistrar:registrar];
}
@end
