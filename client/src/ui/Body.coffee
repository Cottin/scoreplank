createReactClass = require 'create-react-class'
PureRenderMixin = require 'react-addons-pure-render-mixin'
{object} = require 'prop-types'
{isNil} = require 'ramda' #auto_require:ramda

{createElementFela} = require './uiUtils'

StartPage = require './pages/StartPage'
ScorePage = require './pages/ScorePage'
JudgePage = require './pages/JudgePage'
uiUtils = require './uiUtils'


Body = createReactClass
	displayName: 'ScorePage'
	mixins: [PureRenderMixin]
	contextTypes:
		renderer: object
		router: object
	render: ->
		_ = createElementFela(@context.renderer)
		console.log(@props)
		{page} = @props
		_ {wp: 100},
				if page == "" || isNil page then _ StartPage
				if page == 'score' then _ ScorePage, @props
				if page == 'judge' then _ JudgePage, @props
				# else if page == 'judge' then _ JudgePage_
				else
					_ {}, '404 - Page not found'


module.exports = Body


