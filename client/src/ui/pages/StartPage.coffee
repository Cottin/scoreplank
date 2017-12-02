createReactClass = require 'create-react-class'
PureRenderMixin = require 'react-addons-pure-render-mixin'
{object} = require 'prop-types'
{view} = require 'ramda' #auto_require:ramda
{Link} = require 'react-functional-router'

{createElementFela} = require '../uiUtils'

StartPage = createReactClass
	displayName: 'StartPage'
	mixins: [PureRenderMixin]
	contextTypes:
		renderer: object
		router: object
	render: ->
		_ = createElementFela(@context.renderer)
		_ {x: 'ccc', hh: 100, ww: 100},
			_ {x: 'ccc'},
				_ Link, {page: 'score', style: {fontSize: 30}}, 'Score view'
				_ {style: {fontSize: 15, textAlign: 'center'}}, 'Open this on your TV'
			_ {hh: 10}
			_ {x: 'ccc'},
				_ Link, {page: 'judge', style: {fontSize: 30}}, 'Judge view'
				_ {style: {fontSize: 15, textAlign: 'center'}}, 'Let judge open this on his/her smartphone'

module.exports = StartPage






