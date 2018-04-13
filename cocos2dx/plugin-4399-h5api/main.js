'use strict';

module.exports = {
  load () {
    // execute when package loaded
  },

  unload () {
    // execute when package unloaded
  },

  // register your ipc messages here
  messages: {
    'open' () {
      // open entry panel registered in package.json
      Editor.Panel.open('plugin-4399-h5api');
    },
    'clicked' () {
      Editor.Ipc.sendToPanel('plugin-4399-h5api', 'plugin-4399-h5api:onBuildFinished');
    }
  },
};