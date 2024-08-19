# <p align="center">dart-checkForSdkUpdates.nvim</p>
<br />
<p align="center">
  <img src="https://github.com/user-attachments/assets/39ca9324-2faf-45ad-ad5a-457e800eca45" />
</p>

# Purpose

My VSCode friends using dart were being alerted of new releases of the sdk, thanks to the https://dartcode.org/docs/settings/#dartcheckforsdkupdates

I couldn't find anything in vim/nvim that would notify me about new Dart SDK releases, so I decided to create a plugin that would do just that. This is my first plugin, so please be gentle.
<br /><br />

# ⬇️ Installation
Install via package manager and run when opening a dart file

### Lazy
```lua
{
  "mayorbyrne/dart-checkForSdkUpdates.nvim",
  ft = "dart",
  config = function()
    require("dart-checkForSdkUpdates").setup()
  end,
}
```

