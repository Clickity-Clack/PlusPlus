local VisualFile = require 'VisualFile'
local VisualFileList = class('VisualFileList', VisualList)

function VisualFileList:initialize(files)
    VisualList.initialize(self,files)
end

return VisualFileList
