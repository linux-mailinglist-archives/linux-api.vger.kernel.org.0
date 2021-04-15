Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B69A3612C4
	for <lists+linux-api@lfdr.de>; Thu, 15 Apr 2021 21:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbhDOTNu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Apr 2021 15:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhDOTNs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Apr 2021 15:13:48 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A501C061574
        for <linux-api@vger.kernel.org>; Thu, 15 Apr 2021 12:13:22 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id o123so16717294pfb.4
        for <linux-api@vger.kernel.org>; Thu, 15 Apr 2021 12:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=h1zXu+VNyu5if1x16SnLeJ0I2nD7YTVAGnMrH1iiu4g=;
        b=Da8kk3Ru2Bm69dVW+U31nSmRoSoP3ddZHFLVGC1YDJXzA6ofjuJO8HL4M61ZWURGcP
         u9xT4agoQ5aGKF4WWFnXpdd660X0aIuTjHTv4aSddK5+koyVrquhJ1mAWr9QQIS2N8Of
         mTqj3FyDcojHi3K5uCi3U2LDyX62sfJktuYAAPIBC+sIm9c3Po5WP9/3HuWWzi1MZs6V
         YCFUStIs8khueo/Wr5EfYoxbJ88JA7sXZhmjS/v5McEbx+x47bMIxxtitFDFGbji7kaZ
         1GvTtgZsN+Y/KJduLJybLpdTdGu+MfKsAvJH0ED/zdWgaQdB+jDEfgf+hOSGR5JJEU5S
         StwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=h1zXu+VNyu5if1x16SnLeJ0I2nD7YTVAGnMrH1iiu4g=;
        b=dyQcvitqKiNtmkxooS7k5Tyoky3Gj5RxjBzKCeOneqESoF+DNdQfRH79TOx8dz7pHg
         qmP73yaRXpmKNUXwxESwiD4FUDIFWnXzo4avW5vbbt6lmDprp6TT5XndQP2PHyflBF6R
         bS74BVWlak7PiqumpdFz5BwHGlaR4xGB8YE8nvmXUuzwuJhrZE+QeJzzpHly7j1IVSk+
         Df3NQwWujPAZsM8zTBDxa6FEHlHAEiz7NCAmaRmPb+Po0bR7k56qEHBNosd7vHWDG6cu
         ZsA2r6CxlM4s0GNTE0uz39b+xxr29M2LF7KILziHRqRd3/0RdjHI/BIbd/Ag8EWrSpii
         k6Aw==
X-Gm-Message-State: AOAM531pjBNoUPUOeEYoQmV445KW6oseNRNXExF2/rIF8dC1X3uWO39y
        J6E1Gj6yzuc334VqgblnXH9P4g==
X-Google-Smtp-Source: ABdhPJznpqpLKwAuprmZh3WbW3wgm0rw1K6uqqbCyeA2MuO/YVkgITmGAXD7h9S1rpEBtQa9h8IViQ==
X-Received: by 2002:a63:ff0a:: with SMTP id k10mr4884479pgi.303.1618514001644;
        Thu, 15 Apr 2021 12:13:21 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j3sm2590490pfc.49.2021.04.15.12.13.20
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 15 Apr 2021 12:13:21 -0700 (PDT)
Date:   Thu, 15 Apr 2021 12:12:48 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Axel Rasmussen <axelrasmussen@google.com>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v3 00/10] userfaultfd: add minor fault handling for
 shmem
In-Reply-To: <20210415184732.3410521-1-axelrasmussen@google.com>
Message-ID: <alpine.LSU.2.11.2104151203320.15150@eggly.anvils>
References: <20210415184732.3410521-1-axelrasmussen@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 15 Apr 2021, Axel Rasmussen wrote:

> Base
> ====
> 
> This series is based on (and therefore should apply cleanly to) the tag
> "v5.12-rc7-mmots-2021-04-11-20-49", additionally with Peter's selftest cleanup
> series applied first:
> 
> https://lore.kernel.org/patchwork/cover/1412450/
> 
> Changelog
> =========
> 
> v2->v3:
> - Picked up {Reviewed,Acked}-by's.
> - Reorder commits: introduce CONTINUE before MINOR registration. [Hugh, Peter]
> - Don't try to {unlock,put}_page an xarray value in shmem_getpage_gfp. [Hugh]
> - Move enum mcopy_atomic_mode forward declare out of CONFIG_HUGETLB_PAGE. [Hugh]
> - Keep mistakenly removed UFFD_USER_MODE_ONLY in selftest. [Peter]
> - Cleanup context management in self test (make clear implicit, remove unneeded
>   return values now that we have err()). [Peter]
> - Correct dst_pte argument to dst_pmd in shmem_mcopy_atomic_pte macro. [Hugh]
> - Mention the new shmem support feature in documentation. [Hugh]

I shall ignore this v3 completely: "git send-email" is a wonderful
tool for mailing out patchsets in quick succession, but I have not
yet mastered "git send-review" to do the thinking for me as quickly.

Still deliberating on 4/9 and 9/9 of v2: they're very close,
but raise userfaultfd questions I still have to answer myself.

Hugh
