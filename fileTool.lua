--内网热更新
print("----内网热更新开始")

local lfs = require "lfs"
function deleteDir(dir)
    for file in lfs.dir(dir) do
        if file ~= ".." and file ~= "." then
            local path = dir .. "/" .. file
            deleteFile(path)
        end
    end
end

function deleteFile(path)
    print("删除文件" .. path)
    os.execute("rm -rf " .. path)
end

function copy(from,to)
    print("拷贝文件" .. from .. "到" .. to)
    os.execute("cp -rf " .. from .. " " .. to)
end

function writeFile(path,data)
    local file = io.open(path,"w")
    file:write(data)
    file:close()
end
