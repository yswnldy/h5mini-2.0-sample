var FS = require("fire-fs");
var PATH = require('fire-path');
// panel/index.js, this filename needs to match the one registered in package.json
Editor.Panel.extend({
  // css style for panel
  style: `
    :host { margin: 5px; }
    h2,h3 { color: #f90; }
  `,

  // html template for panel
  template: `
    <h2>plugin-4399-h5api</h2>
    <ui-button id="btn" class="self-end red">添加4399SDK</ui-button>
  `,

  // element and variable binding
  $: {
    btn: '#btn'
  },

  // method executed when template and styles are successfully loaded and initialized
  ready() {
    this.$btn.addEventListener('confirm', () => {
      Editor.Ipc.sendToMain('plugin-4399-h5api:clicked');
    });
    window.build4399SDK = function () {
      //获取构建平台
      let rootDir = Editor.libraryPath.split("library")[0];
      let localBuilderFilePath = PATH.join(rootDir, 'local/builder.json');
      if (FS.existsSync(localBuilderFilePath)) {
        let data = JSON.parse(FS.readFileSync(localBuilderFilePath, 'utf-8'));
        let buildDir = PATH.join(rootDir, data.buildPath);
        if (!FS.existsSync(buildDir)) {
          Editor.log("构建目录不存在,请重新构建项目: " + buildDir);
        } else {
          // 查找判断平台
          if (data.platform === "web-mobile" || data.platform === "web-desktop") {
            let platformRootDir = PATH.join(buildDir, data.platform);
            // 添加html代码
            let indexHtmlFile = PATH.join(platformRootDir, 'index.html');
            if (FS.existsSync(indexHtmlFile)) {
              let script = "<script src=\"http://h.api.4399.com/h5mini-2.0/h5api-interface.php\"></script>";
              let indexHtmlFileData = FS.readFileSync(indexHtmlFile, 'utf-8');
              if (indexHtmlFileData.indexOf(script) >= 0) {
                console.log("add html code finished");
              } else {
                let baseStr = "<body>";
                let newStr = indexHtmlFileData.replace(baseStr, baseStr + "\n" + script);
                FS.writeFileSync(indexHtmlFile, newStr);
                console.log("init html code over");
              }
            } else {
              Editor.log("添加SDK失败,文件不存在: " + indexHtmlFile);
            }
            Editor.log("生成成功.");
          } else {
            Editor.log("SDK不支持该平台:" + data.platform);
          }
        }
      } else {
        Editor.log("请构建项目!");
      }
    }
  },

  // register your ipc messages here
  messages: {
    'plugin-4399-h5api:onBuildFinished' (event) {
      window.build4399SDK();
    }
  }
});