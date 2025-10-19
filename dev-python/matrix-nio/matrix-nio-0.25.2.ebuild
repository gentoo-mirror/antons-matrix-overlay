# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8,9,10,11,12,13,14} )
DISTUTILS_USE_PEP517="setuptools"
inherit distutils-r1

MY_PV="${PV/_rc/rc}"
DESCRIPTION="A Python Matrix client library, designed according to sans I/O principles."
HOMEPAGE="https://github.com/matrix-nio/matrix-nio"
SRC_URI="https://github.com/matrix-nio/matrix-nio/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="encryption"

REQUIRED_USE="test? ( encryption )"

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-python/aiohttp-3.10.0
	<dev-python/aiohttp-4.0.0
	>=dev-python/aiofiles-24.1.0
	<dev-python/aiofiles-25.0.0
	>=dev-python/h11-0.14.0
	<dev-python/h11-0.15.0
	>=dev-python/h2-4.0.0
	<dev-python/h2-5.0.0
	>=dev-python/jsonschema-4.14.0
	<dev-python/jsonschema-5.0.0
	>=dev-python/unpaddedbase64-2.1.0
	<dev-python/unpaddedbase64-3.0.0
	>=dev-python/pycryptodome-3.10.1
	<dev-python/pycryptodome-4.0.0
	>=dev-python/aiohttp-socks-0.8.4
	<dev-python/aiohttp-socks-0.11.0
	encryption? (
		>=dev-python/python-olm-3.2.16
		<dev-python/python-olm-4.0.0
		>=dev-python/peewee-3.14.4
		<dev-python/peewee-4.0.0
		>=dev-python/cachetools-5.3.3
		<dev-python/cachetools-7.0.0
		>=dev-python/atomicwrites-1.4.0
		<dev-python/atomicwrites-2.0.0
	)
	"
BDEPEND="
	>=dev-python/setuptools-61.0.0
	test? (
		${RDEPEND}
		>=dev-python/pytest-8.2.0
		>=dev-python/pytest-asyncio-0.24.0
		>=dev-python/hyperframe-6.0.0
		<dev-python/hyperframe-7.0.0
		>=dev-python/hypothesis-6.8.9
		<dev-python/hypothesis-7.0.0
		>=dev-python/hpack-4.0.0
		<dev-python/hpack-5.0.0
		>=dev-python/faker-8.0.0
		>=dev-python/mypy-1.11.0
		<dev-python/mypy-2.0.0
		>=dev-python/pytest-aiohttp-0.3.0
		>=dev-python/aioresponses-0.7.4
		<dev-python/aioresponses-0.8.0
	)
"

PATCHES=(
	"${FILESDIR}/${P}-fix-pytest-event-loop.patch"
)

distutils_enable_tests pytest

python_test() {
	# Skip `tests/async_client_test::TestClass::test_connect_wrapper` because it requires network.
	epytest -k 'not (async_client_test and TestClass and test_connect_wrapper) and not (key_export_test and TestClass and test_encrypt_rounds)'
}
