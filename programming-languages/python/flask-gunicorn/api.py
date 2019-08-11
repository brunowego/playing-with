"""
Simple REST API example using Flask (web framework).

The objective here is demonstrate how create a API with Flask and expose it with
multiple endpoints.
"""
from flask import Flask

api = Flask(__name__)


@api.route('/')
def home():
    """Display home message."""
    return 'Hey, we have Flask running!'


@api.route('/members')
def members():
    """Instructions to show a single member."""
    return 'You can put name after "/members/".'


@api.route('/members/<string:name>')
def getMember(name):
    """Greeting to called member."""
    return 'Hi, ' + name + '.'


if __name__ == '__main__':
    api.run(host='0.0.0.0', port=5000)
