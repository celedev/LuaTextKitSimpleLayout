// Lua to C bindings for /Volumes/Brume/Celedev CodeFlow/CodeFlow Sample Applications/TextKitSimpleLayout/TextKitSimpleLayout/PathImageView.h
// Generated by Celedev® LuaBindingsGenerator on 2015-09-16 12:27:42 +0000
// Target Architecture: armv7

#import "CIMLua/CIMLuaBindings.h"

#import "PathImageView.h"

// Register Objective C methods extended signatures

@implementation PathImageView (LuaModule_TextKitSimpleLayout_PathImageView)

+ (void) load
{

    CIMLuaObjcMethodAttributes instanceMethodsAttributes [] = {
        { @selector(initWithFrame:shape:image:), "@32@0:4{CGRect={CGPoint=ff}{CGSize=ff}}8@\"UIBezierPath\"24@\"UIImage\"28" },
        { @selector(viewShape), "@\"UIBezierPath\"8@0:4" },
        { @selector(setViewShape:), "v12@0:4@\"UIBezierPath\"8" },
        { @selector(viewImage), "@\"UIImage\"8@0:4" },
        { @selector(setViewImage:), "v12@0:4@\"UIImage\"8" }
    };
    [CIMLuaContext registerObjcInstanceMethodsAttributes:instanceMethodsAttributes withCount:5 forClass:[PathImageView class]];
}

@end

