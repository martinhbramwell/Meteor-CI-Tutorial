/**
 * @fileOverview Display a build version number if available. Show a marker if not..
 * @author Dude Awap <dude.awap@gmail.com>
 * @version v0.0.1
 * @license MIT
 */


/* -----------------------------------------------*/
/*  These values are patched by the build process */
const injected_tag_sha = '';
const injected_build_num = '';
const injected_commit_url = '';
const injected_release_tag = '';
const injected_release_url = '';
/* -----------------------------------------------*/


Session.setDefault('tag_sha', 'unknown');
Session.setDefault('build_num', 'unknown');
Session.setDefault('commit_url', 'unknown');
Session.setDefault('release_tag', 'unknown');
Session.setDefault('release_url', 'unknown');


Template.versionMonitor.helpers({

  build_num: function getBuild_num() {
    if (injected_build_num == '') {
      return Session.get('build_num');
    }
    return injected_build_num;
  },
  commit_url: function getCommit_url() {
    if (injected_commit_url == '') {
      return Session.get('commit_url');
    }
    return injected_commit_url;
  },
  tag_sha: function getTag_sha() {
    if (injected_tag_sha == '') {
      return Session.get('tag_sha');
    }
    return injected_tag_sha;
  },
  release_tag: function getReleaseTag() {
    if (injected_release_tag == '') {
      return Session.get('release_tag');
    }
    return injected_release_tag;
  },
  release_url: function getReleaseUrl() {
    if (injected_release_url == '') {
      return Session.get('release_url');
    }
    return injected_release_url;
  },

});