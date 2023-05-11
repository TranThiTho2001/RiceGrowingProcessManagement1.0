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
  
  
}
