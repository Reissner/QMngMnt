$pdf_mode=4;
push @generated_exts, "synctex.gz";


# Implementing glossary with bib2gls and glossaries-extra, with the
#  log file (.glg) analyzed to get dependence on a .bib file.

# !!! ONLY WORKS WITH VERSION 4.54 or higher of latexmk

push @generated_exts, 'glstex', 'glg';

add_cus_dep('aux', 'glstex', 0, 'run_bib2gls');

sub run_bib2gls {
    if ( $silent ) {
        my $ret = system "bib2gls --silent --group '$_[0]'";
    } else {
        my $ret = system "bib2gls --group '$_[0]'";
    };
    
    my ($base, $path) = fileparse( $_[0] );
    if ($path && -e "$base.glstex") {
        rename "$base.glstex", "$path$base.glstex";
    }

    # Analyze log file.
    local *LOG;
    $LOG = "$_[0].glg";
    if (!$ret && -e $LOG) {
        open LOG, "<$LOG";
	while (<LOG>) {
            if (/^Reading (.*\.bib)\s$/) {
		rdb_ensure_file( $rule, $1 );
	    }
	}
	close LOG;
    }
    return $ret;
}
