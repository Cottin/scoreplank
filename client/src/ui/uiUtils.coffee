{merge, none, prop, props, type} = require 'ramda' #auto_require:ramda
{ymapObjIndexed} = require 'ramda-extras'
React = require 'react'
{object} = require 'prop-types'
shortstyle = require 'shortstyle'
createReactClass = require 'create-react-class'
PureRenderMixin = require 'react-addons-pure-render-mixin'

styleMaps = require './styleMaps'

attrMaps = {}
attrMaps.is = (x) -> {id: x} # hack to be able to use is as a label

_calculateProps = shortstyle styleMaps, attrMaps

# Runs supplied props through shortstyle and runs the result through fela and
# lastly calls React.createElement
createElementFela = (renderer) -> ->
	[a0]  = arguments

	if type(a0) == 'String'
		_createElementString.apply renderer, arguments
	else if type(a0) == 'Object'
		_createElementDiv.apply renderer, arguments
	else
		_createElementComponent.apply renderer, arguments


_createElementString = (s, props, children...) ->
	[props_, style] = _calculateProps(props)
	className = @renderRule (-> style), {}
	React.createElement s, merge(props_, {className}), children...

_createElementDiv = (props, children...) ->
	[props_, style] = _calculateProps(props)
	className = @renderRule (-> style), {}
	React.createElement 'div', merge(props_, {className}), children...
	# React.createElement 'div', merge(props_, {style}), children...

_createElementComponent = (component, props, children...) ->
	# React.createElement component, props, children...
	[props_, style] = _calculateProps(props)
	className = @renderRule (-> style), {}
	React.createElement component, merge(props_, {className}), children...


#auto_export:none_
module.exports = {attrMaps, createElementFela}