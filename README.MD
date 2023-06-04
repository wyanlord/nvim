# 安装

> mason 安装下面的组件

```lua
-- pyright
-- rust-analyzer
-- jdtls
-- java-test
-- java-debug-adapter
```

```shell
sudo pip3 install neovim debugpy
```

```shell
sudo apt install xclip fd-find lldb-13
```

```shell
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i ripgrep_13.0.0_amd64.deb
```

```shell
wget https://github.com/tree-sitter/tree-sitter/releases/download/v0.20.8/tree-sitter-linux-x64.gz
gzip -d tree-sitter-linux-x64.gz
chmod a+x tree-sitter-linux-x64
sudo mv tree-sitter-linux-x64 /usr/bin/tree-sitter
```

```shell
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
```

# 调试

*   var: <https://code.visualstudio.com/docs/editor/variables-reference>

*   java: <https://github.com/microsoft/vscode-java-debug#options>

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "java",
      "request": "launch",
      "name": "Launch Java",
      "mainClass": "io.keta.bootstrap.KetaDB",
      "classPaths": ["/userdata/projects/ketadb/keta-server/build/runtime", "/userdata/projects/ketadb/keta-server/build/runtime/*"],
      "encoding": "utf-8",
      "vmArgs": "-Dketa.path.home=/userdata/projects/ketadb/.sandbox -Dketa.path.conf=/userdata/projects/ketadb/.sandbox/config -Dlog4j2.disable.jmx=true -Duser.dir=/userdata/projects/ketadb/.sandbox -Xms2g -Xmx2g --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.util=ALL-UNNAMED --add-opens=java.base/java.nio=ALL-UNNAMED --add-opens=java.base/sun.nio.fs=ALL-UNNAMED --add-exports=java.base/sun.net.util=ALL-UNNAMED --add-opens=java.base/java.time=ALL-UNNAMED --add-opens=java.base/java.util.regex=ALL-UNNAMED",
      "env": { "KETA_DATABASE_MYSQL_DATABASE": "ketadb", "KETA_DATABASE_MYSQL_URL": ""},
      "cwd": "/userdata/projects/ketadb/.sandbox",
      "args": "-Eketa.database.mysql.url=127.0.0.1:3306 -Eketa.database.mysql.database=ketadb -Eketa.database.mysql.user=root -Eketa.database.mysql.password=123456"
    }
  ]
}
```

```json
// -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005

{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "java",
      "name": "Debug (Attach)",
      "projectName": "ketadb",
      "request": "attach",
      "hostName": "localhost",
      "port": 5005
    }
  ]
}
```

*   rust

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Launch an application",
            "type": "rust",
            "request": "launch",
            "program": "${workspaceFolder}/target/debug/${workspaceFolderBasename}",
            "cwd": "${workspaceFolder}",
            "args": ["${env:USERNAME}"]
        }
    ]
}
```

*   python

```json
{
  "version": "0.2.0",
  "configurations": [
      {
          "type": "python",
          "request": "launch",
          "name": "Launch Python",
          "program": "${workspaceFolder}/main.py",
          "cwd": "${workspaceFolder}",
          "pythonPath": "/usr/bin/python3"
      }
  ]
}
```
