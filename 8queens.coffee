class EightQueens
  constructor: ->
    @placementHistory = []
    @grid = (false for i in [1..8] for j in [1..8])

  print: ->
    for row in @grid
      line = ""
      for square in row
        line += (if square then "Q" else ".")
      console.log line
    console.log ""

  placeQueen: (r,c) ->
    return false unless @isValidPlacement(r,c)
    @placementHistory.push([r,c])
    @grid[r][c] = true
    true

  removeLastQueen: (r,c) ->
    return false if @placementHistory.length == 0
    [r, c] = @placementHistory.pop()
    @grid[r][c] = false
    true

  isValidPlacement: (r,c) ->
    for [r2, c2] in @placementHistory
      if r == r2 || c == c2 || (r2-r) == (c2-c) || (r2-r) == -(c2-c)
        return false
    true

  placeAllQueens: ({ random } = {}) ->
    if @placementHistory.length == 0
      previousRow = -1
    else
      [..., [previousRow, ...]] = @placementHistory
    console.log previousRow
    console.log @grid
    nextRow = (previousRow)  + 1
    if nextRow >= 8
      return true
    for nextColumn in [0...8]
      if @placeQueen(nextRow, nextColumn)
        if @placeAllQueens()
          return true
    console.log "Something went horribly wrong! We didn't find any solutions."
    @removeLastQueen()
    return false


q = new EightQueens

q.placeAllQueens({random: true})
q.print()
