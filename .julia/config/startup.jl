# Load Revise by default in REPLs. Auto-instal Revise and Debugger.
# https://timholy.github.io/Revise.jl/stable/config/#Using-Revise-by-default-1
atreplinit() do repl
    try
        @eval using Pkg
        haskey(Pkg.installed(), "Revise") || @eval Pkg.add("Revise")
    catch
    end
    try
        @eval using Pkg
        haskey(Pkg.installed(), "Debugger") || @eval Pkg.add("Debugger")
    catch
    end
    try
        @eval using Revise
        @async Revise.wait_steal_repl_backend()
    catch
    end
end
