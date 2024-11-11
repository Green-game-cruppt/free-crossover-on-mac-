import os
import traceback

import appdetector
import bottlemanagement
import bottlequery
import bottlewrapper
import c4profilesmanager
import cddetector
import cxproduct
import cxaiengine
import cxmenu
import demoutils
import iconutils
import installtask
import ratingutils
import webtoken

import fileupdate

def is_really_signed(datafile, sigfile = (None,)):
    return True

fileupdate.is_signed = is_really_signed

class CXSetup(Foundation.NSObject):

    @classmethod
    def setEnvValue_forKey_(cls, value, key):
        os.environ[key] = value

    @classmethod
    def unsetEnvValueForKey_(cls, key):
        if key in os.environ:
            del os.environ[key]

    @classmethod
    def bottleCategory_(cls, category):
        return installtask.__dict__['CAT_' + category]

    @classmethod
    def dependencyReason_(cls, reason):
        return installtask.__dict__['REASON_' + reason]

    @classmethod
    def dependencyOverride_(cls, override):
        return installtask.__dict__['OVERRIDE_' + override]

    @classmethod
    def bottleStatus_(cls, status):
        return bottlewrapper.BottleWrapper.__dict__['STATUS_' + status]
