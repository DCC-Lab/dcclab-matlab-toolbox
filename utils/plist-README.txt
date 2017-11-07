Matlab functions for importing/exporting XML property list format used in Mac OS X

AUTHOR
John Iversen
iversen@nsi.edu

Free for any use, so long as author line remains with code.

CONTENTS

A pair of conversion functions

    XMLPlistToStruct    Parse Mac OSX XML property list into matlab structure
    structToXMLPlist    Convert a structure to Mac OSX XML property list 

A pair of convenience functions for loading/saving from files

    loadXMLPlist        Load and parse Mac OSX XML property list
    saveXMLPlist        Save structure as Mac OSX XML property list
    
A test XML plist
    
    test.plist

USAGE

e.g. S = loadXMLPlist('test.plist');

See XMLPlistToStruct.m for full details.

Details on XML property list format
http://developer.apple.com/documentation/Cocoa/Conceptual/PropertyLists/Concepts/XMLPListsConcept.html
http://www.apple.com/DTDs/PropertyList-1.0.dtd

3/2005