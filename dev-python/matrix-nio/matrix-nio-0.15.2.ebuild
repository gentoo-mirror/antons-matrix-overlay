# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} )
DISTUTILS_USE_SETUPTOOLS="pyproject.toml"
inherit distutils-r1

DESCRIPTION="A Python Matrix client library, designed according to sans I/O principles."
HOMEPAGE="https://github.com/poljar/matrix-nio"
SRC_URI="https://github.com/poljar/matrix-nio/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# TODO: the package optionally supports end-to-end encryption.
# We need to define a use flag and appropriate dependencies to enable that.

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-python/aiohttp-3.6.2-r1
	>=dev-python/aiofiles-0.4.0
	>=dev-python/h11-0.9.0
	>=dev-python/hyper-h2-3.2.0
	>=dev-python/logbook-1.5.3
	>=dev-python/jsonschema-3.2.0
	>=dev-python/pycryptodome-3.9.7"
# Missing: unpaddedbase64 >= 1.1.0
BDEPEND="
	dev-python/pyproject2setuppy[${PYTHON_USEDEP}]
"
