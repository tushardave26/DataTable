use v6;
unit class DataTable;


=begin pod

=head1 NAME

DataTable - Convert your data files to data table object

=head1 SYNOPSIS

  use DataTable;

=head1 DESCRIPTION

DataTable is a module which convert various format of data files such as TEXT (.txt), CSV (.csv), and EXCEL (.xlsx) to data table object. A new data table can also be generated usign this module. It provides CRUD (Create, Retrieve, Update and Delete) methods which can be used on data table object. This methods is being described in their respective sections.

=head1 METHODS

=head2 new

=head2 READ METHODS

=head2 read-from-text

=head2 read-from-csv

=head2 read-from-excel

=head2 read-from-file

=head2 read-from-db

=head2 WRITE METHODS

=head2 write-to-text

=head2 write-to-csv

=head2 write-to-excel

=head2 write-to-db

=head2 DATA ACCESS METHODS

=head2 dim

=head2 col-names

=head2 num-of-row

=head2 num-of-col

=head2 get-elem

=head2 get-row

=head2 get-col 

=head2 get-cols 

=head2 DATA MANIPULATION METHODS

=head2 add-elem

=head2 del-elem

=head2 update-elem

=head2 add-row

=head2 add-rows 

=head2 del-row

=head2 del-rows

=head2 update-row

=head2 update-rows

=head2 swap-row

=head2 add-col

=head2 add-cols

=head2 del-col

=head2 del-cols

=head2 update-col

=head2 update-cols

=head2 swap-col

=head2 rename-col

=head2 TABLE METHODS

=head2 sort-table

=head2 sub-table

=head2 clone-table

=head2 TABLE -> TABLE METHODS

=head2 row-merge

=head2 col-merge

=head2 join-tables

=head2 DATA TRANSFORMATION METHODS

=head2 melt

=head2 cast

=head1 AUTHOR

Tushar Dave <tushardave26@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2016 Tushar Dave

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
