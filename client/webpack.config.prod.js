var path = require('path');
var webpack = require('webpack');

module.exports = {
  devtool: 'source-map',
  entry: [
    './src/main'
  ],
  output: {
    path: path.join(__dirname, 'dist'),
    filename: 'bundle.js',
    publicPath: '/static/'
  },
  plugins: [
    new webpack.optimize.OccurenceOrderPlugin(),
    new webpack.DefinePlugin({
      'process.env': {
        'NODE_ENV': JSON.stringify('production')
      },
      DEV: false,
    }),
  ],
  resolve: {
    extensions: ['', '.js', '.coffee'],
  },
  module: {
    loaders: [{
      test: /\.js$/,
      loaders: ['react-hot', 'babel'],
      include: path.join(__dirname, 'src')
    },
    {
      test: /\.coffee?$/,
      loaders: ['react-hot', 'babel', 'coffee-loader'],
      include: [
        path.join(__dirname, 'src')
      ]
    },
    { test: /\.css$/, loader: "style-loader!css-loader" },
    { test: /\.svg$/, loaders: ['raw', 'svgo'] }
    ]
  }
};
