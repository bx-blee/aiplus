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

####+BEGIN: bx:bsip:bash:seed-spec :types "seedBleePanelProc.sh"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedBleePanelProc.sh]] |
"
FILE="
*  /This File/ :: /bisos/panels/blee-core/blee-pkgs/mtdt/bleePanelProc.sh
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedBleePanelProc.sh -l $0 "$@"
    exit $?
fi
####+END:



_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [[elisp:(blee:ppmm:org-mode-toggle)][Nat]] [[elisp:(beginning-of-buffer)][Top]] [[elisp:(delete-other-windows)][(1)]] || Cmnd       ::  examplesHookPostExample    [[elisp:(org-cycle)][| ]]
_CommentEnd_

function examplesHookPost {
    cat  << _EOF_
$( examplesSeperatorTopLabel "EXTENSION EXAMPLES" )
_EOF_

    # templatesEvolution
    
    return
}



function templatesEvolution {
    cat  << _EOF_
$( examplesSeperatorSection "ftoProc.sh -- Templates Evolution" )
diff ./ftoProc.sh  /bisos/apps/defaults/update/fto/start/commonProc/anyFtoItem/ftoProcNode.sh
cp ./ftoProc.sh  /bisos/apps/defaults/update/fto/start/commonProc/anyFtoItem/ftoProcNode.sh
cp /bisos/apps/defaults/update/fto/start/commonProc/anyFtoItem/ftoProcNode.sh ./ftoProc.sh  
$( examplesSeperatorSection "commonPanel.org -- Templates Evolution" )
diff ./Panel.org  /bisos/apps/defaults/start/fto/commonProc/anyFtoItem/mainPanel.org
cp ./Panel.org /bisos/apps/defaults/start/fto/commonProc/anyFtoItem/mainPanel.org
cp /bisos/apps/defaults/start/fto/commonProc/anyFtoItem/mainPanel.org ./Panel.org
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
