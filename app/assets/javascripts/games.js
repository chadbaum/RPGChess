$(function() {
//     // Picks up all the latest positions from
//     // the database and updates the view
//     var $currentPositions = $('#piece_pos').data('positions');
//
//     $.each( $currentPositions, function(key, value) {
//       var currentCell = 'td[data-x="' + value.x_position + '"]' +
//                         '[data-y="' + value.y_position + '"]';
//       //formula to map DB piece IDs to the IDs in front view
//       var pieceIdOnBoard = value.id % 32;
//       $('#' + pieceIdOnBoard).appendTo(currentCell);
//     });
  $('#chess-board td span').draggable({
    containment: "#chess-board",
    cursor: "all-scroll",
    opacity: 0.6,
    revert: 'invalid',
    start: function ( event, ui ) {

    }
  });

  $('#chess-board td').droppable( {
    tolerance: 'pointer',
    hoverClass: 'selected-tile',
    accept: function( draggablePiece ) {
      var targetTile = this;
      if (draggablePiece.hasClass('white') && $(targetTile).children('span').hasClass('white')) {
        return false;
      } else if (draggablePiece.hasClass('black') && $(targetTile).children('span').hasClass('black')) {
          return false;
      } else {
          return true;
      }
    },
    drop: function( event, ui ) {
      var targetTile = this;
      var draggedPiece = ui.draggable;
      $.ajax({
        method: 'PATCH',
        url: '/pieces/' + $(draggedPiece).data('id'),
        dataType: 'json',
        data: {
          id: $(event.target).data('id'),
          x: $(event.target).data('x'),
          y: $(event.target).data('y')
        }
      })
      draggedPiece.detach().css({top: 0, left: 0}).appendTo(targetTile);
    }
  });
});
