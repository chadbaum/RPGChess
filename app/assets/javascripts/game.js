$(function() {
    // Makes all cells that have <i> elements
    // draggble. If move is invalid, the piece will
    // return to its cell
    $('#chess-board td i').draggable({
      containment: "#chess-board",
      cursor: "all-scroll",
      opacity: 0.7,
      revert: 'invalid'
    });
    // Each cell will accept only <i> elements.
    // Only when pointer hovers over the cell
    // the drop will occur.
    $('#chess-board td').droppable( {
      accept: 'i',
      tolerance: 'pointer',
      drop: function(event, ui) {
        // gets the x_y coords of the place where to
        // drop the piece
        var pos_x = $(event.target).data('x');
        var pos_y = $(event.target).data('y');

        // get which item is being dragged
        var droppedItem = ui.draggable;

        // sends the new coords update to DB
        $.ajax( {
          type: 'PATCH',
          url: 'games/game/id', // needs the currect url,
          dataType: 'json',
          data: {
            'x_position': pos_x,
            'y_position': pos_y
          }
        })
        // If move is valid - removes draggable
        // element from old cell and appends to
        // new coordinates - 'this'.
        .success( function() {
            $(droppedItem).detach().css({top: 0, left: 0}).appendTo(this);
        });
      }
    });
});