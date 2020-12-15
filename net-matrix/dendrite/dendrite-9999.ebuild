# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 golang-build
# inherit golang-vcs golang-build

DESCRIPTION="Matrix server written in Go"
HOMEPAGE=""
EGIT_REPO_URI="https://github.com/matrix-org/dendrite"
EGO_PN="github.com/matrix-org/dendrite/cmd/..."

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="kafka sqlite postgresql"

REQUIRED_USE="|| ( sqlite postgresql )"

DEPEND=""
RDEPEND="kafka? ( net-misc/kafka-bin ) postgresql? ( >=dev-db/postgresql-9.6 )"
BDEPEND=""

src_unpack() {
	mkdir -vp "${S}/src/github.com/matrix-org" || die
	EGIT_CHECKOUT_DIR="${S}/src/github.com/matrix-org/dendrite" \
		git-r3_src_unpack || die
}
