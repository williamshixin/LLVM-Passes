; ModuleID = 'test2.bc'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.11.0"

@.str = private unnamed_addr constant [31 x i8] c"This is a test for project 1.\0A\00", align 1

; Function Attrs: nounwind ssp uwtable
define i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %f = alloca float, align 4
  store i32 0, i32* %retval
  call void @llvm.dbg.declare(metadata !{float* %f}, metadata !22), !dbg !24
  store float 5.000000e-01, float* %f, align 4, !dbg !25
  %0 = load float* %f, align 4, !dbg !26
  call void bitcast (void (i32, i32)* @func1 to void (float)*)(float %0), !dbg !26
  call void bitcast (void (i32)* @func2 to void (float)*)(float 5.000000e-01), !dbg !27
  %call = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([31 x i8]* @.str, i32 0, i32 0)), !dbg !28
  ret i32 0, !dbg !29
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind ssp uwtable
define void @func1(i32 %n1, i32 %n2) #0 {
entry:
  %n1.addr = alloca i32, align 4
  %n2.addr = alloca i32, align 4
  store i32 %n1, i32* %n1.addr, align 4
  call void @llvm.dbg.declare(metadata !{i32* %n1.addr}, metadata !30), !dbg !31
  store i32 %n2, i32* %n2.addr, align 4
  call void @llvm.dbg.declare(metadata !{i32* %n2.addr}, metadata !32), !dbg !33
  ret void, !dbg !34
}

; Function Attrs: nounwind ssp uwtable
define void @func2(i32 %n1) #0 {
entry:
  %n1.addr = alloca i32, align 4
  store i32 %n1, i32* %n1.addr, align 4
  call void @llvm.dbg.declare(metadata !{i32* %n1.addr}, metadata !35), !dbg !36
  ret void, !dbg !37
}

attributes #0 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0, !9}
!llvm.module.flags = !{!19, !20}
!llvm.ident = !{!21, !21}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.0 (tags/RELEASE_350/final)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/Users/xinshi/Desktop/llvm/llvm/ProjectI/task3/tests/test2.1.c] [DW_LANG_C99]
!1 = metadata !{metadata !"test2.1.c", metadata !"/Users/xinshi/Desktop/llvm/llvm/ProjectI/task3/tests"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"main", metadata !"main", metadata !"", i32 6, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 0, i1 false, i32 ()* @main, null, null, metadata !2, i32 6} ; [ DW_TAG_subprogram ] [line 6] [def] [main]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/Users/xinshi/Desktop/llvm/llvm/ProjectI/task3/tests/test2.1.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 786449, metadata !10, i32 12, metadata !"clang version 3.5.0 (tags/RELEASE_350/final)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !11, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/Users/xinshi/Desktop/llvm/llvm/ProjectI/task3/tests/test2.2.c] [DW_LANG_C99]
!10 = metadata !{metadata !"test2.2.c", metadata !"/Users/xinshi/Desktop/llvm/llvm/ProjectI/task3/tests"}
!11 = metadata !{metadata !12, metadata !16}
!12 = metadata !{i32 786478, metadata !10, metadata !13, metadata !"func1", metadata !"func1", metadata !"", i32 1, metadata !14, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32)* @func1, null, null, metadata !2, i32 1} ; [ DW_TAG_subprogram ] [line 1] [def] [func1]
!13 = metadata !{i32 786473, metadata !10}        ; [ DW_TAG_file_type ] [/Users/xinshi/Desktop/llvm/llvm/ProjectI/task3/tests/test2.2.c]
!14 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !15, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!15 = metadata !{null, metadata !8, metadata !8}
!16 = metadata !{i32 786478, metadata !10, metadata !13, metadata !"func2", metadata !"func2", metadata !"", i32 5, metadata !17, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @func2, null, null, metadata !2, i32 5} ; [ DW_TAG_subprogram ] [line 5] [def] [func2]
!17 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !18, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!18 = metadata !{null, metadata !8}
!19 = metadata !{i32 2, metadata !"Dwarf Version", i32 2}
!20 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!21 = metadata !{metadata !"clang version 3.5.0 (tags/RELEASE_350/final)"}
!22 = metadata !{i32 786688, metadata !4, metadata !"f", metadata !5, i32 7, metadata !23, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 7]
!23 = metadata !{i32 786468, null, null, metadata !"float", i32 0, i64 32, i64 32, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ] [float] [line 0, size 32, align 32, offset 0, enc DW_ATE_float]
!24 = metadata !{i32 7, i32 8, metadata !4, null}
!25 = metadata !{i32 7, i32 2, metadata !4, null}
!26 = metadata !{i32 8, i32 2, metadata !4, null} ; [ DW_TAG_imported_declaration ]
!27 = metadata !{i32 9, i32 2, metadata !4, null}
!28 = metadata !{i32 10, i32 2, metadata !4, null}
!29 = metadata !{i32 11, i32 2, metadata !4, null}
!30 = metadata !{i32 786689, metadata !12, metadata !"n1", metadata !13, i32 16777217, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n1] [line 1]
!31 = metadata !{i32 1, i32 16, metadata !12, null}
!32 = metadata !{i32 786689, metadata !12, metadata !"n2", metadata !13, i32 33554433, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n2] [line 1]
!33 = metadata !{i32 1, i32 24, metadata !12, null}
!34 = metadata !{i32 3, i32 1, metadata !12, null}
!35 = metadata !{i32 786689, metadata !16, metadata !"n1", metadata !13, i32 16777221, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n1] [line 5]
!36 = metadata !{i32 5, i32 16, metadata !16, null}
!37 = metadata !{i32 7, i32 1, metadata !16, null}
