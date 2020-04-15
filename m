Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA721A9B18
	for <lists+linux-api@lfdr.de>; Wed, 15 Apr 2020 12:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393908AbgDOKmV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Apr 2020 06:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2896488AbgDOKXv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Apr 2020 06:23:51 -0400
Received: from mo6-p03-ob.smtp.rzone.de (mo6-p03-ob.smtp.rzone.de [IPv6:2a01:238:20a:202:5303::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8D4C03C1AD;
        Wed, 15 Apr 2020 03:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1586946179;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=mjk0gtxR3vHDozjMxfcOm68bNrEuQVSiavW2x6IZ3NE=;
        b=Aazq4xHtgt/nZGFs8ozyKJMRjogHF+UsAnFOxlfCH8UXh+ns+vXD3JeJEgTzniIP3Y
        Z7yfETZ7fPyXu9eDpzxerDG0M+JoSbwu5rbkwysU/trZz7oN4DmBapSLAxJS3kIGa7+j
        7b68Xxh22cHLSIEGEN8iFJ5huDSbpQDRbT4+DKQyZ40XT5lDjPX3vFSfz4Z98DZeiLSt
        u84MinlAST3tNRTDiGITbQXM+i5KJHwIWAR8g9by9NB2YnWfhx0+LiljmZXjLLI0EOSH
        h4dXH0t1NxX7BILLXVuRCc6Yr8WguBoDg41yGQZ/OOZgeezytgyNV90uYoKaTE6ZiRax
        TJNw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPZIvSaiyU="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.4.0 DYNA|AUTH)
        with ESMTPSA id 404ef0w3FAJn123
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 15 Apr 2020 12:19:49 +0200 (CEST)
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
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v30 08/12] crypto: provide access to a static Jitter RNG state
Date:   Wed, 15 Apr 2020 12:13:31 +0200
Message-ID: <5514806.Sqd0JiJ7ZV@positron.chronox.de>
In-Reply-To: <11836144.hkEK2qVKZC@positron.chronox.de>
References: <11836144.hkEK2qVKZC@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
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
 crypto/jitterentropy-kcapi.c                  |  3 +--
 crypto/jitterentropy.c                        | 25 ++++++++++++++++++-
 .../crypto/internal}/jitterentropy.h          |  3 +++
 3 files changed, 28 insertions(+), 3 deletions(-)
 rename {crypto =3D> include/crypto/internal}/jitterentropy.h (84%)

diff --git a/crypto/jitterentropy-kcapi.c b/crypto/jitterentropy-kcapi.c
index a5ce8f96790f..11b00e9f37f3 100644
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
index 042157f0d28b..529c9db13e64 100644
=2D-- a/crypto/jitterentropy.c
+++ b/crypto/jitterentropy.c
@@ -103,7 +103,7 @@ struct rand_data {
  * Helper functions
  *************************************************************************=
**/
=20
=2D#include "jitterentropy.h"
+#include <crypto/internal/jitterentropy.h>
=20
 /**
  * Update of the loop count used for the next round of
@@ -639,3 +639,26 @@ int jent_entropy_init(void)
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
2.25.2




