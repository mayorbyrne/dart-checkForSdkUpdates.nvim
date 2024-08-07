local M = {};

local getSDKVersion = function()
  local open = io.open

  local function read_file(path)
      local file = open(path, "rb") -- r read mode and b binary mode
      if not file then return nil end
      local content = file:read "*a" -- *a or *all reads the whole file
      file:close()
      return content
  end

  return read_file("/Users/Kevin/Desktop/dart-sdk/version");
end

local getLatestSdkVersion = function()
  local http = require('socket.http')
  -- local json = require("./json.lua");
  local body = http.request("https://storage.googleapis.com/dart-archive/channels/stable/release/latest/VERSION");

  print(body);
end

M.setup = function()
  local latestVersion = getLatestSdkVersion();
  local version = getSDKVersion();

  print(latestVersion, version);

-- import { window } from "vscode";
-- import { DART_DOWNLOAD_URL } from "../../shared/constants";
-- import { Logger } from "../../shared/interfaces";
-- import { versionIsAtLeast } from "../../shared/utils";
-- import { envUtils } from "../../shared/vscode/utils";
-- import { WorkspaceContext } from "../../shared/workspace";
-- import { config } from "../config";
-- import { getLatestSdkVersion } from "../utils";
--
-- export async function checkForStandardDartSdkUpdates(logger: Logger, workspaceContext: WorkspaceContext): Promise<void> {
-- 	if (!config.checkForSdkUpdates || workspaceContext.config.disableSdkUpdateChecks)
-- 		return;
--
-- 	// Sometimes people use the Dart SDK inside Flutter for non-Flutter projects. Since that SDK is
-- 	// versioned with Flutter, it never makes sense to prompt the user to update the Dart SDK.
-- 	if (workspaceContext.sdks.dartSdkIsFromFlutter)
-- 		return;
--
-- 	const dartSdkVersion = workspaceContext.sdks.dartVersion;
-- 	try {
-- 		const version = await getLatestSdkVersion();
-- 		if (!dartSdkVersion || versionIsAtLeast(dartSdkVersion, version))
-- 			return;
--
-- 		const goToDownloadsAction = "Go to Dart Downloads";
-- 		const dontShowAgainAction = "Disable Update Checks";
-- 		const message = `Version ${version} of the Dart SDK is available (you have ${dartSdkVersion}). Some features of Dart Code may not work correctly with an old SDK.`;
-- 		const action = await window.showWarningMessage(message, goToDownloadsAction, dontShowAgainAction);
-- 		if (action === goToDownloadsAction)
-- 			await envUtils.openInBrowser(DART_DOWNLOAD_URL);
-- 		else if (action === dontShowAgainAction)
-- 			void config.setCheckForSdkUpdates(false);
--
-- 	} catch (e) {
-- 		logger.error(e);
-- 	}
-- }
end

return M;
