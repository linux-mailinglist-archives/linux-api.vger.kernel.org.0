Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF6C10808E
	for <lists+linux-api@lfdr.de>; Sat, 23 Nov 2019 21:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfKWUjz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 23 Nov 2019 15:39:55 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.102]:15647 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfKWUjy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 23 Nov 2019 15:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574541589;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=aPZ/5dq1Q5Q0xxxZcch63UgLnu9JOzeEUdd+tUFCBSE=;
        b=m5FCiOrd+1HcbMsPyyy5r4OOv4EEYG9atE6ZNxb6aSbsA6cjHT8TbpwwpJ6GSTWOIl
        rgvFOJCfL+lNuN1V0WljP4SBQUB+OxAJdSrSJBo6ysfUWI419uNg0tyIMjqYfibxOOoo
        HUNap8Ioq9Lu05bi+0j63pzkir3Me0Y/l6R6ZHmXOkGKp8SQy0cf0XTsmW1XujoaMKpg
        Ji13Z+Wm2O3JN3zkk8CozajkBeXjnn1YpY+5B02zlrRzxoSeiC7hDtplL1rN+Eqw2PWa
        lmfnGhbrhGvxPCGh9xT/L68Hcu3y7Du0wO8/8BVMmeUz4Cy8Y8sszpC/S4KYZZikqkg5
        JHXA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDaJfSfWrhX"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id N09a57vANKcW3yT
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 23 Nov 2019 21:38:32 +0100 (CET)
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
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v26 08/12] crypto: provide access to a static Jitter RNG state
Date:   Sat, 23 Nov 2019 21:33:24 +0100
Message-ID: <2834718.39UZt9kXIA@positron.chronox.de>
In-Reply-To: <2722222.P16TYeLAVu@positron.chronox.de>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <2787174.DQlWHN5GGo@positron.chronox.de> <2722222.P16TYeLAVu@positron.chronox.de>
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
 crypto/jitterentropy.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/crypto/jitterentropy.c b/crypto/jitterentropy.c
index 77fa2120fe0c..3a815495f778 100644
=2D-- a/crypto/jitterentropy.c
+++ b/crypto/jitterentropy.c
@@ -644,3 +644,26 @@ int jent_entropy_init(void)
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
=2D-=20
2.23.0




