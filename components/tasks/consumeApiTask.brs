sub init()
    m.top.functionName = "getContent"
end sub

sub getContent()
    requestData = createObject("roUrlTransfer")
    requestData.setUrl("http://my-json-server.typicode.com/bogdanterzea/json-server/photos")
    apiResponse = ParseJson(requestData.GetToString())
    saveData(apiResponse)
end sub

sub saveData(data as Object)
    contentNode = createObject("roSGNode", "ContentNode")
    for each dataItem in data
        image = createObject("roSGNode", "imageContentNode")
        image.id = dataItem.id
        image.title = dataItem.title
        image.url = dataItem.url
        image.image_1080_url = dataItem.image_1080_url
        image.description = dataItem.description
        contentNode.appendChild(image)
    end for
    m.top.content = contentNode
end sub