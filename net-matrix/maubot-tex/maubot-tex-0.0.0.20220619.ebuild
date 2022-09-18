# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A maubot plugin to render LaTeX as SVG"
HOMEPAGE="https://github.com/maubot/tex"
GIT_COMMIT="52c2ffe998f9e8b8c88ddd320f29ee397a0ba54c"
SRC_URI="https://github.com/maubot/tex/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	net-matrix/maubot
	dev-python/matplotlib[latex]
"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/zip"

S="${WORKDIR}/tex-${GIT_COMMIT}"

PATCHES=(
	# The bugfix from https://github.com/jtracey/tex/tree/escape
	"${FILESDIR}/close-escape-math-mode-vulnerability-${PV}.patch"
)

src_compile() {
	zip -r "xyz.maubot.tex-v${PV}.mbp" maubot.yaml base-config.yaml tex.py
}

src_install() {
	insinto /var/lib/maubot/plugins/active
	doins "xyz.maubot.tex-v${PV}.mbp"

	einfo "You may need to restart maubot for it to load the new plugin."
}
