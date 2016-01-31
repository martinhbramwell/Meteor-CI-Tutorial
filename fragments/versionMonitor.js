/**
 * @fileOverview Display a build version number if available. Show a marker if not..
 * @author Dude Awap <dude.awap@gmail.com>
 * @version v0.0.1
 * @license MIT
 */


/* -----------------------------------------------*/
/*  These values are patched by the build process */
const injectedTagSha = 'null';
const injectedBuildNum = 'null';
const injectedCommitUrl = 'null';
const injectedReleaseTag = 'null';
const injectedReleaseUrl = 'null';
/* -----------------------------------------------*/


Session.setDefault('tag_sha', 'unknown');
Session.setDefault('build_num', 'unknown');
Session.setDefault('commit_url', 'unknown');
Session.setDefault('release_tag', 'unknown');
Session.setDefault('release_url', 'unknown');


Template.versionMonitor.helpers({

  build_num: function getBuildNum() {
    if (injectedBuildNum === '') {
      return Session.get('build_num');
    }
    return injectedBuildNum;
  },
  commit_url: function getCommitUrl() {
    if (injectedCommitUrl === '') {
      return Session.get('commit_url');
    }
    return injectedCommitUrl;
  },
  tag_sha: function getTagSha() {
    if (injectedTagSha === '') {
      return Session.get('tag_sha');
    }
    return injectedTagSha;
  },
  release_tag: function getReleaseTag() {
    if (injectedReleaseTag === '') {
      return Session.get('release_tag');
    }
    return injectedReleaseTag;
  },
  release_url: function getReleaseUrl() {
    if (injectedReleaseUrl === '') {
      return Session.get('release_url');
    }
    return injectedReleaseUrl;
  },

});
