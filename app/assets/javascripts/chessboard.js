$(function() {
    // draw the chess board
    for (var y = 0; y <= 7; y++) {
        $("#chess-board").append(
          "<tr>" +
            "<td data-x='0' data-y='" + y + "'></td>" +
            "<td data-x='1' data-y='" + y + "'></td>" +
            "<td data-x='2' data-y='" + y + "'></td>" +
            "<td data-x='3' data-y='" + y + "'></td>" +
            "<td data-x='4' data-y='" + y + "'></td>" +
            "<td data-x='5' data-y='" + y + "'></td>" +
            "<td data-x='6' data-y='" + y + "'></td>" +
            "<td data-x='7' data-y='" + y + "'></td>" +
          "</tr>");
    }

    // draw black pawns
    for (var i = 0, c = 9; i <= 7; i++, c++) {
        $('td[data-x="' + i + '"][data-y="1"]').append(
          '<i id="' + c + '" class="black-pcs glyphicon glyphicon-pawn">');
        }
    // draw white pawns
    for (var i = 0; i <= 7; i++) {
        $('td[data-x="' + i + '"][data-y="6"]').append(
          '<i class="white-pcs glyphicon glyphicon-pawn">');
        }
    // assign variables to initial positions based on
    // their data attributes
    // white piece variables
    var white_rooks = 'td[data-x="0"][data-y="0"],' +
                        'td[data-x="7"][data-y="0"]';

    var white_bishops = 'td[data-x="2"][data-y="0"],' +
                          'td[data-x="5"][data-y="0"]';

    var white_knights = 'td[data-x="1"][data-y="0"],' +
                          'td[data-x="6"][data-y="0"]';

    var white_queen = 'td[data-x="4"][data-y="0"]';
    var white_king = 'td[data-x="3"][data-y="0"]';

    // black piece variables
    var black_rooks = 'td[data-x="0"][data-y="7"],' +
                        'td[data-x="7"][data-y="7"]';

    var black_bishops = 'td[data-x="2"][data-y="7"],' +
                          'td[data-x="5"][data-y="7"]';

    var black_knights = 'td[data-x="1"][data-y="7"],' +
                          'td[data-x="6"][data-y="7"]';

    var black_queen = 'td[data-x="3"][data-y="7"]';
    var black_king = 'td[data-x="4"][data-y="7"]';

    // appent BS glyphicons to each <td> elements
    // black figures
    $(white_rooks).append(
        '<i class="black-pcs glyphicon glyphicon-tower">');
    $(white_bishops).append(
        '<i class="black-pcs glyphicon glyphicon-bishop">');
    $(white_knights).append(
        '<i class="black-pcs glyphicon glyphicon-knight">');
    $(white_queen).append(
        '<i class="black-pcs glyphicon glyphicon-queen">');
    $(white_king).append(
        '<i class="black-pcs glyphicon glyphicon-king">');

    // white figures
    $(black_rooks).append(
        '<i class="white-pcs glyphicon glyphicon-tower">');
    $(black_bishops).append(
        '<i class="white-pcs glyphicon glyphicon-bishop">');
    $(black_knights).append(
        '<i class="white-pcs glyphicon glyphicon-knight">');
    $(black_queen).append(
        '<i class="white-pcs glyphicon glyphicon-queen">');
    $(black_king).append(
        '<i class="white-pcs glyphicon glyphicon-king">');

    });

// in the future here is the logic to use to assign classes.
// It will just swith predefined classes in CSS
// write in ERB if player has black pieces do
// <script>
// $('.white-pcs').removeClass('white-pcs').addClass('black-pcs');
// $('black-pcs').addClass('white-pcs').removeClass('black-pcs');
// </script>