# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Installs a typical configuration of dendrite."
HOMEPAGE="https://gitlab.com/anton.molyboha/dendrite-server"
# SRC_URI=""
EGIT_REPO_URI="https://gitlab.com/anton.molyboha/dendrite-server.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	net-matrix/dendrite
	>=dev-db/postgresql-9.6
	www-servers/nginx
	app-crypt/certbot-nginx
	sys-devel/m4
	sys-apps/util-linux"
BDEPEND="sys-devel/m4 sys-apps/util-linux"

src_compile() {
	make PREFIX="${EPREFIX}" all
}

src_install() {
	insinto /opt/${PN}
	doins dendrite.yaml.template
	doins nginx.conf.template
	insopts --mode=755
	doins dendrite-server-autoconfig.sh
}

pkg_config() {
	if test -n "$ROOT" ; then
		# TODO: create a script that can be run from the target system.
		die "Cross-emerge (non-empty \$ROOT) is not supported."
	fi
	"${EROOT}/opt/${PN}/dendrite-server-autoconfig.sh"
}
