function addTable(str,table)
    local isFirst = true
    for key,value in pairs(table) do
        if isFirst then
            isFirst = false
        else
            str = str .. ","
        end
        str = str .. "\n" .. " \"" .. key .. "\" : \"" .. value .. "\""
    end
    return str
end

local VER = os.time()
print("当前版本号" .. VER)

local projTable = {
    ["packageUrl"] = "http://" .. Ip .. ":9000/package/",
    ["remoteManifestUrl"] = "http://" .. Ip .. ":9000/project.manifest",
    ["remoteVersionUrl"] = "http://" .. Ip .. ":9000/version.manifest",
    ["localpackageUrl"] = "http://" .. Ip .. ":9000/package/",
    ["localremoteManifestUrl"] = "http://" .. Ip .. ":9000/project.manifest",
    ["localremoteVersionUrl"] = "http://" .. Ip .. ":9000/version.manifest",
    ["version"] = "1.0." .. VER,
    ["engineVersion"] = "3.5"
}

function generateManifest(dir)
    --创建ver pro
    print("创建两个manifest文件")
    local VerPath = dir .. "/version.manifest"
    os.execute("echo " .. "" .. " > " .. VerPath)
    local ProPath = dir .. "/project.manifest"
    os.execute("echo " .. "" .. " > " .. ProPath)

    local ProStr = ""
    ProStr = ProStr .. "{"
    ProStr = addTable(ProStr,projTable)
    ProStr = ProStr .. ",\n \"assets\" : {"
    local md5table = StringBuffer.new()
    isFirst = true
    count = 0
    md5table = getMd5ByPath(md5table,dir.."/src")
    md5table = getMd5ByPath(md5table,dir.."/res")
    print("共有" .. count .. "个文件")
    local md5str = StringBuffer.tostr(md5table)
    ProStr = ProStr .. md5str
    ProStr = ProStr .. " \n},\n"
    ProStr = ProStr .. " \"searchPaths\" : []\n}"
    writeFile(ProPath,ProStr)

    --生成ver
    local VerStr = ""
    VerStr = VerStr .. "{"
    VerStr = addTable(VerStr,projTable)
    VerStr = VerStr .. "\n}"
    writeFile(VerPath,VerStr)
end
