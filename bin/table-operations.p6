#!/Applications/Rakudo/bin/perl6

use v6;
#use lib '/Users/tushardave26/Documents/Learning/Perl6/DataTable/lib';
use lib '../lib';
use Data::Dump;
use DataTable;

my $dt = DataTable.new(data => [["Tushar", "Dave", 29], ["John", "Adams", 30]],
    header => ["Fname", "Lname", "Age"],
);

#my @row = $dt.get-row(index => [0,1]);
#my @row = $dt.get-row(index => 0);
#$row.say;

#my @col = $dt.get-col(index => [0..2]);
#my @col = $dt.get-col(index => 2);
#@col.say;

#my $val = $dt.get-elm(row-index => 1, col-index => 0);
#$val.say;

#$dt.set-elm(row-index => 1, col-index => 0, value => "Hari");
#$dt.get-elm(row-index => 1, col-index => 0).say;

#$dt.add-row(data => ["Harish", "Dave", 62]);
$dt.add-row(values => ["Harish", "Dave", 62], index => 0);

say Dump($dt.data);

exit;
