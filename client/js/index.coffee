React = require 'react'
_     = require 'lodash'


{a, p, polygon, svg, path, div, input} = React.DOM

concatenationOfPoints = (points) ->
  _.reduce points, (concatenation, point) ->
    concatenation + ' ' + point

specifyPath = (points) ->
  
  specification = 'M '
  specification += points[0]

  for pointIndex in [1.. points.length - 1] by 1
    specification += ' L '
    specification += points[ pointIndex ][0]
    specification += ' '
    specification += points[ pointIndex ][1]

  specification += ' z'
  specification


AppClass = React.createClass


  getInitialState: ->
    points: [ [40, 40], [120, 40], [80, 120] ]


  adjustDimension: (event) ->

    dimensionIndex = event.target.getAttribute 'data-dimension'
    pointIndex     = event.target.getAttribute 'data-point'
    @state.points[ pointIndex ][ dimensionIndex ] = event.target.value
    @setState points: @state.points


  addPointToEnd: ->
    newPoint = [0, 0]
    newPoint[0] += @state.points[ @state.points.length - 1 ][0]
    newPoint[1] += @state.points[ @state.points.length - 1 ][1]

    @state.points.push newPoint
    @setState points: @state.points


  deletePoint: ->
    pointIndex = event.target.getAttribute 'data-point'
    @state.points.splice pointIndex, 1
    @setState points: @state.points


  render: ->

    div null,
      div className: 'spacer'
      div className: 'indent',
        div className: 'container',
          div className: 'row',
            div className: 'column',

              p
                className: 'point'
                'CtVector'

            div className: 'column',

              input
                className: 'submit'
                type:      'submit'
                value:     'download SVG'
                onClick:   @download


          _.map @state.points, (point, pointIndex) =>
            div className: 'row',

              div className: 'column',

                p
                  className: 'point'
                  pointIndex

              _.map point, (dimension, dimensionIndex) =>
                div className: 'column',

                  input
                    className:        'input'
                    value:            dimension
                    'data-point':     pointIndex
                    'data-dimension': dimensionIndex
                    onChange:         @adjustDimension

              div className: 'column',

                input
                  className:        'submit'
                  type:             'submit'
                  value:            'DEL'
                  'data-point':     pointIndex
                  onClick:          @deletePoint


          div className: 'row',

            input
              className: 'submit'
              type:      'submit'
              value:     '+'
              onClick:   @addPointToEnd   

          div className: 'row',

            svg
              width:    200
              height:   200
              version:  '1.1'
              xmlns:    'http://www.w3.org/2000/svg'

              path
                d: specifyPath @state.points
                fill: '#ff0000'


              # path
              #   d:    'M100 100 C 100 200, 100 200, 200 200 C 100 200, 100 200, 200 100 z'
              #   fill: '#00ff00'




App = React.createFactory AppClass

ctSVG = new App()

element = document.getElementById 'content'

React.render ctSVG, element