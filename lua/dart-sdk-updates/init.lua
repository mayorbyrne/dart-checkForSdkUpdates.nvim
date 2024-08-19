local M = {}

local getSDKVersion = function()
  local open = io.open

  local function read_file(path)
    local file = open(path, "rb") -- r read mode and b binary mode
    if not file then
      return nil
    end
    local content = file:read("*a") -- *a or *all reads the whole file
    file:close()
    return content
  end

  local sysname = vim.uv.os_uname().sysname
  local dartLocation

  -- if windows, use where dart
  if sysname:find("Windows") and true or false then
    dartLocation = io.popen("where dart")
  else
    dartLocation = io.popen("which dart")
  end

  if dartLocation == nil then
    return nil
  end

  local dartPath = dartLocation:read("*a")

  -- windows could have \ instead of /, so regex search those
  -- as well as any characters trailing the word dart (dart.exe) etc
  return read_file(vim.trim(dartPath:gsub("[\\/]bin[\\/]dart.*", "/version")))
end

local getLatestSdkVersion = function()
  local h = io.popen("curl -s https://storage.googleapis.com/dart-archive/channels/stable/release/latest/VERSION")
  if h == nil then
    return nil
  end
  local rawdata = h:read("all")
  if rawdata == nil then
    return nil
  end
  h:close()
  local t = vim.json.decode(rawdata)

  return vim.inspect(t.version):gsub('"', "")
end

M.setup = function()
  local latestVersion = getLatestSdkVersion()
  local currVersion = getSDKVersion()

  if currVersion == nil then
    return
  end

  local version = vim.trim(currVersion)

  if latestVersion ~= version then
    local message = "Version "
        .. latestVersion
        .. " of the Dart SDK is available (you have "
        .. version
        .. ")\nhttps://dart.dev/get-dart/archive"

    vim.notify(message, vim.log.levels.WARN)
  end
end

return M
