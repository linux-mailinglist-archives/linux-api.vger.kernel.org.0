Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E9E1F9A0D
	for <lists+linux-api@lfdr.de>; Mon, 15 Jun 2020 16:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbgFOO0K (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Jun 2020 10:26:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33290 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728510AbgFOO0J (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Jun 2020 10:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592231167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UyTr5iFSBoqfroTpG9Z1s4sx4zju0b9aWlIjThdySOE=;
        b=EAuTtnH2EtBsZH0Ff4CoS7M71pg2ZJxavwtQggY37nPgWwIp1YuvQTYP8esOJN5WrOzBvS
        ABaRwET9iqhInrMPVw29PNAJHuK/zBLftoebXMK4FbdijlrCxu2H8IXjTP/EH5cQ28ULP9
        TWkXRDo+WznE8YhlfMj7WqbSYXddL0Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-DQ7v2S8qPReFDMOzGk5tMg-1; Mon, 15 Jun 2020 10:26:00 -0400
X-MC-Unique: DQ7v2S8qPReFDMOzGk5tMg-1
Received: by mail-wm1-f70.google.com with SMTP id p24so4986185wma.4
        for <linux-api@vger.kernel.org>; Mon, 15 Jun 2020 07:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UyTr5iFSBoqfroTpG9Z1s4sx4zju0b9aWlIjThdySOE=;
        b=rUaStSklXylLOYzYYXSFLsiA7rZtF1JQt1+SQqhDPPbwP5mf3QueMFsYqVYPpfiu+B
         QCcswoK2ia40X+rVz13cuqfHkcRZOqLWxwpuuYxkP+2ipfa3jE5E0/G0u0e3+AYzpotc
         mwfWQq4B/2+E+77ZRPozmYaimXRp0Mbnxys6cxhTrK3PnBjevIweHwxwLcJQGML+Efgc
         pYcDUkquOK9Zo2iU23xiAQzrCaLpy5OhREZxRQEHKtTnvutj066pdy64U7KXSgkgDAYR
         GZKlXgKYDs/Rbce6ff5Xjz4QK5DUKXiHkQyl8AHZGanyV96EKpyE9th2147kgG2jNLGb
         6/KQ==
X-Gm-Message-State: AOAM533DIaZAN+jFpSngsrPwjKZFRI3IoIpkqW2aePrZG+OhTUARYGe4
        VgfB2ICfyDqKX6eRrBNl4YRf8JLg0bkNwdIl5WbzRYmvBkXYLrLmE3Rmompws/pjioUkwG2o8pE
        b2fBn+yOQCNQbrlRDKqfX
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr13113647wmj.5.1592231159627;
        Mon, 15 Jun 2020 07:25:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziFDiv7xoYX9ZVuS+8wimiXfT73l/n+JIR8kAy3So2psGRB0eWDPdWUBlhvkbtOh5Cg5p16A==
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr13113550wmj.5.1592231158457;
        Mon, 15 Jun 2020 07:25:58 -0700 (PDT)
Received: from localhost ([2001:470:5b39:29:79fc:ff4e:48ab:b845])
        by smtp.gmail.com with ESMTPSA id a81sm24495019wmd.25.2020.06.15.07.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 07:25:57 -0700 (PDT)
Date:   Mon, 15 Jun 2020 16:25:56 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Nitin Gupta <nigupta@nvidia.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Nitin Gupta <ngupta@nitingupta.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v6] mm: Proactive compaction
Message-ID: <20200615142556.5mekzzwvratx2n2i@butterfly.localdomain>
References: <20200601194822.30252-1-nigupta@nvidia.com>
 <20200615082901.eccfhaklq6fz4bh6@butterfly.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200615082901.eccfhaklq6fz4bh6@butterfly.localdomain>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 15, 2020 at 10:29:01AM +0200, Oleksandr Natalenko wrote:
> Just to let you know, this fails to compile for me with THP disabled on
> v5.8-rc1:
> 
>   CC      mm/compaction.o
> In file included from ./include/linux/dev_printk.h:14,
>                  from ./include/linux/device.h:15,
>                  from ./include/linux/node.h:18,
>                  from ./include/linux/cpu.h:17,
>                  from mm/compaction.c:11:
> In function ‘fragmentation_score_zone’,
>     inlined from ‘__compact_finished’ at mm/compaction.c:1982:11,
>     inlined from ‘compact_zone’ at mm/compaction.c:2062:8:
> ./include/linux/compiler.h:392:38: error: call to ‘__compiletime_assert_397’ declared with attribute error: BUILD_BUG failed
>   392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |                                      ^
> ./include/linux/compiler.h:373:4: note: in definition of macro ‘__compiletime_assert’
>   373 |    prefix ## suffix();    \
>       |    ^~~~~~
> ./include/linux/compiler.h:392:2: note: in expansion of macro ‘_compiletime_assert’
>   392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |  ^~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>    59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>       |                     ^~~~~~~~~~~~~~~~
> ./include/linux/huge_mm.h:319:28: note: in expansion of macro ‘BUILD_BUG’
>   319 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
>       |                            ^~~~~~~~~
> ./include/linux/huge_mm.h:115:26: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
>   115 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
>       |                          ^~~~~~~~~~~~~~~
> mm/compaction.c:64:32: note: in expansion of macro ‘HPAGE_PMD_ORDER’
>    64 | #define COMPACTION_HPAGE_ORDER HPAGE_PMD_ORDER
>       |                                ^~~~~~~~~~~~~~~
> mm/compaction.c:1898:28: note: in expansion of macro ‘COMPACTION_HPAGE_ORDER’
>  1898 |    extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
>       |                            ^~~~~~~~~~~~~~~~~~~~~~
> In function ‘fragmentation_score_zone’,
>     inlined from ‘kcompactd’ at mm/compaction.c:1918:12:
> ./include/linux/compiler.h:392:38: error: call to ‘__compiletime_assert_397’ declared with attribute error: BUILD_BUG failed
>   392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |                                      ^
> ./include/linux/compiler.h:373:4: note: in definition of macro ‘__compiletime_assert’
>   373 |    prefix ## suffix();    \
>       |    ^~~~~~
> ./include/linux/compiler.h:392:2: note: in expansion of macro ‘_compiletime_assert’
>   392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |  ^~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>    59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>       |                     ^~~~~~~~~~~~~~~~
> ./include/linux/huge_mm.h:319:28: note: in expansion of macro ‘BUILD_BUG’
>   319 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
>       |                            ^~~~~~~~~
> ./include/linux/huge_mm.h:115:26: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
>   115 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
>       |                          ^~~~~~~~~~~~~~~
> mm/compaction.c:64:32: note: in expansion of macro ‘HPAGE_PMD_ORDER’
>    64 | #define COMPACTION_HPAGE_ORDER HPAGE_PMD_ORDER
>       |                                ^~~~~~~~~~~~~~~
> mm/compaction.c:1898:28: note: in expansion of macro ‘COMPACTION_HPAGE_ORDER’
>  1898 |    extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
>       |                            ^~~~~~~~~~~~~~~~~~~~~~
> In function ‘fragmentation_score_zone’,
>     inlined from ‘kcompactd’ at mm/compaction.c:1918:12:
> ./include/linux/compiler.h:392:38: error: call to ‘__compiletime_assert_397’ declared with attribute error: BUILD_BUG failed
>   392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |                                      ^
> ./include/linux/compiler.h:373:4: note: in definition of macro ‘__compiletime_assert’
>   373 |    prefix ## suffix();    \
>       |    ^~~~~~
> ./include/linux/compiler.h:392:2: note: in expansion of macro ‘_compiletime_assert’
>   392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |  ^~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>    59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>       |                     ^~~~~~~~~~~~~~~~
> ./include/linux/huge_mm.h:319:28: note: in expansion of macro ‘BUILD_BUG’
>   319 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
>       |                            ^~~~~~~~~
> ./include/linux/huge_mm.h:115:26: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
>   115 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
>       |                          ^~~~~~~~~~~~~~~
> mm/compaction.c:64:32: note: in expansion of macro ‘HPAGE_PMD_ORDER’
>    64 | #define COMPACTION_HPAGE_ORDER HPAGE_PMD_ORDER
>       |                                ^~~~~~~~~~~~~~~
> mm/compaction.c:1898:28: note: in expansion of macro ‘COMPACTION_HPAGE_ORDER’
>  1898 |    extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
>       |                            ^~~~~~~~~~~~~~~~~~~~~~
> In function ‘fragmentation_score_zone’,
>     inlined from ‘kcompactd’ at mm/compaction.c:1918:12:
> ./include/linux/compiler.h:392:38: error: call to ‘__compiletime_assert_397’ declared with attribute error: BUILD_BUG failed
>   392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |                                      ^
> ./include/linux/compiler.h:373:4: note: in definition of macro ‘__compiletime_assert’
>   373 |    prefix ## suffix();    \
>       |    ^~~~~~
> ./include/linux/compiler.h:392:2: note: in expansion of macro ‘_compiletime_assert’
>   392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |  ^~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>    59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>       |                     ^~~~~~~~~~~~~~~~
> ./include/linux/huge_mm.h:319:28: note: in expansion of macro ‘BUILD_BUG’
>   319 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
>       |                            ^~~~~~~~~
> ./include/linux/huge_mm.h:115:26: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
>   115 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
>       |                          ^~~~~~~~~~~~~~~
> mm/compaction.c:64:32: note: in expansion of macro ‘HPAGE_PMD_ORDER’
>    64 | #define COMPACTION_HPAGE_ORDER HPAGE_PMD_ORDER
>       |                                ^~~~~~~~~~~~~~~
> mm/compaction.c:1898:28: note: in expansion of macro ‘COMPACTION_HPAGE_ORDER’
>  1898 |    extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
>       |                            ^~~~~~~~~~~~~~~~~~~~~~
> make[1]: *** [scripts/Makefile.build:281: mm/compaction.o] Error 1
> make: *** [Makefile:1764: mm] Error 2
> 

What about doing this:

diff --git a/mm/compaction.c b/mm/compaction.c
index 0d4f91dfb801..ac2030814edb 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -60,7 +60,7 @@ static const int HPAGE_FRAG_CHECK_INTERVAL_MSEC = 500;
  * calculates external fragmentation, which is used as
  * the "fragmentation score" of a node/zone.
  */
-#if defined HPAGE_PMD_ORDER
+#if defined CONFIG_TRANSPARENT_HUGEPAGE
 #define COMPACTION_HPAGE_ORDER	HPAGE_PMD_ORDER
 #elif defined HUGETLB_PAGE_ORDER
 #define COMPACTION_HPAGE_ORDER	HUGETLB_PAGE_ORDER

?

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Principal Software Maintenance Engineer

