# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Matrix server written in Go"
HOMEPAGE="https://matrix.org https://github.com/element-hq/dendrite"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="acct-user/dendrite acct-group/dendrite"
BDEPEND=""

go-module_set_globals

SRC_URI="https://github.com/element-hq/dendrite/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://files.anton.molyboha.me/gentoo-files/net-matrix/dendrite/${P}-deps.tar.xz"
GO_IMPORTPATH="github.com/matrix-org/dendrite"
EGO_PN="${GO_IMPORTPATH}/cmd/..."

OUT_GOPATH="${S}/go-path"

src_unpack() {
	go-module_src_unpack || die
}

src_compile() {
	env GOPATH="${OUT_GOPATH}":/usr/lib/go-gentoo GOCACHE="${T}"/go-cache CGO_ENABLED=1 \
		go build -trimpath -v -x -work -o bin/ "${S}"/cmd/... || die
}

src_test() {
	env GOPATH="${OUT_GOPATH}":/usr/lib/go-gentoo GOCACHE="${T}"/go-cache go test -trimpath -v -x -work "${S}"/cmd/... || die
}

src_install() {
	local f
	for f in $(ls "${S}/bin/") ; do
		dobin "${S}/bin/${f}"
	done

	dodir "/etc/dendrite"
	insinto /etc/dendrite
	doins "${S}/dendrite-sample.yaml"
	newinitd "${FILESDIR}"/dendrite.0.12.initd dendrite
	newconfd "${FILESDIR}"/dendrite.0.12.confd dendrite

	keepdir "/var/log/dendrite"
	fowners dendrite:dendrite "/var/log/dendrite"

	einfo "If this is a new installation of dendrite, you most likely still need"
	einfo "to do a few configuration steps and/or install some other programs."
	einfo "See https://matrix-org.github.io/dendrite/installation for detailed"
	einfo "instructions."
	einfo "The sample config has been installed into"
	einfo "    ${EPREFIX}/etc/dendrite/dendrite-sample.yaml"
	einfo "Copy it into ${EPREFIX}/etc/dendrite/dendrite.yaml"
	einfo "and edit to your liking."
	einfo "The OpenRC service is called 'dendrite'"
}
