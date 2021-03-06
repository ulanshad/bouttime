React = require 'react/addons'
$ = require 'jquery'
GameForm = require './game_setup/game_form'
Skater = require '../models/skater'
AppDispatcher = require '../dispatcher/app_dispatcher'
{ActionTypes} = require '../constants'
module.exports = React.createClass
  displayName: 'GameSetup'
  componentWillMount: () ->
    @actions =
      updateGame: (gameState) =>
        @setState(gameState: $.extend(@state.gameState, gameState))
      updateOfficial: (idx, official) =>
        @state.gameState.officials[idx] = official
        @setState @state
      addOfficial: (gameState) =>
        gameState.officials.push ''
        @setState @state
      removeOfficial: (gameState, officialIndex) =>
        gameState.officials.splice officialIndex, 1
        @setState @state
      addAd: (gameState, ad) =>
        gameState.ads.push ad
        @setState @state
      removeAd: (gameState, adIndex) =>
        gameState.ads.splice adIndex, 1
        @setState @state
      updateTeam: (team, newTeam) =>
        team = $.extend(team, newTeam)
        @setState(@state)
      addSkater: (team) =>
        team.addSkater new Skater()
        @setState(@state)
      removeSkater: (team, skater) =>
        team.removeSkater(skater)
        @setState(@state)
      updateSkater: (skater, newSkater) =>
        skater = $.extend(skater, newSkater)
        @setState(@state)
      saveGame: () =>
        AppDispatcher.dispatchAndEmit
          type: ActionTypes.SAVE_GAME
          gameState: @state.gameState
        @props.onSave()
  getInitialState: () ->
    @dirty = false
    gameState: $.extend(true, {}, @props.gameState)
  reloadState: () ->
    @dirty = true
  componentWillReceiveProps: (nextProps) ->
    if @dirty
      @dirty = false
      @setState gameState: $.extend(true, {}, nextProps.gameState)
  render: () ->
    <div className="game-setup">
      <GameForm gameState={@state.gameState} actions={@actions}/>
    </div>