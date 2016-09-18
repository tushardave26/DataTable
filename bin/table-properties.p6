#!/Applications/Rakudo/bin/perl6

use v6;
use lib '../lib';
use Data::Dump;
use DataTable;

my $dt = DataTable.new(data => [["Tushar", "Dave", 29], ["John", "Adams", 30]],
    header => ["Fname", "Lname", "Age"],
    type => 1
);

#my $dt = DataTable.new(data => [["Tushar", "Dave", 29, "ABC"], ["John", "Adams", 30]],
    #header => ["Fname", "Lname", "Age"],
    #type => 1
#);

#my $dt = DataTable.new(data => [["Tushar", "Dave", 29], ["John", "Adams", 30]],
    #header => ["Fname", "Lname"],
    #type => 1
#);

# get dimention of a table i.e. # of rows and cols.
my $dim = $dt.dim();
say "Dimensions are -- ", $dim;

# get no of rows
my $nrows = $dt.no-of-rows;
say "No of rows -- ", $nrows;

# get no of cols
my $ncols = $dt.no-of-cols;
say "No of cols -- ", $ncols;

# get last-row index
my $l-row-index = $dt.last-row;
say "Last row index -- ", $l-row-index;

# get last-col index
my $l-col-index = $dt.last-col;
say "Last col index -- ", $l-col-index;

# get col-index from column name
#my $col-index = $dt.col-index;
#say "Col index is -- ", $col-index;

# get col name from col index
#my $col-name = $dt.col-name;
#say "Col name is -- ", $col-name;

#my %prop;

#%prop<rows> = $dt.data.elems;

#%prop<cols> = $dt.data.[0].elems;

#join("\t", $dt.data.elems, $dt.data.[0].elems).say;

#say Dump(%prop);

exit;
