#!/usr/bin/env python
# vim: set fileencoding=utf-8 :

from distutils.core import setup

setup(  name="pinyin-comp",
        version="0.1",
        description="complete path containing Chinese by pinyin acronym",
        author="Jekyll Wu",
        author_email="adaptee@gmail.com",
        url="http://github.com/adaptee/pinyin-completion",
        packages=['pinyin_comp'],
        scripts=['pinyin-comp'] ,
     )
