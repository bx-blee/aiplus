#!/bin/bash

####+BEGIN: bx:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+minimal"
### Args: :control "enabled|disabled|hide|release|fVar"  :vc "cvs|git|nil" :partof "bystar|nil" :copyleft "halaal+minimal|halaal+brief|nil"
typeset RcsId="$Id: dblock-iim-bash.el,v 1.4 2017-02-08 06:42:32 lsipusr Exp $"
# *CopyLeft*
__copying__="
* Libre-Halaal Software"
#  This is part of ByStar Libre Services. http://www.by-star.net
#  This is a Halaal Poly-Existential. See http://www.freeprotocols.org

####+END:

####+BEGIN: bx:bsip:bash:seed-spec :types  "seedFtoCommon.sh"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedFtoCommon.sh]] |
"
FILE="
*  /This File/ :: /bisos/panels/blee-core/mail/mailings/mtdt/README/ftoProc.sh
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedFtoCommon.sh -l $0 "$@"
    exit $?
fi
####+END:


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [[elisp:(blee:ppmm:org-mode-toggle)][Nat]] [[elisp:(beginning-of-buffer)][Top]] [[elisp:(delete-other-windows)][(1)]] || Cmnd       ::  examplesHookPostExample    [[elisp:(org-cycle)][| ]]
_CommentEnd_

function examplesHookPost {
    cat  << _EOF_
$( examplesSeperatorTopLabel "EXTENSION EXAMPLES" )
$( examplesSeperatorSection "commonProc.sh -- Templates Evolution" )
diff ./commonProc.sh  /bisos/apps/defaults/start/fto/commonProc/anyFtoItem/commonProcLeaf.sh
cp  ./commonProc.sh  /bisos/apps/defaults/start/fto/commonProc/anyFtoItem/commonProcLeaf.sh
cp /bisos/apps/defaults/start/fto/commonProc/anyFtoItem/commonProcLeaf.sh ./commonProc.sh  
$( examplesSeperatorSection "commonPanel.org -- Templates Evolution" )
diff ./commonPanel.org  /bisos/apps/defaults/start/fto/commonProc/anyFtoItem/commonPanel.org
cp ./commonPanel.org /bisos/apps/defaults/start/fto/commonProc/anyFtoItem/commonPanel.org
cp /bisos/apps/defaults/start/fto/commonProc/anyFtoItem/commonPanel.org ./commonPanel.org
_EOF_
 return
}


####+BEGIN: bx:dblock:bash:end-of-file :types ""
_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Common        ::  /[dblock] -- End-Of-File Controls/ [[elisp:(org-cycle)][| ]]
_CommentEnd_
#+STARTUP: showall
#local variables:
#major-mode: sh-mode
#fill-column: 90
# end:
####+END:
