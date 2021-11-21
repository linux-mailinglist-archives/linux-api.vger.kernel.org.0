Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1C345866B
	for <lists+linux-api@lfdr.de>; Sun, 21 Nov 2021 22:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhKUVMB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 21 Nov 2021 16:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhKUVMB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 21 Nov 2021 16:12:01 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35769C061574
        for <linux-api@vger.kernel.org>; Sun, 21 Nov 2021 13:08:56 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id l24so32635809uak.2
        for <linux-api@vger.kernel.org>; Sun, 21 Nov 2021 13:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3RG2vReGUIVq+WNNt5JWAHps80g21M6WWVDlgLB+xM=;
        b=YxiA8N/7/sjAkelyk35enzFTfyAW6EdOfmwrteLYipmIZUnFGhOJ9Oh0CYuWsfEILw
         rxmkvCtT+888/8k2PvC/zWpH4Tm2JL5B43SN18AFT4LDMiHF25skzWMzgkXiL0EdsQqU
         JgECz0t3Ia/biABswrAEHNKVEqq8D7p2aXKMDHwV4I01I3eaqaw4j3AJo1UQ6b2BWpEG
         faqJAMu6O6VxeSMLRMir/Z3dT+5e7njOGti79S+iqjTmTnT6R7VsFATWkhSSwyZUnIXF
         WNCu+Cmw/o+/VjWKiYpd2iYn10kSZKka0acSCPmrrOmq1GfTZP+RFVGFUjjIyRzq6060
         FLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3RG2vReGUIVq+WNNt5JWAHps80g21M6WWVDlgLB+xM=;
        b=1D5PaLzhmeXrIkJfJClKWbDeqIy80phAm3gWkYPqhA4zeuOLXWLyN140knTKbKF9KS
         JGFUyJkJACMpieiMeQTI/i745IlKBCXvcRKwLMmZIY0T5DCGDSn2Yfx1Mm0/NjjSTx49
         VhVUZGaScA5TuGLQxj0MWpaLBsolelxTSi4F2nN7I2OJvEFw+ZOBK4EYzMb8esm98Em2
         vEtd55EqwnmwfRBEdlS7GAUMqgQgzWf0OjKEUn9C6aB3xDpe6xclmSBhFl9uvm0ddWwz
         S86kOzqX468Rbz2CSyReoLa+AKey4bB8mga7lXmgPvZVt5dvhRURtidliRRAWPTGvyqb
         VcGw==
X-Gm-Message-State: AOAM532ldsKCxcYl4mhnn0PQl875GVDt9xqHlR47v0vdQxUro0rCy6pB
        186g2VRCqwn9ZOUQR07Hrv/KzMJPsybTaCZHRy3BdQ==
X-Google-Smtp-Source: ABdhPJw/qx9alSo1fxC94rpmGEce3mXe/rYpa9MHb1r3NsJwXYJjx3Fxup49rxNpgdrig2M4LBkQk0m+LqyiDyAbFwI=
X-Received: by 2002:a05:6102:94b:: with SMTP id a11mr126647964vsi.39.1637528935155;
 Sun, 21 Nov 2021 13:08:55 -0800 (PST)
MIME-Version: 1.0
References: <20211104195804.83240-4-posk@google.com> <202111160425.fea03oXq-lkp@intel.com>
In-Reply-To: <202111160425.fea03oXq-lkp@intel.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Sun, 21 Nov 2021 13:08:44 -0800
Message-ID: <CAFTs51UYjU_=b0SccT=LCetTTZPbMG8b=JaWf=YR6zVtK-oYew@mail.gmail.com>
Subject: Re: [PATCH v0.8 3/6] sched/umcg: implement UMCG syscalls
To:     kernel test robot <lkp@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 15, 2021 at 12:12 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Peter,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on 8ea9183db4ad8afbcb7089a77c23eaf965b0cacd]
>
> url:    https://github.com/0day-ci/linux/commits/Peter-Oskolkov/sched-mm-x86-uaccess-implement-User-Managed-Concurrency-Groups/20211105-035945
> base:   8ea9183db4ad8afbcb7089a77c23eaf965b0cacd
> config: i386-allyesconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/0day-ci/linux/commit/93e6110356346b226e3a41044aafe3d3b0906d10
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Peter-Oskolkov/sched-mm-x86-uaccess-implement-User-Managed-Concurrency-Groups/20211105-035945
>         git checkout 93e6110356346b226e3a41044aafe3d3b0906d10
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):

I cannot reproduce this. Both in my tree on top of tip, and the one
referenced above, I can compile i386 ok:

$ make ARCH=i386 allyesconfig
$ make ARCH=i386 -j16

succeeds.

$ gcc --version
gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0

>
>    In file included from <command-line>:32:
> >> ./usr/include/linux/umcg.h:80:2: error: unknown type name 'u64'
>       80 |  u64 state_ts;  /* r/w */
>          |  ^~~
> >> ./usr/include/linux/umcg.h:91:2: error: unknown type name 'u32'
>       91 |  u32 next_tid;  /* r   */
>          |  ^~~
>    ./usr/include/linux/umcg.h:93:2: error: unknown type name 'u32'
>       93 |  u32 flags;   /* Reserved; must be zero. */
>          |  ^~~
>    ./usr/include/linux/umcg.h:101:2: error: unknown type name 'u64'
>      101 |  u64 idle_workers_ptr; /* r/w */
>          |  ^~~
>    ./usr/include/linux/umcg.h:107:2: error: unknown type name 'u64'
>      107 |  u64 idle_server_tid_ptr; /* r   */
>          |  ^~~
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
