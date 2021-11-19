Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F36B457016
	for <lists+linux-api@lfdr.de>; Fri, 19 Nov 2021 14:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbhKSNzI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 19 Nov 2021 08:55:08 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44442 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbhKSNzH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 19 Nov 2021 08:55:07 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5641C1FD3E;
        Fri, 19 Nov 2021 13:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637329925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HB6UkC/m3Jhk4g15wkmgoM5cRL/6/CfVL9JQXqwekx0=;
        b=v5hP+oeYFKnDrjcewqtMjcMsjrUYzueHaN11r7c6Q9Vj/fU25rUusLbzS+JlJwN5GDfkwM
        K8TWsQgEFDOp6YxSJ5CmXk1bjUDBRLis4XA5/xZy9py27/hIhMDUawUZhCqZZBbPXRkhP7
        P/VNtdX2AFTipqYe9jozmcO8DTSPLlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637329925;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HB6UkC/m3Jhk4g15wkmgoM5cRL/6/CfVL9JQXqwekx0=;
        b=sZoOGTeYkWKgeu4QUeKM0Lkrs86DkG8/FWc3x1JdL2tyDikWc2RA+Fohk6uvsu7yiC6tDV
        gsVHvvcvRVQC4KAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42BB513B40;
        Fri, 19 Nov 2021 13:52:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MxIJDwWsl2HqcAAAMHmgww
        (envelope-from <chrubis@suse.cz>); Fri, 19 Nov 2021 13:52:05 +0000
Date:   Fri, 19 Nov 2021 14:53:10 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-api@vger.kernel.org, ltp@lists.linux.it,
        libc-alpha@sourceware.org
Subject: Re: asm-generic/int-ll64.h wrongly used on x86_64?
Message-ID: <YZesRs3/tyZY12BN@yuki>
References: <YZearmiVEw9/eor9@yuki>
 <877dd4cmsw.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dd4cmsw.fsf@oldenburg.str.redhat.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi!
> The correct format depends on whether you use struct statx from the
> glibc headers or the Linux UAPI headers.  glibc uses uint64_t, Linux
> uses __u64.  uint64_t in glibc prefers unsigned long if the type is
> 64-bit, Linux uses unsigned long long unconditionally.
> 
> One solution is to use %ju and cast to (uintmax_t).  Other cast-based
> approaches are possible as well.
> 
> I'm not happy with the situation because those casts reduce type safety
> and may suppress relevant compiler warnings.

I still do not get why can't the kernel __u64 match the uint64_t at
least in userspace. It should be as easy as:

diff --git a/include/uapi/asm-generic/types.h b/include/uapi/asm-generic/types.h
index dfaa50d99d8f..3c9a1fc5d5c3 100644
--- a/include/uapi/asm-generic/types.h
+++ b/include/uapi/asm-generic/types.h
@@ -2,8 +2,12 @@
 #ifndef _ASM_GENERIC_TYPES_H
 #define _ASM_GENERIC_TYPES_H
 /*
- * int-ll64 is used everywhere now.
+ * int-ll64 is used everywhere in kernel now.
  */
-#include <asm-generic/int-ll64.h>
+#if __BITS_PER_LONG == 64 && !__KERNEL__
+# include <asm-generic/int-l64.h>
+#else
+# include <asm-generic/int-ll64.h>
+#if

 #endif /* _ASM_GENERIC_TYPES_H */


-- 
Cyril Hrubis
chrubis@suse.cz
