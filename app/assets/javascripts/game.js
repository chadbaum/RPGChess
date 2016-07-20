// listening for clicks on <i> BS glyphicon elements
// empty cells wont have <i> elements
$('#chess-board td i').click(function() {
  // 'this' = draggable <i>
  this.draggable({
    containment: "#chess-board",
    cursor: "grab",
    opacity: 0.7
  });

  $('#chess-board td').droppable( {
    accept: 'i',
    tolerance: 'pointer',
    drop: function(event, ui) {
      // gets the x_y coords of the place where to
      // drop the piece
      var pos_x = $(event.target).data('x');
      var pos_y = $(event.target).data('y');
      // get which item is being dragged and where it
      // is being dropped
      var droppedItem = ui.draggable;
      var droppedOn = $('td[data-x="' + pos_x + '"][data-y="' + pos_y + '"]');

      // sends the new coords update to DB
      $.ajax( {
        type: 'PUT',
        url: 'games/game/id' // needs the currect url,
        dataType: 'json',
        data: {
          'x_position': pos_x,
          'y_position': pos_y
        }
      })
      // if move is valid - removes draggable
      // element from old cell and appends to
      // new coordinates
      .success( function() {
          $(droppedItem).remove();
          droppedOn.append(droppedItem);
      });
    }
  });
});

