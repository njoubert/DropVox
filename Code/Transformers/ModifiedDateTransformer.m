//
//  ModifiedDateTransformer.m
//  DropVox
//
//  Created by Niels Joubert on 12/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ModifiedDateTransformer.h"


@implementation ModifiedDateTransformer

+ (Class)transformedValueClass { return [NSDate class]; }
+ (BOOL)allowsReverseTransformation { return YES; }
- (id)transformedValue:(id)value {
	//string to date
}
- (id)reverseTransformedValue:(id)value {
	//date to string
}

@end
