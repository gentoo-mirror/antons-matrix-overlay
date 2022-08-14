# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP17=setuptools
PYTHON_COMPAT=( python3_{9..10} )
inherit distutils-r1

DESCRIPTION="A plugin-based Matrix bot system."
HOMEPAGE="https://github.com/maubot/maubot"
SRC_URI="https://github.com/maubot/maubot/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-python/mautrix-0.15.5
	<dev-python/mautrix-0.16.0
	>=dev-python/aiohttp-3.0.0
	<dev-python/aiohttp-4.0.0
	>=dev-python/yarl-1.0.0
	<dev-python/yarl-2.0.0
	>=dev-python/sqlalchemy-1.0.0
	<dev-python/sqlalchemy-1.4.0
	>=dev-python/asyncpg-0.20.0
	<dev-python/asyncpg-0.26.0
	>=dev-python/aiosqlite-0.16.0
	<dev-python/aiosqlite-0.18.0
	>=dev-python/commonmark-0.9.0
	<dev-python/commonmark-1.0.0
	>=dev-python/ruamel-yaml-0.15.35
	<dev-python/ruamel-yaml-0.18.0
	>=dev-python/attrs-18.1.0
	>=dev-python/bcrypt-3.0.0
	<dev-python/bcrypt-4.0.0
	>=dev-python/packaging-10.0.0
	>=dev-python/click-7.0.0
	<dev-python/click-9.0.0
	>=dev-python/colorama-0.4.0
	<dev-python/colorama-0.5.0
	>=dev-python/questionary-1.0.0
	<dev-python/questionary-2.0.0
	>=dev-python/jinja-2.0.0
	<dev-python/jinja-4.0.0
"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}"/maubot_ignore_example_config_in_package_data-${PV}.patch
)

src_install() {
	distutils-r1_src_install
	insinto "/etc/${PN}"
	doins maubot/example-config.yaml

	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
}
