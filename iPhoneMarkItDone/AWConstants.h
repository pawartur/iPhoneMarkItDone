//
//  AWConstants.h
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// Used for saving to NSUserDefaults that a PIN has been set, and is the unique identifier for the Keychain.
#define SAVED_PASSWORD @"savedPassword"

// Used for saving the user's name to NSUserDefaults.
#define SAVED_USERNAME @"savedUsername"

// Used to specify the application used in accessing the Keychain.
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]

// Used to help secure the PIN.
// Ideally, this is randomly generated, but to avoid the unnecessary complexity and overhead of storing the Salt separately, we will standardize on this key.
// !!KEEP IT A SECRET!!
#define SALT_HASH @"FvTivqTqZXsgLLx1v3P8TGRyVHaSOB1pvfm02wvGadj7RLHV8GrfxaZ84oGA8RsKdNRpxdAojXYg9iAj"
