const path = require("path");
const glob = require("glob");
const merge = require("webpack-merge");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const TerserPlugin = require("terser-webpack-plugin");
const OptimizeCSSAssetsPlugin = require("optimize-css-assets-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");

let common = {
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader",
        },
      },
      {
        test: /\.css$/,
        use: [MiniCssExtractPlugin.loader, "css-loader"],
      },
    ],
  },
  optimization: {
    minimizer: [
      new TerserPlugin({
        cache: true,
        parallel: true,
        sourceMap: false,
      }),
      new OptimizeCSSAssetsPlugin({}),
    ],
  },
};

module.exports = [
  merge(common, {
    entry: {
      "./js/app.js": glob.sync("./vendor/**/*.js").concat(["./js/app.js"]),
    },
    output: {
      filename: "app.js",
      path: path.resolve(__dirname, "../priv/static/js"),
    },
    resolve: {
      modules: ["node_modules", __dirname + "/app"],
    },
    plugins: [
      new MiniCssExtractPlugin({ filename: "../css/app.css" }),
      new CopyWebpackPlugin([{ from: "static/", to: "../" }]),
    ],
  }),
  merge(common, {
    entry: {
      "./js/app.js": glob.sync("./vendor/**/*.js").concat(["./js/admin.js"]),
    },
    output: {
      filename: "admin.js",
      path: path.resolve(__dirname, "../priv/static/js"),
    },
    resolve: {
      modules: ["node_modules", __dirname + "/app"],
    },
    plugins: [
      new MiniCssExtractPlugin({ filename: "../css/admin.css" }),
      new CopyWebpackPlugin([{ from: "static/", to: "../" }]),
    ],
  }),
];
