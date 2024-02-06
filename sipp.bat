@rem https://stackoverflow.com/questions/3827567/
@set pathname=%~dp0
@set sipp_path=%pathname:~0,-1%
@IF EXIST "%sipp_path%/Manifest.toml" (
  @REM Nothing to do
) ELSE (
  @REM Fix up the installation
  @julia --project="%sipp_path%" -e "using Pkg; Pkg.instantiate()"
)
@julia --project="%sipp_path%" -e "using Sipp; Sipp.sipp()" -- %*
