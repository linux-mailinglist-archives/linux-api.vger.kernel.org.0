Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778525F3A2D
	for <lists+linux-api@lfdr.de>; Tue,  4 Oct 2022 01:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiJCX5m (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 Oct 2022 19:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiJCX5d (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 Oct 2022 19:57:33 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2951E220CC
        for <linux-api@vger.kernel.org>; Mon,  3 Oct 2022 16:57:32 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 83so4597982pfw.10
        for <linux-api@vger.kernel.org>; Mon, 03 Oct 2022 16:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=UHb21iKAOr0dixbnKvFOpyl+rdeQazDsJI0KUTcj5+g=;
        b=KpStkDnnuZCV5Ylx+JpcbSSVcZ5VtJEhUFrVM3vKtPMRB8Q2OY9QojiRRJkwtr68xO
         78FdHhezN5LHg2lyEeohpeZjvyF+/uATLemjDAhmV66ktRlADy9jiwIKe9pwRbwj5m5y
         AWYkxxyxNZ3sc1IMKb8B+XVg6xzbZdkYuPpvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UHb21iKAOr0dixbnKvFOpyl+rdeQazDsJI0KUTcj5+g=;
        b=lGqVOb6a1fKxZv3FsxBkEG1/Zf53oGFyj47knbDTS5VPDF1vPvQeNn5gHaVXg14F5T
         e04ODCCQGYJWY4nc+ZNAQXS8xfCTlxGNFO+bT9G1/guH9T1SJM+iipcdYDrUcZeQ/cec
         ks8p9UOChtfkYMkcM7txwxBHOqTGEUy7widBwlKcvN7w8UGAx1FJUET0VBOZbdiHvAxY
         DnoHIHWMUFGF/EdcLAklD0NTE8ErCyMUtirHf6/XzMhc0bZvu0NGkfPLxBEeNNzV1RbD
         cb8EAfCqW8Jqsz7VfMY1+QalVRnU3cj90Gbhs4GeCwIYqwIRtGzOUXlq1nznconkClbK
         HU7g==
X-Gm-Message-State: ACrzQf1fxfvdTdr2V7EM6hDuD602lAz9JrDTmNiKwa8WC1X49qvpb95y
        rmCIvhqT35hLw0SKbZfq2Y7qTQ==
X-Google-Smtp-Source: AMsMyM4miqD1QvaIAofzYNdJ7PobZDSOM4f6o2pYjvzrBRyiOKLNOKFLm/OFeOKRY5a5vyljxQgJow==
X-Received: by 2002:a63:90c1:0:b0:450:75b5:29fe with SMTP id a184-20020a6390c1000000b0045075b529femr5070949pge.541.1664841451616;
        Mon, 03 Oct 2022 16:57:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k14-20020a6555ce000000b0043057fe66c0sm7263780pgs.48.2022.10.03.16.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 16:57:31 -0700 (PDT)
Date:   Mon, 3 Oct 2022 16:57:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Subject: Re: [PATCH v2 33/39] x86/cpufeatures: Limit shadow stack to Intel
 CPUs
Message-ID: <202210031656.23FAA3195@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-34-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-34-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:30PM -0700, Rick Edgecombe wrote:
> Shadow stack is supported on newer AMD processors, but the kernel
> implementation has not been tested on them. Prevent basic issues from
> showing up for normal users by disabling shadow stack on all CPUs except
> Intel until it has been tested. At which point the limitation should be
> removed.
> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

So running the selftests on an AMD system is sufficient to drop this
patch?

-- 
Kees Cook
