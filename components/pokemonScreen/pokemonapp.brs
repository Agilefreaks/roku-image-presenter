function init()
    m.firstChild = 0
    m.focusedItemIndex = 1
    m.focusedPokemonIndex = m.firstChild

    m.titleLabel = m.top.FindNode("titleLabel")
    m.pokeList = m.top.FindNode("PokemonRowList")
    m.ratingLabel = m.top.FindNode("ratingLabel")
    m.pokeRatingList = m.top.FindNode("StarsList")
    m.descriptionLabel = m.top.FindNode("descriptionLabel")

    getPokemonList("http://my-json-server.typicode.com/bogdanterzea/pokemon-server/photos")
end function

function getPokemonList(uri as String)
    m.requestContent = CreateObject("roSGnode","RequestPokemonTask")
    m.requestContent.observeField("getRequestContent","saveContent")
    m.requestContent.serveruri = uri
    m.requestContent.control = "RUN"
end function

function saveContent(event as Object)
    serverContent = event.getData()
    createPokeList(serverContent)
end function

function createPokeList(listContent as Object)
    newPokemonContent = CreateObject("roSGNode", "ContentNode")
    newPokemonContent.appendChild(listContent)
    m.pokeList.content = newPokemonContent
    m.pokeList.setFocus(true)
    displayPokemonRating()
    observePokeList()
end function

function displayPokemonRating()
    rating = CreateObject("roSGNode","StarRatingContentNode")
    m.pokeRatingList.content = rating
    observeRatingList()
end function

function observePokeList()
    m.pokeList.observeField("rowItemFocused","onPokemonFocus")
    m.pokeList.observeField("rowItemSelected", "onPokemonSelect")
end function

function observeRatingList()
    m.pokeRatingList.observeField("rowItemSelected", "onRatingSelect")
end function

function onPokemonFocus(event as Object)
    data = event.GetData()
    currentRow = m.pokeList.content.getChild(m.firstChild)
    m.focusedPokemonIndex = data[m.focusedItemIndex]
    focusedPokemon = currentRow.getChild(m.focusedPokemonIndex)

    if focusedPokemon <> invalid
        displayPokemonRatingLabel(focusedPokemon.pokemonRating)
        updateText(focusedPokemon)
    end if
end function

function onPokemonSelect(event as Object)
    data = event.GetData()
    currentRow = m.pokeList.content.getChild(m.firstChild)
    selectedPokemon = currentRow.getChild(m.focusedPokemonIndex)
    createPokemonArtScreen(selectedPokemon)
end function

function onRatingSelect(event as Object)
    data = event.getData()
    ratingScore = data[m.focusedItemIndex] + 1
    currentRow = m.pokeList.content.getChild(m.firstChild)
    focusedPokemon = currentRow.getChild(m.focusedPokemonIndex)
    focusedPokemon.pokemonRating = ratingScore
    writeRegistry(focusedPokemon.pokemonID.ToStr(),ratingScore.ToStr())
    m.pokeList.setFocus(true)
end function

function writeRegistry(key as String, value as String)
    registry = CreateObject("roRegistrySection","PokemonAppRegistry")
    registry.Write(key, value)
    registry.Flush()
end function

function updateText(focusedPokemon as Object)
    m.titleLabel.text = focusedPokemon.title
    m.descriptionLabel.text = focusedPokemon.pokemonDescription
end function

function displayPokemonRatingLabel(ratingValue as Integer)
    visibility = false

    if ratingValue <> 0
        visibility = true
        m.ratingLabel.text = substitute("Current pokemon rating is {0}", ratingValue.ToStr())
    end if

    m.ratingLabel.visible = visibility
end function

function createPokemonArtScreen(selectedPokemon as Dynamic)
    pokemonArtScreen = CreateObject("roSGNode", "PokeArtScreen")
    pokemonArtScreen.contenturi = selectedPokemon.pokemonBGImage
    pokemonArtScreen.pokemonratinglabel = m.ratingLabel
    m.top.appendChild(pokemonArtScreen)
    pokemonArtScreen.setFocus(true)
end function

function defineFocus() as Integer
    currentRow = m.pokeList.content.getChild(m.firstChild)
    focusedPokemon = currentRow.getChild(m.focusedPokemonIndex)
    currentPokemonRating = 0

    if focusedPokemon.pokemonRating > 0
        currentPokemonRating = focusedPokemon.pokemonRating - 1
    end if

    return currentPokemonRating
end function

function onKeyEvent(key as String, press as Boolean) as boolean
    if press
        if key = "up" and m.pokeList.hasFocus()
            m.pokeRatingList.setFocus(true)
            m.pokeRatingList.jumpToRowItem = [0, defineFocus()]
        else if key = "down" and m.pokeRatingList.hasFocus()
            m.pokeList.setFocus(true)
        end if
    end if

    return true
end function