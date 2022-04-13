sub init()
  m.top.setFocus(true)
  m.myPoster = m.top.findNode("myPoster")
  m.myLabel = m.top.findNode("myLabel")
  
  m.myLabel.font.size = 92
  m.myPoster.uri = "pkg:/images/bgimg.jpg"
  m.myLabel.color = "0x72D7EEFF"
  callTask()
end sub

sub callTask()
  m.apiTask = createObject("roSGNode", "consumeApiTask")
  m.apiTask.observeField("content", "getContent")
  m.apiTask.control = "RUN"
end sub

function getContent(content)
  contentData = content.getData()
  ? contentData.GetChildCount()
end function