rule Satan_Mutexes
{
meta:
	description = "Identifies Satan ransomware (and its variants) by mutex."
	author = "@bartblaze"
	date = "2020-01"
	reference = "https://bartblaze.blogspot.com/2020/01/satan-ransomware-rebrands-as-5ss5c.html"
	tlp = "White"
strings:
	$a = {53 41 54 41 4E 41 50 50}
condition:
	1 of them
}
