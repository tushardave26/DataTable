#!/Applications/Rakudo/bin/perl6

use v6;
use lib '../lib';
#use Data::Dump;
use DataTable;

my $dt = DataTable.new(data => [["Tushar", "Dave"], ["John", "Adams"]],
    header => ["Fname", "Lname"],
    type => 1
);

#say Dump($dt);

exit;
