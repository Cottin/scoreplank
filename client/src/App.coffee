{DOM: {div}, createElement: _} = React = require 'react'
createReactClass = require 'create-react-class'
{RouterProvider, createRouter} = require 'react-functional-router'
{Provider: FelaProvider} = require 'react-fela'
firebase = require 'firebase'

Body = require './ui/Body'


App = createReactClass
	componentWillMount: ->
		onRouterChange = (state, delta) =>
			@setState delta

		@router = createRouter {onChange: onRouterChange}

		firebase.initializeApp
			apiKey: 'AIzaSyDT5gKuUh9Dv-ecyRp9EdoNxm42gLlnnpg'
			databaseURL: 'https://scoreplank-23ac0.firebaseio.com'
			projectId: 'scoreplank-23ac0'
			storageBucket: 'scoreplank-23ac0.appspot.com'
			messagingSenderId: '361374462937'

		window.firebase = firebase

		db = firebase.database().ref()
		db.on 'value', (snap) =>
			@setState {db: snap.val()}

	render: ->
		{phlox, router, felaRenderer, felaMountNode} = @props
		div {},
			_ RouterProvider, {router: @router},
				_ FelaProvider, {renderer: felaRenderer},
					div {className: 'app__root'},
						_ Body, @state

module.exports = App


