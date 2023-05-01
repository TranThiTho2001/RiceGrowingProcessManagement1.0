// module.exports = {
//   devServer: {
//     port: 8081,
//     host: '0.0.0.0'
//   },
// };
// // // // };
// const path = require("path");

const webpack = require('webpack')
const { VueLoaderPlugin } = require('vue-loader')
const HtmlWebpackPlugin = require('html-webpack-plugin')
// module.exports = {
//   // mode: 'development',
//   devServer: {
//     port: 8081,
//     host: '0.0.0.0'
//   },

// //   module: {
// //     rules: [
// //       {
// //         test: /\.tsx?$/,
// //         use: 'ts-loader',
// //         exclude: /node_modules/,
// //       },
// //     ],
// //   },
// //   resolve: {
// //     alias: {
// //       vue: "vue/dist/vue.esm-bundler.js"
// //     },
// //     extensions: ['.tsx', '.ts', '.js'],
// //   },
// //   output: {
// //     filename: 'bundle.js',
// //     path: path.resolve(__dirname, 'dist'),
// //   }
// // }
module.exports = {
    devServer: {
          port: 8081,
          host: '0.0.0.0'
        },
  configureWebpack: {

    module: {
      rules: [
        {
          // test: /\.(jpe?g|woff|woff2|eot|ttf|svg)(\?[a-z0-9=.]+)?$/,
          test: /node_modules[/\\]@polkadot*.js$/,
          loader: require.resolve('@open-wc/webpack-import-meta-loader'),
          // loader: '@open-wc/webpack-import-meta-loader',
          exclude: /\.vue$/,
        },

        {
          test: /\.(jpe?g|woff|woff2|eot|ttf|svg)(\?[a-z0-9=.]+)?$/,
          include: /node_modules[/\\|]@polkadot/i,
          // exclude: /(node_modules|bower_components)/,
          use: {
            loader: 'babel-loader',
            options: {
              presets: [
                '@babel/preset-env',
                '@vue/cli-plugin-babel/preset',
              ],
              plugins: [
                "@babel/plugin-proposal-private-methods",
                "@babel/plugin-proposal-class-properties",
                '@babel/plugin-proposal-object-rest-spread',
              ]
            }
          }
        },
      ]
    }
  },
  
}
