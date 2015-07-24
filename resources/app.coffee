require.config
  paths:
    jquery:
      '../lib/jquery-1.11.3.min'
    handlebars:
      '../lib/handlebars-v3.0.3'
    text:
      '../lib/text'

require ['article/article', 'jquery', 'handlebars'], (Article, $, Handlebars) ->
  return
