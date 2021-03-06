function init()
    m.firstChild = 0

    m.playButton = m.top.findNode("playVideoButton")
    m.ratingLabel = m.top.findNode("artScreenRatingLabel")
    m.pokemonSplashArtPoster = m.top.findNode("pokemonPoster")

    m.top.observeField("contenturi","updatePoster")
    m.top.observeField("pokemonratinglabel", "updateRatingLabel")

    getVideoData("https://my-json-server.typicode.com/bogdanterzea/pokemon-server/videos")
end function

function getVideoData(uri as String)
    requestContent = CreateObject("roSGnode","RequestVideoTask")
    requestContent.observeField("getRequestContent","saveRequestContent")
    requestContent.serveruri = uri
    requestContent.control = "RUN"
end function

function updatePoster(event as Object)
    data = event.getData()
    m.pokemonSplashArtPoster.uri = data
end function

function updateRatingLabel(event as Object)
    data = event.getData()
    m.ratingLabel.text = data.text
    m.ratingLabel.visible = data.visible
end function

function saveRequestContent(event as Object)
    m.videoContent = event.getData()
    updateButton(m.videoContent.title)
    observePlayButton()
end function

function updateButton(buttonText as string)
    m.playButton.text = buttonText
end function

function observePlayButton()
    m.playButton.observeField("buttonSelected","onPlayButtonClick")
end function

function onPlayButtonClick()
    m.videoScreen = CreateObject("roSGNode","VideoScreen")
    m.videoScreen.videoContent = m.videoContent
    m.top.appendChild(m.videoScreen)
    m.videoScreen.setFocus(true)
end function

function onKeyEvent(key as String, press as Boolean) as boolean
    if press
        if(key = "back")
            restoreTo("PokemonRowList")
        end if
    end if
    return true
end function
