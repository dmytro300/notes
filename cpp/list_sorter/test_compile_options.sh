#!/bin/bash

siteoptions=(
"-fauto-inc-dec"
"-fbranch-count-reg"
"-fcombine-stack-adjustments"
"-fcompare-elim"
"-fcprop-registers"
"-fdce"
"-fdefer-pop"
"-fdelayed-branch"
"-fdse"
"-fforward-propagate"
"-fguess-branch-probability"
"-fif-conversion"
"-fif-conversion2"
"-finline-functions-called-once"
"-fipa-modref"
"-fipa-profile"
"-fipa-pure-const"
"-fipa-reference"
"-fipa-reference-addressable"
"-fmerge-constants"
"-fmove-loop-invariants"
"-fmove-loop-stores"
"-fomit-frame-pointer"
"-freorder-blocks"
"-fshrink-wrap"
"-fshrink-wrap-separate"
"-fsplit-wide-types"
"-fssa-backprop"
"-fssa-phiopt"
"-ftree-bit-ccp"
"-ftree-ccp"
"-ftree-ch"
"-ftree-coalesce-vars"
"-ftree-copy-prop"
"-ftree-dce"
"-ftree-dominator-opts"
"-ftree-dse"
"-ftree-forwprop"
"-ftree-fre"
"-ftree-phiprop"
"-ftree-pta"
"-ftree-scev-cprop"
"-ftree-sink"
"-ftree-slsr"
"-ftree-sra"
"-ftree-ter"
"-funit-at-a-time"
)

myoptions=(
"-fbranch-count-reg"
"-fcombine-stack-adjustments "
"-fcompare-elim"
"-fcprop-registers"
"-fdefer-pop"
"-fdse"
"-fforward-propagate"
"-fguess-branch-probability  "
"-fif-conversion"
"-fif-conversion2"
"-finline"
"-finline-functions-called-once "
"-fipa-profile"
"-fipa-pure-const"
"-fipa-reference"
"-fipa-reference-addressable "
"-fmove-loop-invariants"
"-fomit-frame-pointer"
"-freorder-blocks"
"-fshrink-wrap"
"-fsplit-wide-types"
"-fssa-phiopt"
"-ftoplevel-reorder"
"-ftree-bit-ccp"
"-ftree-builtin-call-dce"
"-ftree-ccp"
"-ftree-ch"
"-ftree-coalesce-vars"
"-ftree-copy-prop"
"-ftree-dce"
"-ftree-dominator-opts"
"-ftree-dse"
"-ftree-fre"
"-ftree-pta"
"-ftree-sink"
"-ftree-slsr"
"-ftree-sra"
"-ftree-ter"
)


nooptions=(
"-fno-branch-count-reg"
"-fno-combine-stack-adjustments "
"-fno-compare-elim"
"-fno-cprop-registers"
"-fno-defer-pop"
"-fno-dse"
"-fno-forward-propagate"
"-fno-guess-branch-probability  "
"-fno-if-conversion"
"-fno-if-conversion2"
"-fno-inline"
"-fno-inline-functions-called-once "
"-fno-ipa-profile"
"-fno-ipa-pure-const"
"-fno-ipa-reference"
"-fno-ipa-reference-addressable "
"-fno-move-loop-invariants"
"-fno-omit-frame-pointer"
"-fno-reorder-blocks"
"-fno-shrink-wrap"
"-fno-split-wide-types"
"-fno-ssa-phiopt"
"-fno-toplevel-reorder"
"-fno-tree-bit-ccp"
"-fno-tree-builtin-call-dce"
"-fno-tree-ccp"
"-fno-tree-ch"
"-fno-tree-coalesce-vars"
"-fno-tree-copy-prop"
"-fno-tree-dce"
"-fno-tree-dominator-opts"
"-fno-tree-dse"
"-fno-tree-fre"
"-fno-tree-pta"
"-fno-tree-sink"
"-fno-tree-slsr"
"-fno-tree-sra"
"-fno-tree-ter"
)

for i in ${siteoptions[@]}
#for i in ${myoptions[@]}
#for i in ${nooptions[@]}
do
    echo $i
    g++ --std=c++11 -O0 $i debug.cpp -o listsorter
    ./listsorter
done 
