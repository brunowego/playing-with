import webpack, { Configuration } from 'webpack';
import merge from 'webpack-merge';
import { join } from 'path';
import commonConfig from './webpack.config.common';

process.title = 'webpack-dev-server';

const config: Configuration = merge(commonConfig, {
    mode: 'development',

    devServer: {
        contentBase: join(__dirname, '..', 'public'),
        inline: true
    },

    module: {
        rules: [
            {
                test: /\.less$/,
                loaders: ['style-loader', 'css-loader', 'less-loader']
            }
        ]
    },

    plugins: [
        new webpack.HotModuleReplacementPlugin({})
    ]
});

export default config;
