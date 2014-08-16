{

# if name present
if ($3!="")
{
	# if brand present
	if ($4!="")
		print ($1 "," $2 "," $4 ": " $3);
	# if no brand but operator present
	else if ($4=="" && $5!="")
		print ($1 "," $2 "," $5 ": " $3);
	# if just name
	else
		print ($1 "," $2 "," $3);
}

# if no name present
else
{
	# if brand present
	if ($4!="")
		print ($1 "," $2 "," $4);
	# if no brand but operator present
	else if ($4=="" && $5!="") 
		print ($1 "," $2 "," $5);
	# no info at all
	else
		print ($1 "," $2 ",");
}

}