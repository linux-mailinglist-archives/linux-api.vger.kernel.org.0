Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF7626FA04
	for <lists+linux-api@lfdr.de>; Fri, 18 Sep 2020 12:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgIRKMR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 18 Sep 2020 06:12:17 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.100]:29477 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgIRKMO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 18 Sep 2020 06:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1600423932;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Es9pGKLx4z5oIgmChL28JnLmrOhua6NbH8JPKO7vMAs=;
        b=VwL/1DcajkV0w7hBIPVZxOSBgMDtjp5ADCLuSvBYFcVFD8VC0VJw1p2qZt3ApenYqt
        xG/ObQkWpG4WqbkQbOZkOaxQPWwh2O0n/fcM3IJkLAfxLlen4m/OC4pbzXf9ZOYecc65
        e5FHLk5MtOgaiAQx4P1/hdVyMMH7OOa14Y7peq9Cou/WFxhGv1NdRjRtaVn+IyQRexzI
        Ax43Cy1CYitM9oXwtK2MGN8qsVhtbH5GzkmY43NRW3yvzHKhX4wPgVzizx/18Uadc35f
        NTvWtMgyrFE4pXTT7vgTd+tYZBfwcWbPrjJVDcriWvw+D5p1TIRWEy6PHultzHdeTuDQ
        tRpQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDaJPScXyVH"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id 002e9aw8IA0A2T4
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 18 Sep 2020 12:00:10 +0200 (CEST)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>, ebiggers@kernel.org
Subject: [PATCH v35 09/13] crypto: provide access to a static Jitter RNG state
Date:   Fri, 18 Sep 2020 11:51:25 +0200
Message-ID: <3352123.iIbC2pHGDl@positron.chronox.de>
In-Reply-To: <5667034.lOV4Wx5bFT@positron.chronox.de>
References: <2544450.mvXUDI8C0e@positron.chronox.de> <5532247.MhkbZ0Pkbq@positron.chronox.de> <5667034.lOV4Wx5bFT@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

To support the LRNG operation which uses the Jitter RNG separately
from the kernel crypto API, at a time where potentially the regular
memory management is not yet initialized, the Jitter RNG needs to
provide a state whose memory is defined at compile time. As only once
instance will ever be needed by the LRNG, define once static memory
block which is solely to be used by the LRNG.

CC: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Alexander E. Patrakov" <patrakov@gmail.com>
CC: "Ahmed S. Darwish" <darwish.07@gmail.com>
CC: "Theodore Y. Ts'o" <tytso@mit.edu>
CC: Willy Tarreau <w@1wt.eu>
CC: Matthew Garrett <mjg59@srcf.ucam.org>
CC: Vito Caputo <vcaputo@pengaru.com>
CC: Andreas Dilger <adilger.kernel@dilger.ca>
CC: Jan Kara <jack@suse.cz>
CC: Ray Strode <rstrode@redhat.com>
CC: William Jon McCann <mccann@jhu.edu>
CC: zhangjs <zachary@baishancloud.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Florian Weimer <fweimer@redhat.com>
CC: Lennart Poettering <mzxreary@0pointer.de>
CC: Nicolai Stange <nstange@suse.de>
Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
Tested-by: Roman Drahtm=FCller <draht@schaltsekun.de>
Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Tested-by: Neil Horman <nhorman@redhat.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
=2D--
 crypto/jitterentropy-kcapi.c                  |  3 +-
 crypto/jitterentropy.c                        | 31 ++++++++++++++++++-
 .../crypto/internal}/jitterentropy.h          |  3 ++
 3 files changed, 34 insertions(+), 3 deletions(-)
 rename {crypto =3D> include/crypto/internal}/jitterentropy.h (84%)

diff --git a/crypto/jitterentropy-kcapi.c b/crypto/jitterentropy-kcapi.c
index eb7d1dd506bf..25a192f5984e 100644
=2D-- a/crypto/jitterentropy-kcapi.c
+++ b/crypto/jitterentropy-kcapi.c
@@ -43,8 +43,7 @@
 #include <linux/time.h>
 #include <linux/crypto.h>
 #include <crypto/internal/rng.h>
=2D
=2D#include "jitterentropy.h"
+#include <crypto/internal/jitterentropy.h>
=20
 /*************************************************************************=
**
  * Helper function
diff --git a/crypto/jitterentropy.c b/crypto/jitterentropy.c
index 6e147c43fc18..fa1459f09b01 100644
=2D-- a/crypto/jitterentropy.c
+++ b/crypto/jitterentropy.c
@@ -117,7 +117,7 @@ struct rand_data {
 #define JENT_EHEALTH		9 /* Health test failed during initialization */
 #define JENT_ERCT		10 /* RCT failed during initialization */
=20
=2D#include "jitterentropy.h"
+#include <crypto/internal/jitterentropy.h>
=20
 /*************************************************************************=
**
  * Adaptive Proportion Test
@@ -854,3 +854,32 @@ int jent_entropy_init(void)
=20
 	return 0;
 }
+
+struct rand_data *jent_lrng_entropy_collector(void)
+{
+	static unsigned char lrng_jent_mem[JENT_MEMORY_SIZE];
+	static struct rand_data lrng_jent_state =3D {
+		.data		=3D 0,
+		.old_data	=3D 0,
+		.prev_time	=3D 0,
+		.last_delta	=3D 0,
+		.last_delta2	=3D 0,
+		.osr		=3D 1,
+		.mem		=3D lrng_jent_mem,
+		.memlocation	=3D 0,
+		.memblocks	=3D JENT_MEMORY_BLOCKSIZE,
+		.memblocksize	=3D JENT_MEMORY_BLOCKS,
+		.memaccessloops	=3D JENT_MEMORY_ACCESSLOOPS,
+		.rct_count	=3D 0,
+		.apt_observations =3D 0,
+		.apt_count	=3D 0,
+		.apt_base	=3D 0,
+		.apt_base_set	=3D 0,
+		.health_failure =3D 0
+	};
+
+	if (jent_entropy_init())
+		return NULL;
+
+	return &lrng_jent_state;
+}
diff --git a/crypto/jitterentropy.h b/include/crypto/internal/jitterentropy=
=2Eh
similarity index 84%
rename from crypto/jitterentropy.h
rename to include/crypto/internal/jitterentropy.h
index c83fff32d130..6e07d86eac82 100644
=2D-- a/crypto/jitterentropy.h
+++ b/include/crypto/internal/jitterentropy.h
@@ -15,3 +15,6 @@ extern int jent_read_entropy(struct rand_data *ec, unsign=
ed char *data,
 extern struct rand_data *jent_entropy_collector_alloc(unsigned int osr,
 						      unsigned int flags);
 extern void jent_entropy_collector_free(struct rand_data *entropy_collecto=
r);
+
+/* Access to statically allocated Jitter RNG instance */
+extern struct rand_data *jent_lrng_entropy_collector(void);
=2D-=20
2.26.2




