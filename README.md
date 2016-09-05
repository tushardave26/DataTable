NAME
====
DataTable - Generate data tables from either data files of various format or scratch

SYNOPSIS
========
```perl
    use DataTable;
```
                                                                                                       
INTRODUCTION
============
DataTable is a module which convert various format of data files such as TEXT (.txt), CSV (.csv), EXCEL (.xlsx), and database query results to a data table. It can also create data table from ground up. It provides CRUD (Create, Retrieve, Update and Delete) methods which can be used on data table. These methods are described in their respective sections. This module is an attempt to mimic all the functionalities of Perl5 module [Data::Table](https://metacpan.org/pod/Data::Table).

**WARNING:** The module is under development at this moment and require thorough testing. There may be a chance of adding or removing one or more features from or to the module.
                                                                                                       
METHODS
=======

## TABLE CREATION METHODS

### new
```perl
#initialize an empty data table
my $dt = DataTable.new(data => [], header => []);

# initialize data table with data
my $dt = DataTable.new(data => [["Tushar", "Dave", 29], ["John", "Adams", 22]],
                       header => ["First Name", "Last Name", "Age"]],
                       type => 0); 
```
This method creates a new data table from scratch. It returns a data table object. It takes three arguments as described below:

1. **data** - a mandatory argument which contains data values. Data values must have been provided as an Array of Arrays.
2. **header** - an optional argument which contains a header values. Header values must have been provided as an Array. (**DEFAULT: "col1, "col2", "col3"**)
3. **type** - an optional argument which contains desired data table type. (**DEFAULT: 0 = row-wise**). Two table types are supported:
    1. 0 (row-wise) = data values are populated row-wise
    2. 1 (column-wise) = data values are populated column-wise

### sub-table
```perl
# create a sub-table from exisitng table for specific rows and columns
my $dt1 = $dt.sub-table(rows => [1,2,5..10], cols => ["First Name", "Last Name"]);

# create a sub-table from existing table using regex
my $dt1 = $dt.sub-table(cols => ["First Name", "Last Name"], patterns => ["/^Tu.$/", "/*ve$/")];

# create a sub-table from existing table using conditional operators
my $dt1 = $dt.sub-table(cols => ["Age"], patterns => [">20"]);

# create a sub-table from existing table using columns only
my $dt1 = $dt.sub-table(cols => ["First Name", "Last Name"]);

# create a sub-table from existing table using columns only using range operator
my $dt1 = $dt.sub-table(cols => ["First Name".."Age"]);

# create a sub-table from existing table using rows only
my $dt1 = $dt.sub-table(rows => [1..6]);

# create a sub-table from existing table using columns only
my $dt1 = $dt.sub-table(cols => ["First Name", "Last Name"]);
```

This method can be used to create a sub-table from an original data table. It is very versatile method and provides several options to select one to many rows and columns from the data table. It also accepts regular expressions which can be passed using `pattern` argument. The `pattern` comes in handy when you are not sure about the column names. Please be aware `pattern` can only be used with `cols`. If `pattern` is used with `rows` than it will be ignored. The length of `pattern` must be equal to length of `cols`. This method accepts following arguments and either `rows` or `cols` must have been provided:

1. **rows** - an array of row indexes. Range operator is allowed.
2. **cols** - an array of column names. For the consecutive columns a range operator is allowed.
3. **patterns** - an array of regular expression or combination of logical operators with the values (e.g. ">20"). If more than one patterns is provided logical "AND" operator will be used. To use logical "OR" operator, specify it with `operator` argument.
4. **operator** - a logical operator that is used when there are multiple `patterns` is being specified. (**DEFAULT: AND**)

### clone-table
```perl
# clone the table from an original table
my $dt1 = $dt.clone();
```

This method clone the original data table and return a new table object.

### read-from-text
```perl
# read from tab-delimited file
my $dt = DataTable.read-from-text(file => "sample.txt");

#read from space-delimited file
my $dt = DataTable.read-from-text(file => "sample.txt", delim => " ");

#with other arguments
my $dt = DataTable.read-from-text(file => "sample.txt", header => 1, os => 0, skip-lines => 10);
```
By default, this method reads data from a tab-separated text file. If your file is text file but having other delimiter than tab, please specify it with `delim` argument. This method accepts below arguments:

1. **file** - a mandatory argument which accepts a file name or file handle. If the file path is not resolved, the error will be thrown. If either the file path is not resolved or file is not found, the appropriate error will be thrown.
2. **header** - an optional argument which indicates whether the data file has a header or not. (**DEFAULT: 1 = has header**)
    1. 0 = has no header
    2. 1 = has header
3. **os** - an optional argument which indicates an operating system on which the data file was created. This argument helps the method to identify the line-break identifier. (**DEFAULT: 0 = UNIX/Linux**). Below is the supported os and their line-break identifiers:

    |Code   |     OS     |   Line-break Indentifier  |
    |:-----:|:----------:|:-------------------------:|
    | 0     | UNIX/Linux |          \n               |
    | 1     | Windows    |          \r\n             |
    | 2     | MAC OS     |          \r               |

4. **skip-lines** - an optional argument to skip the *n* number of lines. (**DEFAULT: 0**)

### read-from-csv
```perl
# read from tab-delimited file
my $dt = DataTable.read-from-csv(file => "sample.csv");

#read from space-delimited file
my $dt = DataTable.read-from-csv(file => "sample.csv", delim => " ");

#with other arguments
my $dt = DataTable.read-from-csv(file => "sample.csv", header => 1, os => 0, skip-lines => 10);
```
This method reads data from a comma-separated text file. If your file is comma-separated file but having other delimiter than comma, please specify it with `delim` argument. This method accepts below arguments:

1. **file** - a mandatory argument which accepts a file name or file handle. If the file path is not resolved, the error will be thrown. If either the file path is not resolved or file is not found, the appropriate error will be thrown.
2. **header** - an optional argument which indicates whether the data file has a header or not. (**DEFAULT: 1 = has header**)
    1. 0 = has no header
    2. 1 = has header
3. **os** - an optional argument which indicates an operating system on which the data file was created. This argument helps the method to identify the line-break identifier. (**DEFAULT: 0 = UNIX/Linux**). Below is the supported os and their line-break identifiers:

    |Code   |     OS     |   Line-break Indentifier  |
    |:-----:|:----------:|:-------------------------:|
    | 0     | UNIX/Linux |          \n               |
    | 1     | Windows    |          \r\n             |
    | 2     | MAC OS     |          \r               |

4. **skip-lines** - an optional argument to skip the *n* number of lines. (**DEFAULT: 0**)

AUTHOR
======
Tushar Dave <tushardave26@gmail.com>

COPYRIGHT AND LICENSE
=====================
Copyright 2016 Tushar Dave

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.
