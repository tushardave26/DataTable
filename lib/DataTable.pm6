use v6.c;
use Text::Table::Simple;

unit class DataTable:ver<0.0.1>:auth<github:tushardave26>;

#custom types
subset Int-or-Str where Int|Str;
subset Array-or-Str where Array|Str;
subset Array-or-Int where Array|Int;

#attributes
has Array @.data is rw = [];
has Int-or-Str @.header is rw = [];
has Int $.type is readonly = 0;

#methods

# This method performs several sanity checks.
method !sanity-check () {

    # 1. check whether all elements of all arrays of array of arrays (i.e. data) is equal or not
    unless [==] @!data {
        fail "The number of observations in each rows are not equal.!!";
    }

    # 2. check whether the header is provided in object creation or not
    unless @!header {
        @!header = @!data[0].keys.map('V'~*)
    }

    # 3. check whether the number of observation meaning number of elements in a row is equal to
    # number of columns or not
    unless @!data.[0].elems == @!header.elems {
        fail "The number of observations and number of columns are not equal.!!";
    }

    #return True;
}

method get-content ( --> Array) {
    return @!data;
}

method generate-table () {

    #generate table array
    my @table = lol2table(@!header, @!data);

    #print table
    .say for @table;

}

method get-table-content ( --> Array) {

    return [@!header, @!data];
}

method dim ( --> Str) {

    # check the provided data consistency and other possible issues
    self!sanity-check;

    return join(" ", @!data.elems, @!header.elems);
}

method no-of-rows ( --> Int) {

    # check the provided data consistency and other possible issues
    self!sanity-check;

    return @!data.elems;
}

method no-of-cols ( --> Int) {

    # check the provided data consistency and other possible issues
    self!sanity-check;

    return @!header.elems;
}

method last-row ( --> Int) {

    # check the provided data consistency and other possible issues
    self!sanity-check;

    #return @!data.elems - 1;
    return @!data.end;
}

method last-col ( --> Int) {

    # check the provided data consistency and other possible issues
    self!sanity-check;

    #return @!header.elems - 1;
    return @!header.end;
}

method col-index (Cool :$col-name --> Int) {

    # check the provided data consistency and other possible issues
    self!sanity-check;

    unless so $col-name eq @!header.any {
        fail "Column $col-name is not exists. Please check your column name.";
    }

    return @!header.antipairs.hash{$col-name};
}

method col-name (Int :$col-index --> Cool) {

    # check the provided data consistency and other possible issues
    self!sanity-check;

    if $col-index > @!header.elems - 1 {
        fail "Column index out of bounds.";
    }

    return @!header[$col-index];
}

method header (Int :$as = 1 --> Array-or-Str) {

    # check the provided data consistency and other possible issues
    self!sanity-check;

    return $as == 1 ?? @!header !! @!header.join(" ");
}

method type ( --> Str) {

    # check the provided data consistency and other possible issues
    self!sanity-check;

    return $!type == 0 ?? ("0: ", "Row-Wise").join("") !! ("1: ", "Col-wise").join("");
}

method is-empty ( --> Bool) {

    return !@!data ?? True !! False;

}

multi method get-row (Int :$index! --> Array) {

    # check the provided data consistency and other possible issues
    self!sanity-check;

    if $index > self.last-row {
        fail "Row index out of bounds";
    }

    return @!data[$index].Array;
}

multi method get-row (:@index! --> Array) {

    # check the provided data consistency and other possible issues
    self!sanity-check;

    if so all @!data[@index]:exists and @index.all ~~ Int {
        return @!data[@index].Array;
    } else {
        fail "Table doesn't have one or more rows that asked. Please check your indexes.";
    }
}

multi method get-col (Int :$index! --> Array) {

    # check the provided data consistency and other possible issues
    self!sanity-check;

    if $index > self.last-col {
        fail "Column index out of bouns";
    }

    return @!data[*;$index].Array;
}

multi method get-col (:@index! --> Array) {

    # check the provided data consistency and other possible issues
    self!sanity-check;

    if so all @!header[@index]:exists and @index.all ~~ Int {
        my @col-data = ([Z] @!data)[@index]>>.Array;
        return @col-data;
    } else {
        fail "Table doesn't have one or more columns that asked. Please check your indexes.";
    }
}

method get-elm (Int:D :$row-index!, Int:D :$col-index!) {

    # check the provided data consistency and other possible issues
    self!sanity-check;

    if @!data[$row-index]:exists and @!header[$col-index]:exists {
        return @!data[$row-index;$col-index];
    } else {
        fail "Either row or column index doesn't exists. Please check your indexes.";
    }

}

method set-elm (Int:D :$row-index!, Int:D :$col-index!, :$value! --> Bool) {

    # check the provided data consistency and other possible issues
    self!sanity-check;

    if @!data[$row-index]:exists and @!header[$col-index]:exists {
        @!data[$row-index;$col-index] = $value;
    } else {
        fail "Either row or column index doesn't exists. Please check your indexes.";
    }

    return True;

}

multi method add-row (:@values! --> Bool) {

    # check the provided data consistency and other possible issues
    self!sanity-check;

    if @values.all ~~ Positional {
        for @values -> @value {
            if @value.elems == self.no-of-cols {
                @!data[self.last-row + 1] = @value;
            } else {
                fail "New row elements must equal to number of columns.";
            }
        }
    } else {
        if @values.elems == self.no-of-cols {
            @!data[self.last-row + 1] = @values;
        } else {
            fail "New row elements must equal to number of columns.";
        }
    }

    return True;
}

multi method add-row (:@values!, Int:D :$index! --> Bool) {

    # check the provided data consistency and other possible issues
    self!sanity-check;

    if @values.elems == self.no-of-cols {
        @!data.splice($index, 0, [@values,]);
    } else {
        fail "New row elements must equal to number of columns.";
    }

    return True;
}

multi method del-row (Int:D :$index! --> Array) {

    # check the provided data consistency and other possible issues
    self!sanity-check;

    if @!data[$index]:exists {
        my @deleted-row = @!data.splice($index,1);
        return @deleted-row;
    } else {
        fail "Row doesn't exist. Please check your index.";
    }
}

multi method del-row (:@index! --> Array) {

    # check the provided data consistency and other possible issues
    self!sanity-check;

    if so @!data[@index]:exists and @index.all ~~ Int {
        my @new-data = [];
        my %data-hash = @!data.pairs;
        my @deleted-rows = %data-hash{@index}:delete;
        if %data-hash.elems > 0 {
            for %data-hash.keys -> $key {
                @new-data.push(%data-hash{$key});
            }
        } else {
            fail "No element left to return.";
        }

        return @deleted-rows;
    } else {
        fail "One or more rows don't exist. Please check your indexes.";
    }
}

multi method add-col (:@values!, :$col-name is copy) {

    # check the provided data consistency and other possible issues
    self!sanity-check;

    if @values.elems == self.no-of-rows() {
        unless $col-name.defined {
            $col-name = "V" ~ self.last-col + 1;
        }
        @!data[*;self.last-col + 1] = @values;
        @!header.push($col-name);
    } else {
        fail "Number of new column values must equal to number of rows.";
    }
    return True;
}

multi method add-col (:@values!, :$col-name is copy, Int:D :$index!) {

    # check the provided data consistency and other possible issues
    self!sanity-check;

    if @values.elems == self.no-of-rows() {
        unless $col-name.defined {
            $col-name = "V" ~ self.last-col + 1;
        }
        @!data[*;self.last-col + 1] = @values;
        @!header.splice($index, 0, $col-name);
    } else {
        fail "Number of new column values must equal to number of rows.";
    }
    return True;
}
=begin pod

=head1 NAME

DataTable - Convert your data files to data table

=head1 SYNOPSIS

  use DataTable;

=head1 AUTHOR

Tushar Dave <tushardave26@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2016 Tushar Dave

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
