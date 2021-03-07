# Please install the following packages if not already installed

# using Pkg
# Pkg.add("DataFrames")
# Pkg.add("PrettyTables")
# Pkg.add("CSV")
# Pkg.add("Dates")

using DataFrames,CSV,Dates,PrettyTables

# Please provide appropriate input argument for CSV.file()
untidyData = DataFrame(CSV.File("billboard.csv"));
untidyData = sort!(select(untidyData, Not(["date.peaked","genre"])));

moltenData = DataFrame(year = Int[],artist = String[], time = Time[];track =String[],date = Date[], week = Int[],rank = String[]);
for i = 1:317
    for w in 1:76
        if untidyData[i,w+5] !== "NA" && untidyData[i,w+5] !== missing
            d = untidyData[i,"date.entered"] + Dates.Day(7*(w-1))
            push!(moltenData,(2000,untidyData[i,"artist.inverted"],untidyData[i,:time],untidyData[i,:track],d,w,string(untidyData[i,w+5])))
        end
    end
end

show(moltenData, allcols=true,show_row_number = false)

song = select(moltenData,:artist,:track,:time);

insertcols!(song,       
    1,                # insert as column 1
    :id => 1:size(song)[1],   # populate as "id" with 1,2,3,..
    makeunique=true);

show(song, allcols=true,show_row_number = false)

id =[]
n = 0
for w in moltenData[:,:week]
    if w == 1
        n += 1
    end
    push!(id,n)   
end

rank = select(moltenData,:date,:rank);
insertcols!(rank,1,:id => id,makeunique=true);
rank[!,:id] = convert.(Int,rank[!,:id]);

println("\n")
show(rank,show_row_number = false)
