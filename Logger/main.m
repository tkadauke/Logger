//
//  main.m
//  Logger
//
//  Created by Thomas Kadauke on 02.12.12.
//  Copyright (c) 2012 Thomas Kadauke. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <MacRuby/MacRuby.h>

int main(int argc, char *argv[])
{
  return macruby_main("rb_main.rb", argc, argv);
}
