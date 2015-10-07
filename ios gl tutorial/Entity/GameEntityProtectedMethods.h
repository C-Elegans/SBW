//
//  GameEntityProtectedMethods.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/4/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#ifndef GameEntityProtectedMethods_h
#define GameEntityProtectedMethods_h


#endif /* GameEntityProtectedMethods_h */
@protocol GameEntityProtectedMethods <NSObject>
-(void)loadToBuffers:(const Vertex*)vertices vSize:(size_t)vsize indices:(const GLushort*)indices iSize:(size_t)isize objectName:(NSString*)objectName;
-(void)loadToTexture:(NSString*)fileName mipmapsEnabled:(BOOL)enableMipmaps;
@end
@interface GameEntity (ProtectedMethods) <GameEntityProtectedMethods>

@end