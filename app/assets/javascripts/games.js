$(function() {

  setTimeout(function(){
    window.location.reload(1);
  }, 15000);

  $('#chess-board td span').draggable({
    containment: "#chess-board",
    cursor: "all-scroll",
    opacity: 0.6,
    revert: 'invalid',
    start: function ( event, ui ) {
      //PUT AVAILABLE MOVES HERE
    }
  });

  $(function(){
    var turnNumber = parseInt($('#turn').html());
    if (turnNumber % 2 == 0){
      $('.white').draggable( 'disable' )
    }
    else {
      $('.black').draggable( 'disable' )
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
          x: $(event.target).data('x'),
          y: $(event.target).data('y')
        }
      })
      draggedPiece.detach().css({top: 0, left: 0}).appendTo(targetTile);
      location.reload();
    }
  });
});
