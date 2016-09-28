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

exit;
