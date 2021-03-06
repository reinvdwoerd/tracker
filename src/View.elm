module View exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Update exposing (..)
import Model exposing (View(..), Fact(..))


-- view


view model =
    div [ class "container" ]
        [ header' model.view
        , view' model.view model.facts
        ]


header' : View -> Html Msg
header' view =
    header []
        [ div [ class "right" ]
            [ headerButton "chart" Chart view
            , headerButton "timeline" Timeline view
            ]
        , headerButton "+" New view
        ]


headerButton label view currentView =
    let
        class' =
            if view == currentView then
                "active"
            else
                ""
    in
        button [ id label, onClick (SwitchView view), class class' ]
            [ text label ]


view' view facts =
    let
        chartClass =
            viewClass Chart view

        timelineClass =
            viewClass Timeline view

        newClass =
            viewClass New view
    in
        main' []
            [ chartView chartClass []
            , timelineView timelineClass facts
            , newFactView newClass Nothing "" ""
            ]


viewClass view currentView =
    if view == currentView then
        "show"
    else
        ""


chartView class' facts =
    div [ class class', id "chart" ] [ text "Chart" ]


timelineView class' facts =
    div [ class class', id "timeline" ]
        (List.map factView facts)


factView fact =
    case fact of
        Textual fact ->
            div [ class "fact textual" ]
                [ text fact.text
                , text fact.tag
                ]

        Numeric fact ->
            div [ class "fact numeric" ]
                [ text <| toString fact.value ]


newFactView class' date label value =
    Html.form [ id "new-fact", class class' ]
        [ div [ class "inner" ]
            [ h1 [] [ text "New Fact" ]
            , input [ placeholder "Tag" ] []
            , input [ placeholder "Value" ] []
            , button [] [ text "Add" ]
            ]
        ]
