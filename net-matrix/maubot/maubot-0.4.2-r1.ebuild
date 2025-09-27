# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Placeholder. Please migrate to net-im/maubot::guru."
HOMEPAGE="https://github.com/maubot/maubot"
SRC_URI=""

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

pkg_pretend () {
	eerror "I'm sorry, you cannot install this package. Please, use net-im/maubot from ::guru."
	eerror ""
	eerror "If migrating from a previous version, think what you want to preserve from the"
	eerror "current install first. My best guess is that you want to back up your"
	eerror "/etc/maubot directory and the plugins directory (was it /var/lib/maubot/plugins?)"
	eerror "If you were using the sqlite database, backup that too."
	eerror "Then depclean net-matrix/maubot and install net-im/maubot::guru."
	eerror "Merge your old config into the new one carefully. The plugins directory could"
	eerror "*probably* be copied over (but again, think about what you are doing)"
	eerror "Reusing the old database should be fine."
	eerror "If in doubt, ask questions in the appropriate channels (#maubot:matrix.org,"
	eerror "#gentoo:matrix.org, etc) I did not have a chance to migrate my own install, so"
	eerror "the advice above is just a best-guess."
	eerror ""
	eerror "I'm sorry that I ran out of spoons to maintain this repo."
}
