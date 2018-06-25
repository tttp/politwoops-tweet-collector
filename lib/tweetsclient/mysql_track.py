#!/usr/bin/env python
# encoding: utf-8
"""
beanstalk.py

Created by Breyten Ernsting on 2010-08-08.
Copyright (c) 2010 __MyCompanyName__. All rights reserved.
"""

import sys
import os
import unittest
import ConfigParser
import MySQLdb

import anyjson
import beanstalkc
import logbook

import tweetsclient

log = logbook.Logger(__name__)

class MySQLTrackPlugin(tweetsclient.TrackPlugin):
    def _get_database(self):
        log.debug("Making DB connection")
        conn = MySQLdb.connect(
            host=self.config.get('database', 'host'),
            port=int(self.config.get('database', 'port')),
            db=self.config.get('database', 'database'),
            user=self.config.get('database', 'username'),
            passwd=self.config.get('database', 'password'),
            charset="utf8mb4",
            use_unicode=True
        )
        conn.cursor().execute('SET NAMES UTF8MB4')
        return conn

    def _query(self, connection, table_name, field_name, conditions = None):
        cursor = connection.cursor()
        q = "SELECT `%s` FROM `%s`" % (field_name, table_name)
        if conditions:
            q = q + " WHERE %s" % (conditions)
        log.debug("Executing query: {0}", q)
        cursor.execute(q)
        return [str(t[0]) for t in cursor.fetchall()]

    def _get_trackings(self):
        tbl = self.config.get('database', 'table')
        fld = self.config.get('database', 'field')
        cnd = self.config.get('database', 'conditions')
        conn = self._get_database()
        return self._query(conn, tbl, fld, cnd)

    def get_type(self):
        return self.config.get('tweets-client', 'type')

    def get_missing_ids(self):
        tbl = self.config.get('database', 'table')
        #fld = self.config.get('database', 'field')
        fld = 'screen_name'
        cnd = self.config.get('database', 'conditions')
        cnd = " twitter_id is null and screen_name !='' limit 100"
        conn = self._get_database()
        return self._query(conn, tbl, fld, cnd)

    def update_user(self, user):
#        user.id user.screen_name followers_count friends_count user.statuses_count user.entities.urls.expended_url profile_image_url_https lang created_at
        tbl = self.config.get('database', 'table')
        fld = self.config.get('database', 'field')
        connection = self._get_database()
        cursor = connection.cursor()
        try:
          #q = "UPDATE `%s` SET `%s`= %s,followers_count=%s,friends_count=%,url='%s',profile_image_url='%s',created_at='%' WHERE screen_name='%s'" % (tbl, fld,user.id,user.followers_count,user.friends_count,url,user.profile_image_url_https,user.created_at,user.screen_name)
          q = "UPDATE `%s` SET `%s`=" % (tbl, fld)
          q = q +''' %s , followers_count=%s,friends_count=%s, created_at="%s",description="%s",profile_image_url="%s" WHERE screen_name="%s" ''' #,user.id,user.followers_count,user.friends_count,user.created_at,user.description, user.profile_image_url,user.screen_name)
          
          log.debug("Executing query: {0}", q)
          cursor.execute(q,(user.id,user.followers_count,user.friends_count,user.created_at,user.description, user.profile_image_url,user.screen_name))
          connection.commit()
        except:
           log.error("can't execute query");
           raise


    def get_items(self):
        stream_type = self.get_type()
        if stream_type == 'users':
            return self._get_trackings()
        elif stream_type == 'words':
            return self._get_trackings()
        else:
            return []
