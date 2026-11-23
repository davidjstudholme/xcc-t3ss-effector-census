#!/usr/bin/perl

use warnings;
use strict;

my $gene_census_file = 'gene_presence_absence_transposed.csv';
my $itol_nodes_file = 'itol-tree-node-ids.txt';

open(CENSUS_FILE, "<$gene_census_file") or die $!;

my $header_line = <CENSUS_FILE>;

my %name2data;

while (<CENSUS_FILE>) {
    chomp;
    my @fields = split(',');
    my $genome_name = shift @fields;
    $genome_name =~ s/dokuwiki-2023-10-03.versus.//;
    $genome_name =~ s/.unicycler.assembly.fasta.tblastn/_unicycler_assembly/;

    $genome_name =~ s/.fasta.tblastn/_contig/;
    

    $name2data{$genome_name} = \@fields;
    warn $genome_name;
}
close CENSUS_FILE;

open(ITOL_FILE, "<$itol_nodes_file") or die $!;

while (<ITOL_FILE>) {
    chomp;
    if( defined $name2data{$_} ) {
	print "$_";
	foreach my $field (@{$name2data{$_}}) {
	    print ",$field";
	}
	print "\n";
    } else {
	warn "Could not find data for $_";
	print "$_\n";
    }
}



close ITOL_FILE;

