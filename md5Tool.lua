local envalidFile = {
  -- "outputWai/src/app/UIManager/UIMiGongPauseMng.luac",
  -- "outputWai/src/app/UIManager/UINewSysOpenMng.luac",
  -- "outputWai/src/app/UIManager/UIReviveMng.luac",
  -- "outputWai/src/app/UIManager/UISystemSetMng.luac",
  -- "outputWai/src/app/UIManager/UIZhanDouFailMng.luac",
  -- "outputWai/src/app/UIManager/UIZhanDouMazeMng.luac",
  -- "outputWai/src/app/UIManager/UIZhandouMng.luac",
  -- "outputWai/src/app/UIManager/UIZhanDouPauseMng.luac",
  -- "outputWai/src/app/UIManager/UIZhanDouWinMng.luac",
  -- "outputWai/src/app/UITools/ClipMng.luac",
  -- "outputWai/src/app/UITools/GSLabelTool.luac",
  -- "outputWai/src/cocos/3d/3dConstants.luac",
  -- "outputWai/src/cocos/cocos2d/bitExtend.luac",
  -- "outputWai/src/cocos/cocos2d/Cocos2d.luac",
  -- "outputWai/src/cocos/cocos2d/Cocos2dConstants.luac"
}

function isEnvalidFile(path)
    for index,file in ipairs(envalidFile) do
        if file == path then
            return true
        end
    end

    return false
end

--MD5

local md5 = require 'md5'
function getMd5ByPath(strbuff,dir)
    for file in lfs.dir(dir) do
        if file ~= ".." and file ~= "." and file ~= ".DS_Store" then
            local path = dir .. "/" .. file
            local attr = lfs.attributes(path)
            assert(not string.find(path," "),"资源文件名不能包含空格" .. path)
            if attr.mode == "directory" then
                strbuff = getMd5ByPath(strbuff,path)
            else
                if isEnvalidFile(path) == false then
                    local tempFile = assert(io.open(path,"r+"))local fileData = tempFile:read("*a")
                    -- tempFile.close()
                    io.close(tempFile)

                    local md5str = md5.sumhexa(fileData)
                    -- md5str = os.time()
                    local finalStr = ""
                    if isFirst then
                        isFirst = false
                    else
                        finalStr = finalStr .. ","
                    end
                    local splitIndex = string.find(path,"/")
                    local srcPath = string.sub(path,splitIndex + 1)
                    if append then
                        srcPath = srcPath .. append
                    end
                    finalStr = finalStr .. "\n   \"" .. srcPath .. "\" : {\"md5\" : \"" .. md5str .. "\"}"
                    StringBuffer.append(strbuff,finalStr)
                    count = count + 1
                    -- print("文件" .. path .. " md5 " .. md5str )
                end
            end
        end
    end
    return strbuff
end
