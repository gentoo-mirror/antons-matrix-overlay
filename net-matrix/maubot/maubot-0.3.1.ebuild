# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP17=setuptools
PYTHON_COMPAT=( python3_{9..10} )
inherit distutils-r1

DESCRIPTION="A plugin-based Matrix bot system."
HOMEPAGE="https://github.com/maubot/maubot"
SRC_URI="
	https://github.com/maubot/maubot/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://registry.yarnpkg.com/react/-/react-17.0.2.tgz
	https://registry.yarnpkg.com/react-ace/-/react-ace-9.4.1.tgz
	https://registry.yarnpkg.com/react-contextmenu/-/react-contextmenu-2.14.0.tgz
	https://registry.yarnpkg.com/react-dom/-/react-dom-17.0.2.tgz
	https://registry.yarnpkg.com/react-json-tree/-/react-json-tree-0.16.1.tgz
	https://registry.yarnpkg.com/react-router-dom/-/react-router-dom-5.3.0.tgz

	https://registry.yarnpkg.com/react-scripts/-/react-scripts-5.0.1.tgz
	https://registry.yarnpkg.com/react-select/-/react-select-5.2.1.tgz
	https://registry.yarnpkg.com/sass/-/sass-1.34.1.tgz
	https://registry.yarnpkg.com/loose-envify/-/loose-envify-1.4.0.tgz
	https://registry.yarnpkg.com/object-assign/-/object-assign-4.1.1.tgz
	https://registry.yarnpkg.com/ace-builds/-/ace-builds-1.4.12.tgz
	https://registry.yarnpkg.com/diff-match-patch/-/diff-match-patch-1.0.4.tgz
	https://registry.yarnpkg.com/lodash.get/-/lodash.get-4.4.2.tgz
	https://registry.yarnpkg.com/lodash.isequal/-/lodash.isequal-4.5.0.tgz
	https://registry.yarnpkg.com/prop-types/-/prop-types-15.8.1.tgz
	https://registry.yarnpkg.com/classnames/-/classnames-2.2.5.tgz
	https://registry.yarnpkg.com/scheduler/-/scheduler-0.20.2.tgz
	https://registry.yarnpkg.com/@babel/runtime/-/runtime-7.16.7.tgz -> @babel-runtime-7.16.7.tgz
	https://registry.yarnpkg.com/@types/prop-types/-/prop-types-15.7.4.tgz -> @types-prop-types-15.7.4.tgz
	https://registry.yarnpkg.com/react-base16-styling/-/react-base16-styling-0.9.1.tgz
	https://registry.yarnpkg.com/history/-/history-4.9.0.tgz
	https://registry.yarnpkg.com/react-router/-/react-router-5.2.1.tgz
	https://registry.yarnpkg.com/tiny-invariant/-/tiny-invariant-1.0.2.tgz
	https://registry.yarnpkg.com/tiny-warning/-/tiny-warning-1.0.0.tgz
"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	acct-user/maubot
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
BDEPEND="
	sys-apps/yarn
"

PATCHES=(
	"${FILESDIR}"/maubot_ignore_example_config_in_package_data-${PV}.patch
)

python_compile() {
	distutils-r1_python_compile
	(
		cd maubot/management/frontend
		yarn config set disable-self-update-check true || die
		yarn config set yarn-offline-mirror "${DISTDIR}" || die
		yarn --offline --frozen-lockfile || die
		yarn --offline --frozen-lockfile build || die
	) || die
}

src_install() {
	distutils-r1_src_install
	insinto "/etc/${PN}"
	doins maubot/example-config.yaml

	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
}
