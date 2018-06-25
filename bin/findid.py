#!/usr/bin/env python
# encoding: utf-8
"""
twitter2id.py

Created by Breyten Ernsting on 2010-05-31.
Copyright (c) 2010 __MyCompanyName__. All rights reserved.
"""

import sys
import getopt

import tweepy
import tweetsclient
import politwoops

import os
import logbook
import argparse
import politwoops

_script_ = (os.path.basename(__file__)
            if __name__ == "__main__"
            else __name__)
log = logbook.Logger(_script_)

log.notice ("...start");

help_message = '''
The help message goes here.
'''

class FillTwitterID(object):
    def __init__(self):
        self.config = tweetsclient.Config().get()
        consumer_key = self.config.get('tweets-client', 'consumer_key')
        consumer_secret = self.config.get('tweets-client', 'consumer_secret')
        access_token = self.config.get('tweets-client', 'access_token')
        access_token_secret = self.config.get('tweets-client', 'access_token_secret')
        log.debug("Consumer credentials: {key}, {secret}",
                  key=consumer_key,
                  secret=consumer_secret)
        log.debug("Access credentials: {token}, {secret}",
                  token=access_token,
                  secret=access_token_secret)
        self.twitter_auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
        self.twitter_auth.set_access_token(access_token, access_token_secret)
        try:
            username = self.twitter_auth.get_username()
            log.notice("Authenticated as {user}".format(user=username))
            self.api = tweepy.API(self.twitter_auth)
        except tweepy.error.TweepError as e:
            log.error(unicode(e))

    def get_config_default(self, section, key, default = None):
        try:
            return self.config.get(section, key)
        except ConfigParser.NoOptionError:
            return default

    def load_plugin(self, plugin_module, plugin_class):
        pluginModule = __import__(plugin_module)
        components = plugin_module.split('.')
        for comp in components[1:]:
            pluginModule = getattr(pluginModule, comp)
        pluginClass = getattr(pluginModule, plugin_class)
        return pluginClass

    def run(self):
        track_module = self.get_config_default('tweets-client', 'track-module', 'tweetsclient.config_track')
        track_class = self.get_config_default('tweets-client', 'track-class', 'ConfigTrackPlugin')
        log.debug("Loading track plugin: {module} - {klass}",
                  module=track_module, klass=track_class)

        pluginClass = self.load_plugin(track_module, track_class)
        self.track = pluginClass()
        names = self.track.get_missing_ids()
        if not names:
          log.notice("All politicians have their screenname")
          return 0
        users=self.api.lookup_users(screen_names=names)
        for user in users:
            self.track.update_user(user)
        return 0

def main(args):
#    signal.signal(signal.SIGHUP, politwoops.utils.restart_process)

    log_handler = politwoops.utils.configure_log_handler(_script_, args.loglevel, args.output)
    with logbook.NullHandler():
        with log_handler.applicationbound():
            try:
                app = FillTwitterID()
                if args.authtest:
                    return
                else:
                    return app.run()
            except KeyboardInterrupt:
                log.notice("Killed by CTRL-C")


if __name__ == "__main__":
    log.notice ("... main");
    args_parser = argparse.ArgumentParser(description=__doc__)
    args_parser.add_argument('--loglevel', metavar='LEVEL', type=str,
                             help='Logging level (default: notice)',
                             default='notice',
                             choices=('debug', 'info', 'notice', 'warning',
                                      'error', 'critical'))
    args_parser.add_argument('--output', metavar='DEST', type=str,
                             default='-',
                             help='Destination for log output (-, syslog, or filename)')
    args_parser.add_argument('--restart', default=False, action='store_true',
                             help='Restart when an error cannot be handled.')
    args_parser.add_argument('--authtest', default=False, action='store_true',
                             help='Authenticate against Twitter and exit.')
    args = args_parser.parse_args()
    sys.exit(main(args))
