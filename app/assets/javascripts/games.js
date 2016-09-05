$(function() {

  // setTimeout(function(){
  //   window.location.reload(1);
  // }, 15000);

  $('#chess-board td span').draggable({
    containment: "#chess-board",
    cursor: "all-scroll",
    opacity: 0.6,
    revert: 'invalid',
    stop: function( event, ui ) {
      $('#chess-board td').each(function( element ) {
        $(this).removeClass( 'valid-move-tile' );
      });
    },
    start: function( event, ui ) {
      var draggedPiece = this;
      $.ajax({
        method: 'GET',
        url: '/pieces/' + $(draggedPiece).data('id'),
        dataType: 'json',
        success: function( validMoves ){
          $('#chess-board td').each(function( element ) {
            var tile = this;
            var tileX = $(this).data('x'); //correct
            var tileY = $(this).data('y'); //correct
            for (var i = 0; i < validMoves.length; i++) {
              if (tileX === validMoves[i][0] && tileY === validMoves[i][1]) {
                $(tile).addClass( 'valid-move-tile' );
              }
            }
          });
        }
      })
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
      if ($(targetTile).hasClass('valid-move-tile')) {
        return true;
      } else {
        return false;
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
