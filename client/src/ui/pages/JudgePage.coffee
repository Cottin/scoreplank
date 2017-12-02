createReactClass = require 'create-react-class'
PureRenderMixin = require 'react-addons-pure-render-mixin'
{object} = require 'prop-types'
{assocPath, isNil, merge, set, type} = require 'ramda' #auto_require:ramda

{createElementFela} = require '../uiUtils'

JudgePage = createReactClass
	displayName: 'JudgePage'
	mixins: [PureRenderMixin]
	getInitialState: ->
		{setNames: null}
	contextTypes:
		renderer: object
		router: object
	render: ->
		_ = createElementFela(@context.renderer)
		{db} = @props

		if isNil db
			return _ {x: 'rcc', hh: 100, ww: 100},
				_ {f: 191040, style: {fontSize: '20vw'}}, 'Laddar...'

		{player1, player2} = db

		console.log 'state', @state

		if @state.setNames
			return renderSetName(_, @, @state.setNames)

		if player1.side == 'left'
			leftPlayer = merge player1, {color: 'red', player: 1}
			rightPlayer = merge player2, {color: 'blue', player: 2}
		else
			leftPlayer = merge player2, {color: 'blue', player: 2}
			rightPlayer = merge player1, {color: 'red', player: 1}

		_ {x: 'c', hh: 100, ww: 100},
			renderPlayer(_)(leftPlayer)
			_ {hh: 3}
			renderPlayer(_)(rightPlayer)
			_ {hh: 3}
			_ {x: 'r', ww: 100, hh: 24},
				_ {ww: 32, x: 'ccc', ta: 'c', style: {backgroundColor: 'black', opacity: 0.3, color: 'white', fontSize: '5vw'}, onClick: => @startSetNames(leftPlayer, rightPlayer)}, 'Set player names'
				_ {ww: 2}
				_ {ww: 32, x: 'ccc', ta: 'c', style: {backgroundColor: 'black', opacity: 0.3, color: 'white', fontSize: '5vw'}, onClick: -> reset()}, 'Reset scores'
				_ {ww: 2}
				_ {ww: 32, x: 'ccc', ta: 'c', style: {backgroundColor: 'black', opacity: 0.3, color: 'white', fontSize: '5vw'}, onClick: -> switchSides(player1)}, 'Switch sides'

	startSetNames: (leftPlayer, rightPlayer) ->
		@setState {setNames: {leftPlayer, rightPlayer}}

renderPlayer = (_) -> ({name, score, color, player}) ->
	_ {x: 'r', ww: 100, hh: 35},
		_ {x: 'ccc', ww: 20, style: {backgroundColor: color, opacity: 0.3, color: 'white', fontSize: '20vw'}, onClick: -> set(player, score-1)}, '-'
		_ {x: 'ccc', ww: 30},
			_ {f: 191040, ta: 'c', style: {fontSize: '15vw', color}}, score
			_ {f: 191040, ta: 'c', style: {fontSize: '6vw', color}}, name
		_ {x: 'ccc', ww: 50, style: {backgroundColor: color, color: 'white', fontSize: '20vw'}, onClick: -> set(player, score+1)}, '+'

set = (player, newScore) ->
	firebase.database().ref("player#{player}/score").set(newScore)

reset = () ->
	firebase.database().ref("player1/score").set(0)
	firebase.database().ref("player2/score").set(0)

switchSides = (player1) ->
	player1NewSide = if player1.side == 'left' then 'rigth' else 'left'
	player2NewSide = if player1.side == 'left' then 'left' else 'right'
	firebase.database().ref("player1/side").set(player1NewSide)
	firebase.database().ref("player2/side").set(player2NewSide)

renderSetName = (_, comp, setNames) ->
	{leftPlayer, rightPlayer} = setNames
	save = () ->
		player1 = if leftPlayer.player == 1 then leftPlayer else rightPlayer
		player2 = if leftPlayer.player == 2 then leftPlayer else rightPlayer
		firebase.database().ref("player1/name").set(player1.name)
		firebase.database().ref("player2/name").set(player2.name)
		comp.setState {setNames: null}

	_ {x: 'c', ww: 100, hh: 100},
		renderTextBox(_, comp)(setNames, leftPlayer, 'left')
		renderTextBox(_, comp)(setNames, rightPlayer, 'right')
		_ {x: 'r', ww: 100, hh: 30},
			_ {ww: 30, x: 'ccc', ta: 'c', style: {backgroundColor: 'black', opacity: 0.3, color: 'white', fontSize: '5vw'}, onClick: => comp.setState({setNames: null})}, 'Cancel'
			_ {ww: 5}
			_ {ww: 65, x: 'ccc', ta: 'c', style: {backgroundColor: 'black', opacity: 0.3, color: 'white', fontSize: '5vw'}, onClick: save}, 'Save'

renderTextBox = (_, comp) -> (setNames, player, side) ->
	handleChange = (e) ->
		setNames_ = assocPath ["#{side}Player", 'name'], e.target.value, setNames
		comp.setState {setNames: setNames_}

	_ {x: 'ccc', hh: 35, style: {backgroundColor: player.color, fontSize: '8vw'}},
		_ 'input', {type: 'text', ww: 80, hh: 10, value: player.name, onChange: handleChange}

module.exports = JudgePage






