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

## TABLE CREATION

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
3. **delim** - an optional argument which indicates the delimiter of the file.
4. **os** - an optional argument which indicates an operating system on which the data file was created. This argument helps the method to identify the line-break identifier. (**DEFAULT: 0 = UNIX/Linux**). Below is the supported os and their line-break identifiers:

    |Code   |     OS     |   Line-break Indentifier  |
    |:-----:|:----------:|:-------------------------:|
    | 0     | UNIX/Linux |          \n               |
    | 1     | Windows    |          \r\n             |
    | 2     | MAC OS     |          \r               |

5. **skip-lines** - an optional argument to skip the *n* number of lines. (**DEFAULT: 0**)

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

1. **file** - a mandatory argument which accepts a file name or file handle. If either the file path is not resolved or file is not found, the appropriate error will be thrown.
2. **header** - an optional argument which indicates whether the data file has a header or not. (**DEFAULT: 1 = has header**)
    1. 0 = has no header
    2. 1 = has header
3. **delim** - an optional argument which indicates the delimiter of the file.
4. **os** - an optional argument which indicates an operating system on which the data file was created. This argument helps the method to identify the line-break identifier. (**DEFAULT: 0 = UNIX/Linux**). Below is the supported os and their line-break identifiers:

    |Code   |     OS     |   Line-break Indentifier  |
    |:-----:|:----------:|:-------------------------:|
    | 0     | UNIX/Linux |          \n               |
    | 1     | Windows    |          \r\n             |
    | 2     | MAC OS     |          \r               |

5. **skip-lines** - an optional argument to skip the *n* number of lines. (**DEFAULT: 0**)

### read-from-file
```perl
# read from a file
my $dt = DataTable.read-from-file(file => "sample.csv");

#read from a file with optional arguments
my $dt = DataTable.read-from-file(file => "sample.csv", delim => " ", header => 1, os => 0, skip-lines => 10, line-check => 5);
```
This method reads data from a file. The method will try it best to guess delimiter, OS type, and header line. But it is always recommended to provide those information explicitly to speed up the execution time. By default, this method checks the first 5 lines to guess the delimiter, OS type and header line. If the method fails to guess them, the error message will be thorwn. At that time, specify them explicitly. This method accepts below arguments:

1. **file** - a mandatory argument which accepts a file name or file handle. If either the file path is not resolved or file is not found, the appropriate error will be thrown.
2. **header** - an optional argument which indicates whether the data file has a header or not. (**DEFAULT: 1 = has header**)
    1. 0 = has no header
    2. 1 = has header
3. **delim** - an optional argument which indicates the delimiter of the file.
4. **line-check** - an optional argument which indicates how many lines are going to be checked. (**DEFAULT: 5**)
5. **os** - an optional argument which indicates an operating system on which the data file was created. This argument helps the method to identify the line-break identifier. (**DEFAULT: 0 = UNIX/Linux**). Below is the supported os and their line-break identifiers:

    |Code   |     OS     |   Line-break Indentifier  |
    |:-----:|:----------:|:-------------------------:|
    | 0     | UNIX/Linux |          \n               |
    | 1     | Windows    |          \r\n             |
    | 2     | MAC OS     |          \r               |

6. **skip-lines** - an optional argument to skip the *n* number of lines. (**DEFAULT: 0**)

### read-from-db
```perl
# import DBIish module
use DBIish;

# open database connection
my $dbh = DBIish.connect("mysql", :database<test>, :user<root>, :password<sa>, :RaiseError);

# prepare query statement
$sth = $dbh.prepare(q:to/STATEMENT/);
        SELECT name, description, quantity, price, quantity*price AS amount
        FROM nom
STATEMENT

# create a data table object
my $dt = DataTable.read-from-db(dbh => $dbh, sth => $sth);

# print data as comma-seperate values on STDOUTPUT
$dt.write-to-csv;
```

This method helps you to retrieve the data from the database. It returns a table object. Internallt, this method makes database connection, run the query statement, close the database connection, and retrun the table object which includes query result. It accepts below arguments:

1. **$dbh (database handler)** - a mandatory option which includes information about database driver, user name, password etc. It basically helps to open the database conenction.
2. **$sth (statement handler)** - a mandatory option which includes the database query statement

**TODO: Add "read-from-excel" method in future.**

## TABLE PROPERTIES 

Below listed methods will help to access the table properties.

### dim
```perl
# retrieve the dimensions of the table (i.e. rows and cols) 
my $dim = $dt.dim();
```

This method returns the dimension of the data table (i.e. rows and columns). It returns an array of two-elements where first element reperesents the number of rows and second element represents the number of columns that table contains.

### no-of-rows
```perl
# get the number of rows of the table
my $no-of-rows = $dt.no-of-rows();
```

This method returns the number of rows that the table contains.

### no-of-cols
```perl
# get the number of cols of the table
my $no-of-cols =  $dt.no-of-cols();
```

This method returns the number of columns that the table contains.

### last-row
```perl
# get an index of last row of the table
my $last-row-index = $dt.last-row();
```

This method returns an intdex of last row of the table.

### last-col
```perl
# get an index of last col of the table
my $last-col-index = $dt.last-col();
```

This method returns an intdex of last colum of the table.

### col-index
```perl
# get an index of a col of the table
my $col-index = $dt.col-index(col-name => "First Name");
```

This method returns an index of specified column name of the table. It takes following argument:

1. **col-name** - a mandatory argument which contains a column name

### col-name
```perl
# get name of a col of the table
my $col-name = $dt.col-name(col-index => 1);
```

This method returns a column name of specified column index of the table. It takes following argument:

1. **col-index** - a mandatory argument which contains a column index

### header
```perl
# get header of the table as scalar
my $header = $dt.header(as => 0);

# get header of the table as array
my @header = $dt.header(as => 1);
```

This method retrieve the header row/line of the table. It returns the header either as scalar or array. It takes following argument:

1. **as** - an optional argument to indicate in which format the method should return the result. (**DEFAULT: 1**)
    1. 0 = as scalar or space-delimited string
    2. 1 = as array of elements

### type-of-table
```perl
# get the type of the table
my $type = $dt.type();
```

This method retuens a type of the table. Below is the return code and it's interpretation:
1. 0 = row-wise
2. 1 = col-wise

### is-empty
```perl
# get the type of the table
my $type = $dt.is-empty();
```

This method returns a boolean vlaue which indicates whether the table is empty or not. Below is the return code and it's interpretation:
1. 0 = not empty
2. 1 = empty

## TABLE FORMATTING METHODS

### write-as-csv
```perl
# print out the table in CSV format on the Screen/STDOUT
$dt.write-as-csv;

# print out the table in CSV file
$dt.write-as-csv(file => "sample.csv", header => 1);

# print out the table in CSV file with ";" as delimiter 
$dt.write-as-csv(file => "sample.csv", header => 1, delim => ";", OS => 0);
```

This method print out the table content either in a CSV file or on the STDOUT. If no argument is passed to the method, the table content will be printed on the STDOUT. If the `file` argument is provided to the method, the table content will be printed into the file. The method accepts below arguments:

1. **file** - an optional argument which accepts a file name or a file handle. If the file name is not resolved, an appropriate error will be thorwn.
2. **header** - an optional argument which indicates whether the header should get added in the file or not. Below is the possible codes and their interpretation for them. (**DEFAULT : 1**)
    1. 0 = no header
    2. 1 = header please
3. **delim** - an optional argument which determine the demiliter for the file. (**DEFAULT : ","**)
4. **os** - an optional argument which indicates an operating system for which the data file should have been created. This argument helps the method to identify which line-break identifier to use for the file. (**DEFAULT: 0 = UNIX/Linux**). Below is the supported os and their line-break identifiers:

    |Code   |     OS     |   Line-break Indentifier  |
    |:-----:|:----------:|:-------------------------:|
    | 0     | UNIX/Linux |          \n               |
    | 1     | Windows    |          \r\n             |
    | 2     | MAC OS     |          \r               |

### write-as-tsv
```perl
# print out the table in TSV format on the Screen/STDOUT
$dt.write-as-tsv;

# print out the table in TSV file
$dt.write-as-tsv(file => "sample.tsv", header => 1);

# print out the table in TSV file with ";" as delimiter 
$dt.write-as-tsv(file => "sample.tsv", header => 1, delim => " ", OS => 0);
```

This method print out the table content either in a TSV (i.e. .txt) file or on the STDOUT. If no argument is passed to the method, the table content will be printed on the STDOUT. If the `file` argument is provided to the method, the table content will be printed into the file. The method accepts below arguments:

1. **file** - an optional argument which accepts a file name or a file handle. If the file name is not resolved, an appropriate error will be thorwn.
2. **header** - an optional argument which indicates whether the header should get added in the file or not. Below is the possible codes and their interpretation for them. (**DEFAULT : 1**)
    1. 0 = no header
    2. 1 = header please
3. **delim** - an optional argument which determine the demiliter for the file. (**DEFAULT : "\t"**)
4. **os** - an optional argument which indicates an operating system for which the data file should have been created. This argument helps the method to identify which line-break identifier to use for the file. (**DEFAULT: 0 = UNIX/Linux**). Below is the supported os and their line-break identifiers:

    |Code   |     OS     |   Line-break Indentifier  |
    |:-----:|:----------:|:-------------------------:|
    | 0     | UNIX/Linux |          \n               |
    | 1     | Windows    |          \r\n             |
    | 2     | MAC OS     |          \r               |

**TODO: Add "write-to-excel" and "write-to-db" methods in future.**

## TABLE OPERATION

### get-row
```perl
# get the first row
my @first-row = $dt.get-row(index => 0);            #return results as array

# get multiple rows (i.e. from 1st to 4th row)
my @rows-content = $dt.get-row(index => [1..4]);    #return results as array of arrays
```

This method helps to get specific row/s of the table. If a single index is used, the method returns values as an array. If the array of the indexes is used, the method returns values as the array of arrays. It accepts following argument:

1. **index** - an index of the row of interest or an array of indexes

### get-col
```perl
# get the first col
my @first-col = $dt.get-col(index => 0);            #return results as array

# get multiple cols (i.e. from 1st to 4th row)
my @cols-content = $dt.get-col(index => [1..4]);    #return results as array of arrays
```

This method helps to get specific col/s of the table. If a single index is used, the method returns values as an array. If the array of the indexes is used, the method returns values as the array of arrays. It accepts following argument:

1. **index** - an index of the col of interest or an array of indexes

### get-elm
```perl
# get the first cell
my $first-cell = $dt.get-elm(row-index => 0, col-index => 0);
```

This method helps to get a specific cell value of the table. It accepts following arguments:

1. **row-index** - an index of the row of interest
2. **col-index** - an index of the col of interest

### set-elm
```perl
# set/update value of a specific cell
$dt.set-elm(row-index => 0, col-index => 0, value => "James");
```

This method helps to set/update value of a specific cell of the table. It accepts following arguments:

1. **row-index** - an index of the row of interest
2. **col-index** - an index of the col of interest
3. **value** - a value to be set

### add-row

### del-row

### add-col

### del-row

### del-col

### rename-col

### swap-row

### swap-col

### replace-col

### replace-col

### move-row

### move-col 

### arrange

### modify-col

## TABLE --> TABLE OPERATIONS

## row-merge

## col-merge

## join-table

## TABLE TRANSFORMATION

## melt

## cast

AUTHOR
======
Tushar Dave <tushardave26@gmail.com>

COPYRIGHT AND LICENSE
=====================
Copyright 2016 Tushar Dave

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.
