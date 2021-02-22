rule cve_2013_0074
{
meta:
	author = "Kaspersky Lab"
	filetype = "Win32 EXE"
	date = "2015-07-23"
	version = "1.0"

strings:
	$b2={43 61 6E 27 74 20 66 69 6E 64 20 50 61 79 6C 6F 61 64 28 29 20 61 64 64 72 65 73 73}
	$b3={2F 53 69 6C 76 65 72 41 70 70 31 3B 63 6F 6D 70 6F 6E 65 6E 74 2F 41 70 70 2E 78 61 6D 6C}
	$b4="Can't allocate ums after buf[]" ascii wide
	$b5="------------ START ------------"

condition:
	( (2 of ($b*)) )
	//1 of ($b*)
}

