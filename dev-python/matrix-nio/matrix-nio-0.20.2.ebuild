# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{7,8,9,10,11} )
DISTUTILS_USE_PEP517="poetry"
inherit distutils-r1

DESCRIPTION="A Python Matrix client library, designed according to sans I/O principles."
HOMEPAGE="https://github.com/poljar/matrix-nio"
SRC_URI="https://github.com/poljar/matrix-nio/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="encryption"

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-python/future-0.18.2-r1
	>=dev-python/aiohttp-3.8.3
	>=dev-python/aiofiles-23.1.0
	>=dev-python/h11-0.14.0
	>=dev-python/h2-4.0.0
	>=dev-python/logbook-1.5.3
	>=dev-python/jsonschema-4.4.0
	>=dev-python/unpaddedbase64-2.1.0
	>=dev-python/pycryptodome-3.10.1
	>=dev-python/aiohttp-socks-0.7.0
	encryption? (
		>=dev-python/python-olm-3.1.3
		>=dev-python/peewee-3.14.4
		>=dev-python/cachetools-4.2.1
		>=dev-python/atomicwrites-1.4.0
	)
	"
BDEPEND="
	>=dev-python/poetry-core-1.0.0
"
