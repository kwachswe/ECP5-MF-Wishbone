#!/usr/local/bin/wish

puts "CreateNGD (generated)"
set cpu  $tcl_platform(machine)

switch $cpu {
 intel -
 i*86* {
     set cpu ix86
 }
 x86_64 {
     if {$tcl_platform(wordSize) == 4} {
     set cpu ix86
     }
 }
}

switch $tcl_platform(platform) {
    windows {
        set Para(os_platform) windows
   if {$cpu == "amd64"} {
     # Do not check wordSize, win32-x64 is an IL32P64 platform.
     set cpu x86_64
     }
    }
    unix {
        if {$tcl_platform(os) == "Linux"}  {
            set Para(os_platform) linux
        } else  {
            set Para(os_platform) unix
        }
    }
}

if {$cpu == "x86_64"} {
 set NTPATH nt64
 set LINPATH lin64
} else {
 set NTPATH nt
 set LINPATH lin
}

if {$Para(os_platform) == "linux" } {
    set os $LINPATH
} else {
    set os $NTPATH
}
set Para(ProjectPath) [file dirname [info script]]
set Para(install_dir) $env(TOOLRTF)
set Para(design) "verilog"
set Para(Bin) "[file join $Para(install_dir) bin $os]"
set Para(FPGAPath) "[file join $Para(install_dir) ispfpga bin $os]"
lappend auto_path "$Para(install_dir)/tcltk/lib/ipwidgets/ispipbuilder/../runproc"
package require runcmd

set Para(ModuleName) "pcie_mfx1_top"
set Para(Family) "sa5p00m"
set Para(PartType) "LFE5UM-45F"
set Para(PartName) "LFE5UM-45F-8BG381C"
set Para(SpeedGrade) "8"
set retdir [pwd]
cd $Para(ProjectPath)
set synpwrap_cmd "$Para(Bin)/synpwrap"
if {[file exist syn_results]} {
} else {
file mkdir syn_results
}

   if [catch {open $Para(ModuleName).prj w} prjFile] {
      puts stderr "IP_Generate::CreateNGD() - Cannot create project file $Para(ModuleName).prj: $PRJFile"
      return -1
   } else {
      puts $prjFile "   # device options"
      puts $prjFile "set_option -technology $Para(tech)"
      puts $prjFile "set_option -speed_grade $Para(SpeedGrade)"
      puts $prjFile "set_option -resource_sharing false"
      puts $prjFile "   #hdl options"
      puts $prjFile "set_option -vlog_std v2001"
      puts $prjFile "set_option -vhdl2008 1"
      puts $prjFile "   # map options"
      puts $prjFile "set_option -frequency 150.000"
      puts $prjFile "set_option -fanout_limit 100"
      puts $prjFile "set_option -disable_io_insertion true"
      puts $prjFile "set_option -retiming false"
      puts $prjFile "set_option -pipe false"
      puts $prjFile "set_option -force_gsr false"
      puts $prjFile "set_option -optimization_goal timing"
      puts $prjFile "   # simulation options"
      puts $prjFile "set_option -write_verilog false"
      puts $prjFile "set_option -write_vhdl true"
      puts $prjFile "   # automatic place and route (vendor) options options"
      puts $prjFile "set_option -write_apr_constraint 0"
      puts $prjFile "   # synplifyPro options"
      puts $prjFile "set_option -fixgatedclocks 0"
      puts $prjFile "set_option -fixgeneratedclocks 0"
      puts $prjFile "   # add files"
      puts $prjFile "add_file -vhdl -lib work \"$Para(install_dir)/cae_library/synthesis/vhdl/$Para(tech).vhd\""
      puts $prjFile "add_file -verilog -lib work \"$Para(install_dir)/cae_library/synthesis/verilog/pmi_def.v\""
      puts $prjFile "add_file -verilog -lib work \"$Para(ProjectPath)/src/vlog/pcie_mfdev_v6.v\""
      puts $prjFile "add_file -vhdl -lib work \"$Para(ProjectPath)/$Para(ModuleName).vhd\""
      puts $prjFile "   # top module name"
      puts $prjFile "set_option -top_module $Para(ModuleName)"
      puts $prjFile "   # set result format/file last"
      puts $prjFile "project -result_file \"syn_results/$Para(ModuleName).edi\""
      puts $prjFile "   # error message log file"
      puts $prjFile "project -log_file \"$Para(ModuleName).srl\""
      puts $prjFile "   # run Synplify"
      puts $prjFile "project -run"
      close $prjFile
   }

   if [runCmd "\"$synpwrap_cmd\" -prj $Para(ModuleName).prj"] {
            return
   } else {
            vwait done
            if [checkResult $done] {
               return
            }
   }

   if [runCmd "\"$Para(FPGAPath)/edif2ngd\" -l $Para(tech) -d $Para(PartType) -nopropwarn \"syn_results/$Para(ModuleName).edi\" \"$Para(ModuleName).ngo\""] {
            return
   } else {
            vwait done
            if [checkResult $done] {
               return
            }
   }

   if [runCmd "\"$Para(FPGAPath)/ngdbuild\" -dt -a $Para(tech) -d $Para(PartType) -p \"../pcie_x1_top\" -p \"../pcie_mfx1_top\" -p \"$Para(install_dir)/ispfpga/$Para(Family)/data\" -p \"syn_results\" \"$Para(ModuleName).ngo\" \"$Para(ModuleName).ngd\""] {
            return
   } else {
            vwait done
            if [checkResult $done] {
               return
            }
   }

