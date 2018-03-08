using DataFrames
using LightXML
using Requests
#Pkg.add("ODBC")


function download_pkgs(args ...)
    for a in args
        try
            Pkg.add(a)
            println("package ", a, " is installing ...")
        catch
            println("error installing ", a, " thrown")
        end
    end
end






function ∑(x)
    return sum(x)
end
@time ∑(1:100000000)

@code_llvm  ∑(1:1000)



#=
File Search fucntion:
    attributes:
        f_path: path to wheer the file resides
        file_name: Name of the file being searched

=#
using DataFrames
using PyCall
ENV["PYTHON"] = "C:\\python.exe"
Pkg.build("PyCall")
@pyimport pyodbc
@pyimport sqlalchemy


# python database connection string
con = pyodbc.connect("driver={SQL Server};server=XXX;DATABASE=XXX;UID=XXX;PWD=XXX")
cursor = con[:cursor]()
cursor[:execute]("SELECT TOP 100* FROM
                  [XXXX].[dbo].[XXXX]")
for row in cursor
    println(row)
end


cursor[:close]()

function file_search(f_path, file_name)
    try
        isa(f_path, String)
    catch f_path
        println("exception was raised, converting ", f_path, " to string")
        f_path = string(f_path)
    end
    try
        isa(file_name, String)
    catch file_name
        println("exception was raised, converting ", file_name, " to string")
    end
    if pwd() != f_path
        println("current directory changing ...")
        cd(f_path)
    end
    open(file_name, "r") do file
        for line in eachline(file)
            println(line)
        end
    end
end
