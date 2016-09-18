use v6;

unit class DataTable:ver<0.0.1>:auth<github:tushardave26>;

#custom types
subset Int-or-Str where Int|Str;

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

    # 2. check whether the number of observation meaning number elements in a row is equal to
    # number of columns or not
    unless @!data.[0].elems == @!header.elems {
        fail "The number of observations and number of columns are not equal.!!";
    }

    # call sanity-check method within it definition
    #self!sanity-check();

    #return True;
}

#my @a = [1,2,3], [4,5,6]; say [==] @a

method dim ( --> Str) {
    
    # check the provided data consistency and other possible issues
    self!sanity-check;

    return join(" ", @!data.elems, @!header.elems);

    #$dim.say;

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

    return @!data.elems - 1;
}

method last-col ( --> Int) {
    
    # check the provided data consistency and other possible issues
    self!sanity-check;

    return @!header.elems - 1;
}

method col-index (Cool $col-name --> Int) {
    
    # check the provided data consistency and other possible issues
    self!sanity-check;

    #return @!data.elems - 1;
}

method col-name (Int $col-index --> Cool) {
    
    # check the provided data consistency and other possible issues
    self!sanity-check;

    #return @!data.elems - 1;
}

#self!sanity-check();

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
