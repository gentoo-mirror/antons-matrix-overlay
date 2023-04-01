# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_10 )
inherit distutils-r1

DESCRIPTION=""
HOMEPAGE="
	https://github.com/tholo/pytest-flake8
	https://pypi.org/project/pytest-flake8/
"
SRC_URI="https://github.com/tholo/pytest-flake8/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/flake8-4.0.0
	>=dev-python/pytest-7.0.0
"
BDEPEND="
	test? (
		${RDEPEND}
	)
"

distutils_enable_tests pytest
