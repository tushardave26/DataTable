use v6;

unit class DataTable:ver<0.0.1>:auth<github:tushardave26>;

#custom types
subset Int-or-Str where Int|Str;

#attributes
has Array @.data is rw is required;
has Int-or-Str @.header is rw ;
has Int $.type is readonly = 0;

#methods

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
