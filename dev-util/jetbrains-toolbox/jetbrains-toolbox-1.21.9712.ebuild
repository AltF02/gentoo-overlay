# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils xdg-utils

DESCRIPTION="Manage all your JetBrains Projects and Tools"
HOMEPAGE="https://www.jetbrains.com/toolbox-app"
SRC_URI="https://download.jetbrains.com/toolbox/${P}.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror bindist"

DEPEND="sys-fs/fuse:0"

QA_PRESTRIPPED="/opt/jetbrains-toolbox/jetbrains-toolbox"

src_compile() {
	./"${PN}" --appimage-extract
}

src_install() {
	keepdir /opt/jetbrains-toolbox
	insinto /opt/jetbrains-toolbox
	doins jetbrains-toolbox
	fperms +x /opt/jetbrains-toolbox/jetbrains-toolbox

	make_wrapper "${PN}" /opt/jetbrains-toolbox/jetbrains-toolbox

	insinto /usr/share/applications
	doins "${FILESDIR}/${PN}.desktop"
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
