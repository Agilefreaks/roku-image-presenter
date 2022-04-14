sub init()
  m.top.setFocus(true)
  m.myPoster = m.top.findNode("myPoster")
  m.myLabel = m.top.findNode("myLabel")
  m.myDescription = m.top.findNode("description")
  m.RowList = m.top.findNode("RowList")
  
  m.myDescription.font.size = 30
  m.myLabel.font.size = 92
  m.myPoster.uri = "pkg:/images/bgimg.jpg"
  m.myLabel.color = "0x72D7EEFF"
  m.RowList.content = CreateObject("roSGNode", "RowListContent")

  m.RowList.setFocus(true)
  callTask()
end sub

sub callTask()
  m.apiTask = createObject("roSGNode", "consumeApiTask")
  m.apiTask.observeField("content", "getContent")
  m.apiTask.control = "RUN"
end sub

sub getContent(content as Object)
  contentData = content.getData()
end sub