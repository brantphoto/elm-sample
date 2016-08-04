module Main exposing (..)
import Html exposing (..)
import List
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Html.App

-- Main

type alias Person = {name: String, age: Int}

type alias Counter = {count: Int}
type alias IndexedCounterItem = {index: Int, counter: Counter}


type alias Model =
  {
      idIt: Int,
      counters: List IndexedCounterItem
  }

foo : Model -> Model
foo model =
  { model | idIt = (5 // 1)  }

-- MODEL
model : Model
model = {
        idIt = 0
        , counters = [
            {
                index = 0
                , counter = {
                    count = 0
                }
            }
        ]
    }

main : Program Never
main = Html.App.beginnerProgram
  { model = model
  , update = update
  , view = view
  }


-- UPDATE
type Msg
  = Inc Int
  | Dec Int
  | AddCounter

update : Msg -> Model -> Model
update message model =
    case message of
        Inc index -> { model | counters = updateCounter model.counters index (1)}
        Dec index -> { model | counters = updateCounter model.counters index (-1)}
        AddCounter -> {
            idIt = (model.idIt + 1 // 1)
            , counters = model.counters ++ [{ index = (model.idIt + 1 // 1) , counter = {count = 0} }]
        }

stylesheet : Html a
stylesheet =
    let
        tag = "link"
        attrs =
            [ attribute "rel"       "stylesheet"
            , attribute "property"  "stylesheet"
            , attribute "href"      "//cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/css/materialize.min.css"
            ]
        children = []
    in
        node tag attrs children

buttonClasses : String
buttonClasses =
  "waves-effect waves-light btn"

-- VIEW
view : Model -> Html Msg
view model =
    div []
      [
        stylesheet
        , h1 [] [text "hi there!"]
        , div [] [ button [class buttonClasses, onClick AddCounter] [text "Hello"]]
        , div [] (renderCounters model.counters)
      ]

updateCounter : List IndexedCounterItem -> Int -> Int -> List IndexedCounterItem
updateCounter counters index divider =
  let
    updatesCounter t =
      if t.index == index then {t | counter = {count = (t.counter.count + (divider * index)) // 1} } else t
  in
    List.map updatesCounter counters


-- COUNTER
-------  Counter - repeat
renderCounters : List IndexedCounterItem -> List (Html Msg)
renderCounters counters = List.map renderCounter counters

-------  Counter - individual
renderCounter : IndexedCounterItem -> Html Msg
renderCounter indexedCounter =
        div []
        [
        div [] [ text ("Counter #:" ++ toString indexedCounter.index)]
            , div [] [h3 [] [text (toString indexedCounter.counter.count)]]
            , button [class buttonClasses, onClick (Inc indexedCounter.index)] [text "Increment"]
            , button [class buttonClasses, onClick (Dec indexedCounter.index)] [text "Decrement"]
        ]
