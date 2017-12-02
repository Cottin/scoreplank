{none, test} = require 'ramda' #auto_require:ramda
{cc} = require 'ramda-extras'

_ERR = 'Error: '

##### Probably things you'd want to override in your application:
##### Implementations below are provided as inspiration / templates

# font = "text"
f = (x) ->
	x_ = x + ''
	if ! test /^\d{6}$/, x_
		throw new Error "t expects a 6-digit number, given: #{x}, see docs"

	ret = {}

	ret.fontWeight = parseInt(x_[4]) * 100

	family = x_[0]
	if family == '1' then ret.fontFamily = 'Roboto, sans-serif'
	else throw new Error _ERR + "invalid family '#{family}' for t: #{x}"

	size = parseInt x_[1]
	switch size
		when 0 then ret.fontSize = 8 + 'px'
		when 1 then ret.fontSize = 9 + 'px'
		when 2 then ret.fontSize = 11 + 'px'
		when 3 then ret.fontSize = 14 + 'px'
		when 4 then ret.fontSize = 16 + 'px'
		when 5 then ret.fontSize = 18 + 'px'
		when 6 then ret.fontSize = 22 + 'px'
		when 7 then ret.fontSize = 27 + 'px'
		when 8 then ret.fontSize = 57 + 'px'
		when 9 then ret.fontSize = 999 + 'px'
		else throw new Error _ERR + "invalid size '#{size}' for t: #{x}"

	color = parseInt x_[2]
	opa = parseInt(x_[3])
	opacity = if opa == 0 then 1 else opa / 10
	switch color
		when 1 then ret.color = "rgba(0, 0, 0, #{opacity})"
		when 2 then ret.color = "rgba(255, 0, 0, #{opacity})"
		when 3 then ret.color = "rgba(0, 0, 255, #{opacity})"
		else throw new Error _ERR + "invalid color '#{color}' for t: #{x}"

	ret.fontWeight = parseInt(x_[4]) * 100

	shadow = parseInt x_[5]
	switch shadow
		when 0 then # noop
		else throw new Error _ERR + "invalid shadow '#{shadow}' for t: #{x}"

	return ret


#auto_export:none_
module.exports = {f}