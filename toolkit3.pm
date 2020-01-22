package toolkit3;
BEGIN{
    our @EXPORT=qw/$c $d/;
    local(*main::c)=\$c;
    local(*main::d)=\$d;
}
use List::Util qw(sum);
use Scalar::Util qw(looks_like_number refaddr);
use Class::Inspector;
use Data::Dumper;
use Exporter 'import';
push(@EXPORT,(@{Class::Inspector->functions(__PACKAGE__)}));#,'printx','map_allp'
#our @EXPORT_OK=qw/$c/;
use strict;
use warnings;
our ($c,$d);

sub mapall_ORIGINAL(&@){
    my ($e,$y,$w,@z)=(shift,[0,[@_],0,$#_]);
top:{
        push(@z,$y),($y=($_ eq 'ARRAY')?[0,[@$w],0,$#$w]:[1,{%$w},0,%$w-1,[keys %$w]]),redo top if(($_=ref($w=(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))) eq 'ARRAY'|| $_ eq 'HASH');
        $_=$w,((($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))=&$e;
        redo top if(($$y[2]++)<$$y[3]);
bottom:{
            return @{$$y[1]} unless(@z);
            (($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1];
            redo top if(${($y=pop(@z))}[2]++<$$y[3]);
            redo bottom;
        }
    }
}
sub mapall_raw(&@){
    my ($e,$y,$w,@z)=(shift,[0,[@_],0,$#_]);
    while(){
        $_=$$w,$$w=&$e,redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,[@$$w],0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]])||$$y[2]++<$$y[3]);
        while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub mapall_rawz(&@){
    my ($e,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
	while(){
        $_=$$w,$$w=&$e,redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]])||$$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub mapall(&@){
    my ($e,$y,$w,@z)=(shift,[0,[@_],0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,[@$$w],0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]])||($_=$$w,$$w=&$e,$$y[2]++)<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub mapall_list(&@){
    my ($e,$y,$w,@z)=(shift,[0,[@_],0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,[@$$w],0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]]));
        $$w=&$e if($_=$$w,$$y[0]==0);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub mapall_hash(&@){
    my ($e,$y,$w,@z)=(shift,[0,[@_],0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,[@$$w],0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]]));
        $$w=&$e if($_=$$w,$$y[0]==1);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub mapallz(&@){
    my ($e,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        redo if($_=$$w,$$w=&$e,$$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub mapall_listz(&@){
    my ($e,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        $$w=&$e if($_=$$w,$$y[0]==0);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub mapall_hashz(&@){
    my ($e,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        $$w=&$e if($_=$$w,$$y[0]==1);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}


sub grepallz(&@){
    my ($e,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        (($$y[0]==0)?(splice(@{$$y[1]},$$y[2]--,1),$$y[3]--):delete $$y[1]{$$y[4][$$y[2]]}) unless($_=$$w,&$e);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub grepallzn(&@){
    my ($e,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        (($$y[0]==0)?(splice(@{$$y[1]},$$y[2]--,1),$$y[3]--):delete $$y[1]{$$y[4][$$y[2]]}) if($_=$$w,&$e);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub grepall_raw(&@){ #new best one
    my ($e,$y,$w,@z,$j)=(shift,[0,[@_],0,$#_]);
	while(){
        (($$y[0]==0)?(splice(@{$$y[1]},$$y[2]--,1),$$y[3]--):delete $$y[1]{$$y[4][$$y[2]]}) unless((($j=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})),($_=$$w,$_=&$e)&&($j eq 'ARRAY'&&(push(@z,$y),$y=[0,[@$$w],0,$#$$w],redo)||$j eq 'HASH'&&(push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]],redo)))||$_);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub grepall_rawz(&@){
    my ($e,$y,$w,@z,$j)=(shift,[0,\@_,0,$#_]);
	while(){
        (($$y[0]==0)?(splice(@{$$y[1]},$$y[2]--,1),$$y[3]--):delete $$y[1]{$$y[4][$$y[2]]}) unless((($j=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})),($_=$$w,$_=&$e)&&($j eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w],redo)||$j eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]],redo)))||$_);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub grepall_raw_test(&@){
    my ($e,$y,$w,@z,$j,$h)=(shift,[0,[@_],0,$#_]);
	while(){
        ((($h eq 'ARRAY')?(push(@z,$y),$y=[0,[@$$w],0,$#$$w]):(push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]])),redo) if((($h=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'||$h eq 'HASH')&&($_=$$w,&$e));
        (($$y[0]==0)?(splice(@{$$y[1]},$$y[2]--,1),$$y[3]--):delete $$y[1]{$$y[4][$$y[2]]}) unless($_=$$w,&$e);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub grepall_raw_old(&@){ #original
    my ($e,$y,$w,@z,$j,$h)=(shift,[0,[@_],0,$#_]);
	while(){
        $j=(($h=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'||$h eq 'HASH');
        unless($_=$$w,&$e)
        {
            (($$y[0]==0)?(splice(@{$$y[1]},$$y[2]--,1),$$y[3]--):delete $$y[1]{$$y[4][$$y[2]]});
        }
        elsif($j){
            ($h eq 'ARRAY')?(push(@z,$y),$y=[0,[@$$w],0,$#$$w]):(push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]]);
            redo;
        }
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub grepall_rawz_old(&@){
    my ($e,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
	while(){
        do{$y=pop(@z) unless($_=$$w,&$e);},redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        (($$y[0]==0)?(splice(@{$$y[1]},$$y[2]--,1),$$y[3]--):delete $$y[1]{$$y[4][$$y[2]]}) unless($_=$$w,&$e);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub grepall(&@){
    my ($e,$y,$w,@z)=(shift,[0,[@_],0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,[@$$w],0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]]));
        (($$y[0]==0)?(splice(@{$$y[1]},$$y[2]--,1),$$y[3]--):delete $$y[1]{$$y[4][$$y[2]]}) unless($_=$$w,&$e);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub grepalln(&@){
    my ($e,$y,$w,@z)=(shift,[0,[@_],0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,[@$$w],0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]]));
        (($$y[0]==0)?(splice(@{$$y[1]},$$y[2]--,1),$$y[3]--):delete $$y[1]{$$y[4][$$y[2]]}) if($_=$$w,&$e);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub grepall_hash(&@){
    my ($e,$y,$w,@z)=(shift,[0,[@_],0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,[@$$w],0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]]));
        delete($$y[1]{$$y[4][$$y[2]]}) if($_=$$w,$$y[0]==1&&!(&$e));
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub grepall_hashn(&@){
    my ($e,$y,$w,@z)=(shift,[0,[@_],0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,[@$$w],0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]]));
        delete($$y[1]{$$y[4][$$y[2]]}) if($_=$$w,$$y[0]==1&&&$e);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub grepall_list(&@){
    my ($e,$y,$w,@z)=(shift,[0,[@_],0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,[@$$w],0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]]));
        splice(@{$$y[1]},$$y[2]--,1),$$y[3]-- if($_=$$w,$$y[0]==0&&!(&$e));
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub grepall_listn(&@){
    my ($e,$y,$w,@z)=(shift,[0,[@_],0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,[@$$w],0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]]));
        splice(@{$$y[1]},$$y[2]--,1),$$y[3]-- if($_=$$w,$$y[0]==0&&&$e);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub grepall_hashz(&@){
    my ($e,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        delete($$y[1]{$$y[4][$$y[2]]}) if($_=$$w,$$y[0]==1&&!(&$e));
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub grepall_hashzn(&@){
    my ($e,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        delete($$y[1]{$$y[4][$$y[2]]}) if($_=$$w,$$y[0]==1&&&$e);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub grepall_listz(&@){
    my ($e,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        splice(@{$$y[1]},$$y[2]--,1),$$y[3]-- if($_=$$w,$$y[0]==0&&!(&$e));
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub grepall_listzn(&@){
    my ($e,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        splice(@{$$y[1]},$$y[2]--,1),$$y[3]-- if($_=$$w,$$y[0]==0&&&$e);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub matches_any(&@){
    my ($e,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        return 1 if($_=$$w,&$e);
        redo if($$y[2]++<$$y[3]);
		while(){
            return 0 unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub matches_anyn(&@){
    my ($e,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        return 1 unless($_=$$w,&$e);
        redo if($$y[2]++<$$y[3]);
		while(){
            return 0 unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub matches_anylist(&@){
    my ($e,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        return 1 if($_=$$w,$$y[0]==0&& &$e);
        redo if($$y[2]++<$$y[3]);
		while(){
            return 0 unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub matches_anylistn(&@){
    my ($e,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        return 1 unless($_=$$w,$$y[0]==0&& &$e);
        redo if($$y[2]++<$$y[3]);
		while(){
            return 0 unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub matches_anyhash(&@){
    my ($e,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        return 1 if($_=$$w,$$y[0]==1&& &$e);
        redo if($$y[2]++<$$y[3]);
		while(){
            return 0 unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub matches_anyhashn(&@){
    my ($e,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        return 1 unless($_=$$w,$$y[0]==1&& &$e);
        redo if($$y[2]++<$$y[3]);
		while(){
            return 0 unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub matchesall(&@){
    my ($e,$y,$w,@z,@m)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        push(@m,$$w) if($_=$$w,&$e);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub matchesalln(&@){
    my ($e,$y,$w,@z,@m)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        push(@m,$$w) unless($_=$$w,&$e);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub sortall(&@){
    my $e=shift;
    my $mx=(shift,sub{
        our($a,$b);
        local(*main::a)=\$a;
        local(*main::b)=\$b;
        &$e
    });
    my ($y,$w,@z)=([0,[sort $mx @_],0,$#_]);
	while(){
        redo if(($_=ref($w=(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))) eq 'ARRAY'&&(push(@z,$y),$y=[0,[sort $mx @$w],0,$#$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,{%$w},0,%$w-1,[keys %$w]]));
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub reduceall(&@){
    my ($e,$y,$sum,$w,@z)=(shift,[0,\@_,0,$#_],shift);
    my $mx=sub{
        our($a,$b);
        $a=$sum;
        $b=$_[0];
        local(*main::a)=\$a;
        local(*main::b)=\$b;
        $sum=&$e;
    };
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        redo if(&$mx($$w),$$y[2]++<$$y[3]);
		while(){
            return $sum unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub reduceall_list(&@){
    my ($e,$y,$sum,$w,@z)=(shift,[0,\@_,0,$#_],shift);
    my $mx=sub{
        our($a,$b);
        $a=$sum;
        $b=$_[0];
        local(*main::a)=\$a;
        local(*main::b)=\$b;
        $sum=&$e;
    };
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        &$mx($$w) if($$y[0]==0);
        redo if($$y[2]++<$$y[3]);
		while(){
            return $sum unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub reduceall_hash(&@){
    my ($e,$y,$sum,$w,@z)=(shift,[0,\@_,0,$#_],shift);
    my $mx=sub{
        our($a,$b);
        $a=$sum;
        $b=$_[0];
        local(*main::a)=\$a;
        local(*main::b)=\$b;
        $sum=&$e;
    };
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        &$mx($$w) if($$y[0]==1);
        redo if($$y[2]++<$$y[3]);
		while(){
            return $sum unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub loop(&@){
    my ($e,$y,$w,@z)=(shift,[0,[@_],0,$#_]);
    my $mx=sub{
        my($a,$b);
        $a=$_[0];
        $b=$_[1];
        $c=$_[2];#declared at the top of the module
        local(*main::a)=\$a;
        local(*main::b)=\$b;
        &$e;
        return $a;
    };
	top:while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,[@$$w],0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]]));
        redo if($_=$$w,$$w=&$mx($$y[2],$$w,$$y[1]),$$y[2]++<$$y[3]);
		while(){
            return unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub loopz(&@){
    my ($e,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
    my $mx=sub{
        my($a,$b);
        $a=$_[0];
        $b=$_[1];
        $c=$_[2];#declared at the top of the module
        local(*main::a)=\$a;
        local(*main::b)=\$b;
        &$e;
        return $a;
    };
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        redo if($_=$$w,$$w=&$mx($$y[2],$$w,$$y[1]),$$y[2]++<$$y[3]);
		while(){
            return unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub loop_raw(&@){
    my ($e,$y,$w,@z)=(shift,[0,[@_],0,$#_]);
    my $mx=sub{
        my($a,$b);
        $a=$_[0];
        $b=$_[1];
        $c=$_[2];#declared at the top of the module
        local(*main::a)=\$a;
        local(*main::b)=\$b;
        &$e;
        return $a;
    };
	while(){
        $_=$$w,$$w=&$mx($z[$#z][2],$$w,$z[$#z][1]),redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,[@$$w],0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]]));
        redo if($_=$$w,$$w=&$mx($$y[2],$$w,$$y[1]),$$y[2]++<$$y[3]);
		while(){
            return unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub loop_rawz(&@){
    my ($e,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
    my $mx=sub{
        my($a,$b);
        $a=$_[0];
        $b=$_[1];
        $c=$_[2];#declared at the top of the module
        local(*main::a)=\$a;
        local(*main::b)=\$b;
        &$e;
        return $a;
    };
	while(){
        $_=$$w,$$w=&$mx($z[$#z][2],$$w,$z[$#z][1]),redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        redo if($_=$$w,$$w=&$mx($$y[2],$$w,$$y[1]),$$y[2]++<$$y[3]);
		while(){
            return unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub maxall(@){
    my ($m,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        $m=$$w if($m<$$w);
        redo if($$y[2]++<$$y[3]);
		while(){
            return $m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub minall(@){
    my ($m,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        $m=$$w if($m>$$w);
        redo if($$y[2]++<$$y[3]);
		while(){
            return $m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub maxall_hash(@){
    my ($m,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        $m=$$w if($$y[0]==1&&$m<$$w);
        redo if($$y[2]++<$$y[3]);
		while(){
            return $m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub minall_hash(@){
    my ($m,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        $m=$$w if($$y[0]==1&&$m>$$w);
        redo if($$y[2]++<$$y[3]);
		while(){
            return $m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub maxall_list(@){
    my ($m,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        $m=$$w if($$y[0]==0&&$m<$$w);
        redo if($$y[2]++<$$y[3]);
		while(){
            return $m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub minall_list(@){
    my ($m,$y,$w,@z)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        $m=$$w if($$y[0]==0&&$m>$$w);
        redo if($$y[2]++<$$y[3]);
		while(){
            return $m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub distinctall(@){
    my ($y,$w,@z,%m)=([0,[@_],0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,[@$$w],0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]]));
        (($$y[0]==0)?(splice(@{$$y[1]},$$y[2]--,1),$$y[3]--):delete $$y[1]{$$y[4][$$y[2]]}),$m{$$w}++ unless(exists($m{$$w}));
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub distinctall_list(@){
    my ($y,$w,@z,%m)=([0,[@_],0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,[@$$w],0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]]));
        splice(@{$$y[1]},$$y[2]--,1),$$y[3]--,$m{$$w}++ unless($$y[0]==0&&exists($m{$$w}));
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub distinctall_hash(@){
    my ($y,$w,@z,%m)=([0,[@_],0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,[@$$w],0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]]));
        delete($$y[1]{$$y[4][$$y[2]]}),$m{$$w}++ unless($$y[0]==1&&exists($m{$$w}));
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub distincteachall(@){ #both hash values and array values
    my ($y,$w,@z,$m);
    my $g=sub{
        my($r,$s)=@_;
        my %j;
        if($s==1)
        {
            my @h=grep{!$j{$$r{$_}}++}keys%$r;
            $j{$_}=$$r{$_} foreach(%j=(),@h);
            return \%j;
        }
        else{
            return [grep{!$j{$_}++}@$r];
        }
    };
    $m=&$g([@_],0),$y=[0,$m,0,$#$m];
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$m=&$g($$w,0),$y=[0,$m,0,$#$m])||$_ eq 'HASH'&&(push(@z,$y),$m=&$g($$w,1),$y=[1,$m,0,%$m-1,[keys %$m]])||$$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub distincteachall_list(@){ #both hash values and array values
    my ($y,$w,@z,$m);
    my $g=sub{
        my($r)=@_;
        my %j;
        return [grep{!$j{$_}++}@$r];
    };
    $m=&$g([@_]),$y=[0,$m,0,$#$m];
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$m=&$g($$w),$y=[0,$m,0,$#$m])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]])||$$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub flatten(@){
    my ($y,$w,@z,@m)=([0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||(push(@m,$$w),$$y[2]++)<$$y[3]);#||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]])
		while(){
            return @m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub flattenall(@){
    my ($y,$w,@z,@m)=([0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]])||(push(@m,$$w),$$y[2]++)<$$y[3]);
		while(){
            return @m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub countdupall(@){
    my ($y,$w,@z,%m)=([0,\@_,0,$#_]);
	while(){
        $m{$$w}++,redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]])||$$y[2]++<$$y[3]);
		while(){
            return sum(map{$_-1}grep{$_>1}values%m) unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub countdupall_list(@){
    my ($y,$w,@z,%m)=([0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&($m{$$w}++,push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        $m{$$w}++ if($$y[0]==0);
        redo if($$y[2]++<$$y[3]);
		while(){
            return sum(map{$_-1}grep{$_>1}values%m) unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub countdupall_hash(@){
    my ($y,$w,@z,%m)=([0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&($m{$$w}++,push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        $m{$$w}++ if($$y[0]==1);
        redo if($$y[2]++<$$y[3]);
		while(){
            return sum(map{$_-1}grep{$_>1}values%m) unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub countall_raw(@){
    my ($y,$w,@z,$m)=([0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]])||($m++,$$y[2]++)<$$y[3]);
		while(){
            return $m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub countall(@){
    my ($y,$w,@z,$m)=([0,\@_,0,$#_]);
	while(){
        $m++,redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]])||$$y[2]++<$$y[3]);
		while(){
            return $m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub countall_list(@){
    my ($y,$w,@z,$m)=([0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&($m++,push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        $m++ if($$y[0]==0);
        redo if($$y[2]++<$$y[3]);
		while(){
            return $m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub countall_list_val(@){
    my ($y,$w,@z,$m)=([0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        $m++ if($$y[0]==0);
        redo if($$y[2]++<$$y[3]);
		while(){
            return $m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub countall_hash(@){
    my ($y,$w,@z,$m)=([0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&($m++,push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        $m++ if($$y[0]==1);
        redo if($$y[2]++<$$y[3]);
		while(){
            return $m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub countall_hash_val(@){
    my ($y,$w,@z,$m)=([0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        $m++ if($$y[0]==1);
        redo if($$y[2]++<$$y[3]);
		while(){
            return $m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub existsall_hash($@){
    my ($e,$y,$w,@z,$m)=(shift,[0,\@_,0,$#_]);
    my $chk=sub{
        my($r)=@_;
        if(ref($r)&&ref($e)||ref($r)&&!ref($e)||!ref($r)&&ref($e))
        {
            if ($r and ref($r) and $e and ref($e) and refaddr($r) == refaddr($e))
            {
                return 1;
            }
            else{
                return 0;
            }
        }
        elsif(looks_like_number($r)&&looks_like_number($e))
        {
            return $r==$e;
        }
        else{
            return $r eq $e;
        }
    };
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        return 1 if($$y[0]==1&&&$chk($$w));
        redo if($$y[2]++<$$y[3]);
		while(){
            return 0 unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub existsall_list($@){
    my ($e,$y,$w,@z,$m)=(shift,[0,\@_,0,$#_]);
    my $chk=sub{
        my($r)=@_;
        if(ref($r)&&ref($e)||ref($r)&&!ref($e)||!ref($r)&&ref($e))
        {
            if ($r and ref($r) and $e and ref($e) and refaddr($r) == refaddr($e))
            {
                return 1;
            }
            else{
                return 0;
            }
        }
        elsif(looks_like_number($r)&&looks_like_number($e))
        {
            return $r==$e;
        }
        else{
            return $r eq $e;
        }
    };
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        return 1 if($$y[0]==0&&&$chk($$w));
        redo if($$y[2]++<$$y[3]);
		while(){
            return 0 unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub existsall($@){
    my ($e,$y,$w,@z,$m)=(shift,[0,\@_,0,$#_]);
    my $chk=sub{
        my($r)=@_;
        if(ref($r)&&ref($e)||ref($r)&&!ref($e)||!ref($r)&&ref($e))
        {
            if ($r and ref($r) and $e and ref($e) and refaddr($r) == refaddr($e))
            {
                return 1;
            }
            else{
                return 0;
            }
        }
        elsif(looks_like_number($r)&&looks_like_number($e))
        {
            return $r==$e;
        }
        else{
            return $r eq $e;
        }
    };
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        return 1 if(&$chk($$w));
        redo if($$y[2]++<$$y[3]);
		while(){
            return 0 unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub gethash($@){
    my ($e,$y,$w,@z,$m)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(do{return $$$w{$e} if(exists($$$w{$e}));},push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]])||$$y[2]++<$$y[3]);
		while(){
            return undef unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub deletehash($@){
    my ($e,$y,$w,@z,$m)=(shift,[0,[@_],0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,[@$$w],0,$#$$w])||$_ eq 'HASH'&&(do{delete($$$w{$e}) if(exists($$$w{$e}));},push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]])||$$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub matchlistall(&@){
    my ($e,$y,$w,@z,@m)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        push(@m,$$w) if($_=$$w,&$e);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub matchlistalln(&@){
    my ($e,$y,$w,@z,@m)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        push(@m,$$w) unless($_=$$w,&$e);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub matchlistall_list(&@){
    my ($e,$y,$w,@z,@m)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        push(@m,$$w) if($_=$$w,$$y[0]==0&&&$e);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub matchlistall_hash(&@){
    my ($e,$y,$w,@z,@m)=(shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        push(@m,$$w) if($_=$$w,$$y[0]==1&&&$e);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub regex_replaceallr($$$@){
    my ($e,$r,$rp,$y,$w,@z,@m,$k)=(shift,shift,shift,[0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        push(@m,$k) if($k=$$w=~s/(?$r)\Q\E$e/qq(qq($rp))/ree);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub regex_replaceall($$$@){
    my ($e,$r,$rp,$y,$w,@z)=(shift,shift,shift,[0,[@_],0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,[@$$w],0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]]));
        $$w=~s/(?$r)\Q\E$e/qq(qq($rp))/ee;
        redo if($$y[2]++<$$y[3]);
		while(){
            return $$y[1] unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}


sub regex_replaceall_list($$$@){
    my ($e,$r,$rp,$y,$w,@z,@m,$l)=(shift,shift,shift,[0,[@_],0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,[@$$w],0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]]));
        $$w=~s/(?$r)\Q\E$e/qq(qq($rp))/ee if($$y[0]==0);
        redo if($$y[2]++<$$y[3]);
		while(){
            return $$y[1] unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub regex_replaceall_hash($$$@){
    my ($e,$r,$rp,$y,$w,@z,@m,$l)=(shift,shift,shift,[0,[@_],0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,[@$$w],0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]]));
        $$w=~s/(?$r)\Q\E$e/qq(qq($rp))/ee if($$y[0]==1);
        redo if($$y[2]++<$$y[3]);
		while(){
            return $$y[1] unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

sub regex_matchall($$@){
    my ($e,$r,$y,$w,@z,@m,$l)=(shift,shift,[0,\@_,0,$#_]);

    my $mx=(!defined($r)||$r!~s/g//)?
    sub{
        my @k;
        if($$w=~/(?$r)\Q\E$e/)
        {
            push(@k,{'str'=>substr($$w,$-[$_],$+[$_]-$-[$_]),'start'=>$-[$_],'end'=>$+[$_]}) foreach(0..$#+);
        }
        push(@m,{'data'=>$$y[1],'src'=>$w,'captures'=>\@k}) if(@k);
    }
    :sub{
        my @k;
        while($$w=~/(?$r)\Q\E$e/g)
        {
            push(@k,{'str'=>substr($$w,$-[$_],$+[$_]-$-[$_]),'start'=>$-[$_],'end'=>$+[$_]}) foreach(0..$#+);
        }
        push(@m,{'data'=>$$y[1],'src'=>$w,'captures'=>\@k}) if(@k);
    };
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        redo if(&$mx,$$y[2]++<$$y[3]);
		while(){
            return @m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub regex_matchall_list($$@){
    my ($e,$r,$y,$w,@z,@m,$l)=(shift,shift,[0,\@_,0,$#_]);

    my $mx=(!defined($r)||$r!~s/g//)?
    sub{
        my @k;
        if($$w=~/(?$r)\Q\E$e/)
        {
            push(@k,{'str'=>substr($$w,$-[$_],$+[$_]-$-[$_]),'start'=>$-[$_],'end'=>$+[$_]}) foreach(0..$#+);
        }
        push(@m,{'data'=>$$y[1],'src'=>$w,'captures'=>\@k}) if(@k);
    }
    :sub{
        my @k;
        while($$w=~/(?$r)\Q\E$e/g)
        {
            push(@k,{'str'=>substr($$w,$-[$_],$+[$_]-$-[$_]),'start'=>$-[$_],'end'=>$+[$_]}) foreach(0..$#+);
        }
        push(@m,{'data'=>$$y[1],'src'=>$w,'captures'=>\@k}) if(@k);
    };
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        &$mx if($$y[0]==0);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub regex_matchall_hash($$@){
    my ($e,$r,$y,$w,@z,@m,$l)=(shift,shift,[0,\@_,0,$#_]);

    my $mx=(!defined($r)||$r!~s/g//)?
    sub{
        my @k;
        if($$w=~/(?$r)\Q\E$e/)
        {
            push(@k,{'str'=>substr($$w,$-[$_],$+[$_]-$-[$_]),'start'=>$-[$_],'end'=>$+[$_]}) foreach(0..$#+);
        }
        push(@m,{'data'=>$$y[1],'src'=>$w,'captures'=>\@k}) if(@k);
    }
    :sub{
        my @k;
        while($$w=~/(?$r)\Q\E$e/g)
        {
            push(@k,{'str'=>substr($$w,$-[$_],$+[$_]-$-[$_]),'start'=>$-[$_],'end'=>$+[$_]}) foreach(0..$#+);
        }
        push(@m,{'data'=>$$y[1],'src'=>$w,'captures'=>\@k}) if(@k);
    };
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        &$mx if($$y[0]==1);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}


sub splitall($$@){
    my ($e,$r,$y,$w,@z)=(shift,shift,[0,[@_],0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,[@$$w],0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]]));
        $$w=[split(/(?$r)\Q\E$e/,$$w)] if($$w=~/(?$r)\Q\E$e/);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub splitall_list($$@){
    my ($e,$r,$y,$w,@z)=(shift,shift,[0,[@_],0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,[@$$w],0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]]));
        $$w=[split(/(?$r)\Q\E$e/,$$w)] if($$y[0]==0&&$$w=~/(?$r)\Q\E$e/);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub splitall_hash($$@){
    my ($e,$r,$y,$w,@z)=(shift,shift,[0,[@_],0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,[@$$w],0,$#$$w])||$_ eq 'HASH'&&(push(@z,$y),$y=[1,{%$$w},0,%$$w-1,[keys %$$w]]));
        $$w=[split(/(?$r)\Q\E$e/,$$w)] if($$y[0]==1&&$$w=~/(?$r)\Q\E$e/);
        redo if($$y[2]++<$$y[3]);
		while(){
            return @{$$y[1]} unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}
sub combineall_hash(@){
    my ($y,$w,@z,%m)=([0,\@_,0,$#_]);
	while(){
        redo if(($_=ref(${($w=\(($$y[0]==0)?$$y[1][$$y[2]]:$$y[1]{$$y[4][$$y[2]]}))})) eq 'ARRAY'&&(push(@z,$y),$y=[0,\@$$w,0,$#$$w])||$_ eq 'HASH'&&(@m{keys%$$w}=values%$$w,push(@z,$y),$y=[1,\%$$w,0,%$$w-1,[keys %$$w]]));
        redo if($$y[2]++<$$y[3]);
		while(){
            return \%m unless(@z&&((($z[$#z][0]==0)?$z[$#z][1][$z[$#z][2]]:$z[$#z][1]{$z[$#z][4][$z[$#z][2]]})=$$y[1]));
            last if(${($y=pop(@z))}[2]++<$$y[3]);
        }
    }
}

1;