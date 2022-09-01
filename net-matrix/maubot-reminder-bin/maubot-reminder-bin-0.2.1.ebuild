# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A maubot plugin to remind you about things."
HOMEPAGE="https://github.com/maubot/reminder"
SRC_URI="https://github.com/maubot/reminder/releases/download/v0.2.1/xyz.maubot.reminder-v${PV}.mbp"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	net-matrix/maubot
	dev-python/pytz
	dev-python/python-dateutil
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	# Nothing to unpack, but further stages need a source directory to `cd` into.
	mkdir "${S}"
}

src_install() {
	insinto /var/lib/maubot/plugins/active
	doins "${DISTDIR}/xyz.maubot.reminder-v${PV}.mbp"

	einfo "You may need to restart maubot for it to load the new plugin."
}
