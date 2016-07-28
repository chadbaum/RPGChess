$(function() {
    // Picks up all the lates positions from
    // the database
    var currentPositions = $('.piece_pos').data('positions');
    $.each(currentPositions, function(key, value) {
      console.log(key + ":    " + value.x_position + "," + value.y_position);
    });
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
      hoverClass: 'highlighted-cell',
      drop: function(event, ui) {
        // gets the x_y coords of the place where to
        // drop the piece
        var pos_x = $(event.target).data('x');
        var pos_y = $(event.target).data('y');

        // get which item is being dragged
        var droppedItem = ui.draggable;

        // sends the new coords update to DB
        var current_url = window.location.pathname;
        var game_id = current_url.substring(current_url.lastIndexOf('/') + 1);
        var thisCell = this;
        var pieceIdInDB = Number( droppedItem.attr('id') ) + ((game_id - 1) * 32)
        $.ajax( {
          type: 'PATCH',
          // headers: {
          //   'Content-Type': 'application/json',
          //   'Accept': 'application/json'
          // },
          url: '../games/' + game_id,
          dataType: 'json',
          data: {

              piece_id: pieceIdInDB,
              x_position: pos_x,
              y_position: pos_y

          }
        })
        // If move is valid - removes draggable
        // element from old cell and appends to
        // new coordinates - 'this'.
        .success( function() {
            $(droppedItem).detach().css({top: 0, left: 0}).appendTo(thisCell);
        });
      }
    });
});