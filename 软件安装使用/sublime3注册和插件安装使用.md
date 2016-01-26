## sublime3 插件安装

1、sublime 3查看插件位置
>菜单->preferences->browse packages

2、使用package control组件，然后直接在线安装

安装 Package Control
- 通过快捷键 ctrl+` 或者 View > Show Console 菜单打开控制台
- 粘贴对应版本的代码后回车安装
>适用于 Sublime Text 3：
import  urllib.request,os;pf='Package Control.sublime-package';ipp=sublime.installed_packages_path();urllib.request.install_opener(urllib.request.build_opener(urllib.request.ProxyHandler()));open(os.path.join(ipp,pf),'wb').write(urllib.request.urlopen('http://sublime.wbond.net/'+pf.replace(' ','%20')).read())

>适用于 Sublime Text 2：
import  urllib2,os;pf='Package Control.sublime-package';ipp=sublime.installed_packages_path();os.makedirs(ipp)ifnotos.path.exists(ipp)elseNone;urllib2.install_opener(urllib2.build_opener(urllib2.ProxyHandler()));open(os.path.join(ipp,pf),'wb').write(urllib2.urlopen('http://sublime.wbond.net/'+pf.replace(' ','%20')).read());print('Please restart Sublime Text to finish installation')

手动安装：
第一步，先下载https://github.com/wbond/sublime_package_control中的文件，解压后将文件夹名更改为package control。

第二步，下载插件分支https://github.com/wbond/sublime_package_control/tree/python3中的文件，解压后覆盖到package control中，完成此插件API函数的更新。

最后，将package control文件夹放入==~/.config/sublime-text-3/Packages==中，重启sublime text 3即可生效。

3、sublime text 3常用插件推荐：
 ctrl+shift+p（或preference->package control 选择install package然后输入插件名字）调用出窗口：输入install package
 然后输入你想要的插件即可

4、常用插件及用法

- ctags: 在打开的文件中，右键菜单中会多一个Navigate to Definition菜单项
  在侧左栏的工程/项目文件上右键会看到CTags: Rebuild Tags菜单项
 这时你可以选中一个函数然后右键打开Navigate to Definition菜单项并执行，会发现左下角有这样的提示: Can't find any relevant tags file这是因为我们没有配置ctags可执行文件的路径
  从官网上下载ctags可执行程序，解压到某个目录中，并将该目录添加到系统的PATH环境变量里。这样sublime text才能执行该程序
  这时再到，侧左栏的工程/项目文件上右键执行CTags: Rebuild Tags菜单项，发弹出一个ctags的运行框，说明可以正常工作了
  这时再选中一个函数，右键打开Navigate to Definition菜单项并执行

  如果喜欢用快捷键操作，控制函数的跳转，可以打开Preferences->Package Settings->ctags->Key Bindings-User，并编辑这个文件，当然，如果不知道格式，可以将Key Bindings-Default里面的内容copy过来，然后修改某些命令的值
我的内容如下：

-  BracketHighlighter 高亮显示匹配的括号、引号和标签
  r能为ST提供括号，引号这类高亮功能，但安装此插件后，默认没有高亮，只有下划线表示，不是很醒目，需要如下配置
打开Preferences -> package settings -> Bracket Highlighter -> Bracket Settings – User (注意是user)，然后添加如下代码
```
{
    "bracket_styles": {
        "default": {
            "icon": "dot",
            // "color": "entity.name.class",
            "color": "brackethighlighter.default",
            "style": "highlight"
        },

        "unmatched": {
            "icon": "question",
            "color": "brackethighlighter.unmatched",
            "style": "highlight"
        },
        "curly": {
            "icon": "curly_bracket",
            "color": "brackethighlighter.curly",
            "style": "highlight"
        },
        "round": {
            "icon": "round_bracket",
            "color": "brackethighlighter.round",
            "style": "highlight"
        },
        "square": {
            "icon": "square_bracket",
            "color": "brackethighlighter.square",
            "style": "highlight"
        },
        "angle": {
            "icon": "angle_bracket",
            "color": "brackethighlighter.angle",
            "style": "highlight"
        },
        "tag": {
            "icon": "tag",
            "color": "brackethighlighter.tag",
            "style": "highlight"
        },
        "single_quote": {
            "icon": "single_quote",
            "color": "brackethighlighter.quote",
            "style": "highlight"
        },
        "double_quote": {
            "icon": "double_quote",
            "color": "brackethighlighter.quote",
            "style": "highlight"
        },
        "regex": {
            "icon": "regex",
            "color": "brackethighlighter.quote",
            "style": "outline"
        }
    }
}
```
- TrailingSpacer: 高亮显示多余的空格和Tab，
    try clicking "Edit / Trailing Spaces / Delete"?This plugin does not come with a default key binding for the deletion command. You can
  pick your own key binding and define it in "Preferences / Key Bindings - User", or just
  stick to using the menu entry under "Edit". Check the help for advice on this.
- SideBarEnhancements 侧边栏增强
- Alignment 等号对齐

5、插件怎么用
sublime的插件太多，乱七八糟，怎么用呢
==看每一个插件的用法==
==在preference->packages setting里面有每个安装的插件的设置(可以绑定快捷键)==