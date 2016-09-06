var addDraggable = function() {
  $('.piece').draggable({
    containment: "#chess-board",
    cursor: "all-scroll",
    opacity: 0.6,
    revert: 'invalid',
    cancel: '.captured-piece',
    create: function( event, ui ) {toggleDraggable},
    stop: function( event, ui ) {
      $('#chess-board td').each(function( element ) {
        $(this).removeClass( 'valid-move-tile' );
      });
    },
    start: function( event, ui ) {
      var draggedPiece = this;
      showValidMoves( draggedPiece );
    }
  });
};

var addDroppable = function() {
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
      var droppedPiece = ui.draggable;
      var tileX = $(event.target).data('x');
      var tileY = $(event.target).data('y');
      updatePieceMove( droppedPiece, tileX, tileY );
      $(droppedPiece).detach().css({top: 0, left: 0}).appendTo(targetTile);
    }
  });
}


var toggleDraggable = function() {
  var turn = $('#chess-board').data('turn');
  if (turn % 2 == 0){
    $('.white').draggable( 'disable' );
    $('.black').draggable( 'enable' );
    //$('.white').unbind('mouseenter mouseleave'); //FIX
  }
  else {
    $('.black').draggable( 'disable' );
    $('.white').draggable( 'enable' );
    //$('.black').unbind('mouseenter mouseleave');//FIX
  }
};

var addValidMoveTile = function( validMoves ) {
  $('#chess-board td').each(function( element ) {
    var tile = this;
    var tileX = $(this).data('x');
    var tileY = $(this).data('y');
    for (var i = 0; i < validMoves.length; i++) {
      if (tileX === validMoves[i][0] && tileY === validMoves[i][1]) {
        $(tile).addClass( 'valid-move-tile' );
      }
    }
  });
}

var refreshScoreBoard = function () {
  $.ajax({
    method: 'GET',
    url: '/games/' + $('#chess-board').data('id') + '/refresh',
    dataType: 'html',
    success: function( data ) {
      $('#scoreboard').html(data);
    }
  })
}

var refreshChessBoard = function () {
  $.ajax({
    method: 'GET',
    url: '/games/' + $('#chess-board').data('id') + '/refreshboard',
    dataType: 'html',
    success: function( data ) {
      $('#chess').html(data);
      addDraggable();
      addDroppable();
      toggleDraggable();
    }
  })
}

var showValidMoves = function ( draggedPiece ) {
  $.ajax({
    method: 'GET',
    url: '/pieces/' + $(draggedPiece).data('id'),
    dataType: 'json',
    success: function( validMoves ){
      addValidMoveTile( validMoves );
    }
  })
}

var updatePieceMove = function ( droppedPiece, tileX, tileY ) {
  $.ajax({
    method: 'PATCH',
    url: '/pieces/' + $(droppedPiece).data('id'),
    data: {
      x: tileX,
      y: tileY
    },
    success: [refreshScoreBoard, refreshChessBoard],
    error: function() { console.error( arguments ) }
  })
}

$(function() {
  addDraggable();
  addDroppable();
  toggleDraggable();
});







// setTimeout(function(){
//   window.location.reload(1);
// }, 15000);

// $('#chess-board td').hover(
//   function() {
//     var hoveredTile = this;
//     var hoveredPiece = $(this).children('span');
//     if (typeof $(hoveredPiece).data('id') === 'number') {
//       $.ajax({
//         method: 'GET',
//         url: '/pieces/' + $(hoveredPiece).data('id'),
//         dataType: 'json',
//         success: function( validMoves ){
//           $('#chess-board td').each(function( element ) {
//             var tile = this;
//             var tileX = $(this).data('x');
//             var tileY = $(this).data('y');
//             for (var i = 0; i < validMoves.length; i++) {
//               if (tileX === validMoves[i][0] && tileY === validMoves[i][1]) {
//                 $(tile).addClass( 'valid-move-tile' );
//               }
//             }
//           });
//         }
//       })
//     }
//   }, function() {
//     $('#chess-board td').removeClass( 'valid-move-tile' );
//   }
// );
