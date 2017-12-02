require 'event-source-polyfill'
require 'whatwg-fetch'

React = require 'react'
ReactDOM = require 'react-dom'
{forEach, keys} = R = require 'ramda' #auto_require:ramda
{ymap, yevolve} = RE = require 'ramda-extras'
fela = require 'fela'
{createRouter} = require 'react-functional-router'

require './normalize.css'
require './style.css'

App = React.createFactory require('./App')


felaMountNode = document.getElementById('stylesheet')
felaRenderer = fela.createRenderer(felaMountNode)



install = (o, target) ->
	addKey = (k) -> target[k] = o[k]
	forEach addKey, keys o
	
install {R}, window
install R, window

install {RE}, window
install RE, window

ReactDOM.render(App({felaRenderer}), document.getElementById('root'))
