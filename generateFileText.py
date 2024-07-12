dates = ["Aug15","Sep15","Sep18","Sep22","Sep26","Oct10"]
times = ["24hr","48hr"]
baths = 3
cyprids = 15
indent = "  "

for date in dates:
    for bath in range(1, baths + 1):
        for cyprid in range(1, cyprids + 1):
            for time in times:
                # Do not comma separate for final value
                if cyprid == cyprids and bath == baths and time == times[-1] and date == dates[-1]:
                    print('{}"Bath{}_{}_{}_{}_EditedforR.csv"'.format(indent,bath,cyprid,date,time))
                else:
                    print('{}"Bath{}_{}_{}_{}_EditedforR.csv",'.format(indent,bath,cyprid,date,time))