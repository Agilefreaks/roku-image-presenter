sub init()
    m.top.functionName = "getContent"
end sub

sub getContent()
    requestData = createObject("roUrlTransfer")
    requestData.setUrl("http://my-json-server.typicode.com/bogdanterzea/json-server/photos")
    ? requestData.GetToString()
end sub