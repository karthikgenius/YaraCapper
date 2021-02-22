rule CyberGate
{

	meta:
		author = " Kevin Breen <kevin@techanarchy.net>"
		date = "2014/04"
		ref = "http://malwareconfig.com/stats/CyberGate"
		maltype = "Remote Access Trojan"

	strings:
		$string1 = {23 23 23 23 40 23 23 23 23 E8 EE E9 F9 23 23 23 23 40 23 23 23 23}
		$string2 = {23 23 23 23 40 23 23 23 23 FA FD F0 EF F9 23 23 23 23 40 23 23 23 23}
		$string3 = {45 64 69 74 53 76 72}
		$string4 = {54 4C 6F 61 64 65 72 0D 0A}
		$string5 = {53 74 72 6F 6B 73}
		$string6 = {23 23 23 23 40 23 23 23 23}
		$res1 = {58 58 2D 58 58 2D 58 58 2D 58 58}
		$res2 = {0D 0A 43 47 2D 43 47 2D 43 47 2D 43 47}

	condition:
		all of ($string*) and any of ($res*)
}