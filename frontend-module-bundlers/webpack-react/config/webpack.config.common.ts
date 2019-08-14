import { Configuration } from 'webpack';
import { resolve } from 'path';
import HtmlWebpackPlugin from 'html-webpack-plugin';

const config: Configuration = {
    entry: {
        app: './src/index.tsx',
        vendor: ['react', 'react-dom']
    },

    output: {
        filename: '[name].[hash].js'
    },

    resolve: {
        extensions: ['.ts', '.tsx', '.js'],
        modules: ['node_modules', resolve(__dirname, 'src')]
    },

    module: {
        rules: [
            {
                test: /\.(j|t)sx?$/,
                use: 'babel-loader',
                exclude: /node_modules/
            }
        ],
    },

    plugins: [
        new HtmlWebpackPlugin({
            title: 'Bundler with Webpack',
            template: './public/index.html'
        })
    ]
}

export default config;
