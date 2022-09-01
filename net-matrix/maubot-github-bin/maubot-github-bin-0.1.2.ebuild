# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A GitHub client and webhook receiver for maubot"
HOMEPAGE="https://github.com/maubot/github"
SRC_URI="https://github.com/maubot/github/releases/download/v0.1.2/xyz.maubot.github-v${PV}.mbp"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	net-matrix/maubot
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	# Nothing to unpack, but further stages need a source directory to `cd` into.
	mkdir "${S}"
}

src_install() {
	insinto /var/lib/maubot/plugins/active
	doins "${DISTDIR}/xyz.maubot.github-v${PV}.mbp"

	einfo "You may need to restart maubot for it to load the new plugin."
}
