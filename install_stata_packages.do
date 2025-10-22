* Stata installer to install commonly used Stata packages
quietly {
	*quietly so we don't clutter the display and can draw attention
	*to installation issues
	
	*keep track of package attempts to display to user
	local packageCount=0
	local installedSuccessfully=0
	local failedPackages = ""
	 
	*run the for loop, capture the output, display results, note failures 
	foreach package in "asdoc" "avar" "bacondecomp" "ssaggregate" "bcuse" 	 ///
 "boottest" "coefplot" "countyfips" "csdid" "did_multiplegt" "did2s" "drdid" ///
 "egenmore" "estout" "esttab" "estwrite" "eventstudyinteract" "ftools" 	 	 ///
 "gtools" "ivreg2" "maptile" "spmap" "ppmlhdfe" "psacalc" "ranktest" 		 ///
 "reghdfe" "stackedev" "synth" "statastates" "synth2" "tuples" "vcemway"	 ///
 "winsor2" "wooldid" "wyoung" {
		capture {
			local packageCount=`packageCount'+1  //increment counter
			ssc install `package', replace
		}
		if _rc != 0 {
			*display in red error text if we get an rc, then reset display text
			noisily display as error ///
			   "There was a problem installing `package', error:" _rc as text ""
			local failedPackages="`failedPackages' `package'"
		}	
		else{
			*package installed successfully, note for user
			local installedSuccessfully=`installedSuccessfully'+1  //increment
			noisily display "Installed package: `package'"
		}
	}
	if `packageCount' == `installedSuccessfully' ///
		noisily display "All packages installed successfully!"
 	else {		
		*some didn't install, display those in red error text to the user
		noisily display `packageCount' " packages attempted, " `installedSuccessfully' " packages installed successfuly."
		foreach p in `failedPackages'{ 
			noisily di as error "Package `p' failed to install." as text "" 
			}
	}
}

