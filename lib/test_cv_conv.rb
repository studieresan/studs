#!/usr/bin/env ruby
# encoding=utf-8

require 'ostruct'
require "./cv_conv.rb"

cv = OpenStruct.new
cv.name = 'Peter Boström'
cv.date_of_birth = '1989-02-24'
cv.phone = '+46 (0)73-693 77 13'
cv.email = 'pbos@kth.se'

cv.tags = ['Java', 'C/C++', 'Python', 'Ruby', 'git', 'Linux']

cv.education = [
  OpenStruct.new(:where => 'Kungliga Tekniska Högskolan',
                 :location => 'Stockholm, Sweden',
                 :what => [
    OpenStruct.new(
                 :short => 'Master of Science in Computer Science',
                 :when => 'August 2008 - January 2012 (expected)',
                 :description =>
"
A broad coverage of programming and computer science, both theoretical and
practical.

Bachelor's thesis done on an AI playing the board-game Blokus. Courses have
included internet protocols, advanced algorithms, computer security, C++,
multi-threaded computing and an introduction to cryptography, to name a few.

During the years a number of projects have been written, including a (really)
fast compiler for a subset of Java, as specified by the Compiler-Construction
course, written single-handedly in C using the popular open-source lexer/parser
pair flex and bison.
")
  ]),
  OpenStruct.new(:where => 'Propellerhead Software AB',
                 :location => 'Stockholm, Sweden',
                 :what => [
    OpenStruct.new(:short => "Master's Thesis: Real-Time Isolation of Native-
Code Thread-Based Plugins (temporary title)",
                   :when => 'September 2012 - January 2013 (expected)',
                   :description => 
"
Isolation of plugins running native code with real-time requirements in a
thread-based model. Work includes a fast shadow-memory implementation and
instrumentation using LLVM.
")
  ])
]

cv.experience = [
  OpenStruct.new(:where => 'WeeChat - A Popular Extensive Command-Line IRC Chat
  Client',
                 :location => 'http://weechat.org/',
                 :what => [
    OpenStruct.new(:short => 'Open-Source Contribution',
                   :when => '2012-',
                   :description =>
"
Closing a few bugs, including a five-year-old bug where reconnection to
particular IRC networks didn't work when the server sent back '*' instead of the
actual password.
")
  ]),
  OpenStruct.new(:where => 'Kungliga Tekniska Högskolan',
                 :location => 'Stockholm, Sweden',
                 :what => [
    OpenStruct.new(:short => 'Teaching Assistant',
                   :when => 'October 2010 -',
                   :description =>
"
Teaching an elementary course in computer science for first-year Computer-
Science students which covers programming in Java, elementary data structures
and algorithms.
"),
    OpenStruct.new(:short => 'Lab & Teaching Assistant',
                   :when => 'October 2009 - July 2011',
                   :description =>
"
Basic course in Python programming and computer science.
")
  ]),
  OpenStruct.new(:where => 'Oracle Technology AB',
                 :location => 'Stockholm, Sweden',
                 :what => [
    OpenStruct.new(:short => 'Quality Engineer',
                   :when => 'May-July 2011, June-Aug 2012',
                   :description => 
"
Software testing of JRockit Mission Control, a suite for monitoring, managing,
profiling and eliminating memory leaks in Java applications. Also developed an
internally-used testing tool for JavaDB, and compiling documentation covering
tests running on the JVM.
")
  ]),
  OpenStruct.new(:where => 'Tobii Technology AB',
                 :location => 'Stockholm, Sweden',
                 :what => [
    OpenStruct.new(:short => 'Quality Assurance',
                   :when => 'May-July 2010, part-time November-December 2010',
                   :description =>
"
Testing both software and hardware of the Tobii C-Series line of communication
devices; eye-tracker-based computers used as assistive technology enabling
people with certain disabilities to communicate and use computers more
effectively.
")
  ])
]

cv.other = [
  OpenStruct.new(:where => 'Kungliga Tekniska Högskolan',
                 :location => 'Stockholm, Sweden',
                 :what => [
    OpenStruct.new(:short => 'Mentor for New Students',
                   :when => 'Fall 2010, 2011, 2012',
                   :description => 
"
Full-time planning and execution of a friendly initiation for our new computer-
science students during a three-week period.
"),
    OpenStruct.new(:short => 'Member of the Board',
                   :when => 'August 2011 - June 2012',
                   :description =>
"
Everyday board responsibilities, meetings and accounting for the computer-
science chapter.
")
  ])
]

# puts CVConverter::to_txt cv
puts CVConverter::to_tex cv

