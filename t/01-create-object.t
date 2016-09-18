use v6;
use Test;
use lib '../lib';
use DataTable;

plan 3;

my $dt1 = DataTable.new(data => []);

my $dt2 = DataTable.new(data => [["Tushar", "Dave", 29], ["John", "Adams", 22]],
                        header => ["Fname", "Lname", "Age"]
                       );

my $dt3 = DataTable.new(data => [["Tushar", "Dave", 29], ["John", "Adams", 22]],
                        header => ["Fname", "Lname", "Age"],
                        type => 1
                       );

isa-ok $dt1, DataTable, "Great!! Table object is created successfully with no data.";

isa-ok $dt2, DataTable, "Great!! Table object is created successfully with data and header.";

isa-ok $dt3, DataTable, "Great!! Table object is created successfully with data, header and type.";

#done-testing;
