Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4FD1DEE1F
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2020 19:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbgEVRWz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 22 May 2020 13:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730471AbgEVRWy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 22 May 2020 13:22:54 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E05CC05BD43
        for <linux-api@vger.kernel.org>; Fri, 22 May 2020 10:22:54 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id c75so5288306pga.3
        for <linux-api@vger.kernel.org>; Fri, 22 May 2020 10:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=amaxCECevOSXJrGQyIuXx97hyD0UaNdLUI7ilZbNErE=;
        b=QdOKlWAUfaOgmRv2+ys3+AI8VRaQjQGwiQE2Q9ixqsSc47+pg8ot2k8eV9uY4lzp++
         i0TuH4yEnQR5YabGAbnFYlP73coOX4eGfIXprx+hq/fwlynG47mBziM1nHeMmGvyGC/p
         xuiDofpqRF65/vevf6CbCee7998FCjaJgYfFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=amaxCECevOSXJrGQyIuXx97hyD0UaNdLUI7ilZbNErE=;
        b=QMboPGQHH4xtPGJhk8k2UJF1OlLoIk8hKDDUoEB7YB0YEyCLvItYI54vq7mQg9QXeY
         nkZbzaNLk86SFx03u0cTIcsrMpTokr142WfFSbaifjbP1XBVlYmYvp1H9dHxCjGThIBJ
         8T+fShp0y84kMR1LXAfVoV6j1XUvsFZynUceu5HCzWoM/6v5fj8PecHT9J+GQcq9vHXk
         2zqWnyZ36vElhCH18GaAxGtNAvgBFPlBAWPTdEqMfptVQmE6u4pOdCNncLwLBkiFBqVn
         z2aGASI8BJPPcgbATQ6pa8XojMK1FcbZ0kvRospn0Re46K/sz/Az07MH2oLv4pwkPgv1
         AgCQ==
X-Gm-Message-State: AOAM531oztV9UzeAi6oHsbzd6spgubqdZmR3WWI78VbCuPwISP7iYq38
        Io4UENzOXRfA8u/6kpCb6P1vPQ==
X-Google-Smtp-Source: ABdhPJxp9FF04TnejNRz/NvrR22fKHIQ7m8bWd6qeiuqYrLZnucmLNFQPYrNAd8AJZHV+du2CRuRLQ==
X-Received: by 2002:aa7:9ab6:: with SMTP id x22mr4840028pfi.136.1590168173772;
        Fri, 22 May 2020 10:22:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d22sm6676581pgh.64.2020.05.22.10.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 10:22:52 -0700 (PDT)
Date:   Fri, 22 May 2020 10:22:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Subject: Re: [RFC PATCH 5/5] selftest/x86: Add CET quick test
Message-ID: <202005221020.B578B8C6@keescook>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
 <20200521211720.20236-6-yu-cheng.yu@intel.com>
 <20200522092848.GJ325280@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522092848.GJ325280@hirez.programming.kicks-ass.net>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 22, 2020 at 11:28:48AM +0200, Peter Zijlstra wrote:
> Get asm/asm.h into userspace and then write something like:

Yeah, selftests is going to start suffering from the same "tools/ header
duplication" problem. I've also had cases (see the logic in the Makefile
in selftests/x86) where selftests is duplicating existing Kconfig and
Makefile logic ("can I build this way?")

But yes, I think getting a copy of asm.h would be nice here. I don't
think the WRITE_ONCE() is needed in this particular case. Hmm.

-- 
Kees Cook
