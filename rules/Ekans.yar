rule Ekans
{
meta:
	description = "Identifies Ekans aka Snake ransomware unpacked or in memory."
	author = "@bartblaze"
	date = "2020-03"
	tlp = "White"

strings:
	$ = {61 6C 72 65 61 64 79 20 65 6E 63 72 79 70 74 65 64 21}
	$ = "cant kill process %v : %v" ascii wide
	$ = "could not access service: %v" ascii wide
	$ = "could not retrieve service status: %v" ascii wide
	$ = "could not send control=%d: %v" ascii wide
	$ = "error encrypting %v : %v" ascii wide
	$ = "faild to get process list" ascii wide
	$ = "priority files: %v" ascii wide
	$ = "priorityFiles: %v" ascii wide
	$ = {70 75 62 3A 20 25 76}
	$ = {72 6F 6F 74 3A 20 25 76}
	$ = "There can be only one" ascii wide
	$ = "timeout waiting for service to go to state=%d" ascii wide
	$ = "Toatal files: %v" ascii wide
	$ = "total lengt: %v" ascii wide
	$ = "worker %s started job %s" ascii wide

condition:
	3 of them
}
