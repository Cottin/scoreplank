createReactClass = require 'create-react-class'
PureRenderMixin = require 'react-addons-pure-render-mixin'
{object} = require 'prop-types'
{isNil, merge} = require 'ramda' #auto_require:ramda

{createElementFela} = require '../uiUtils'

ScorePage = createReactClass
	displayName: 'ScorePage'
	mixins: [PureRenderMixin]
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

		if player1.side == 'left'
			leftPlayer = merge player1, {color: 'red'}
			rightPlayer = merge player2, {color: 'blue'}
		else
			leftPlayer = merge player2, {color: 'blue'}
			rightPlayer = merge player1, {color: 'red'}

		_ {x: 'rac', hh: 100, ww: 100},
			renderPlayer(_)(leftPlayer)
			renderPlayer(_)(rightPlayer)

renderPlayer = (_) -> ({name, score, color}) ->
	_ {x: 'ccc'},
		_ {f: 191040, style: {fontSize: '30vw', color}}, score
		_ {f: 191040, style: {fontSize: '5vw', color}}, name

module.exports = ScorePage






