Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA411FBE3D
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2020 20:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbgFPShv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Jun 2020 14:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbgFPShv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Jun 2020 14:37:51 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719E3C061755
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 11:37:51 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n2so8753183pld.13
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 11:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LbWK89MuCvj1Sl4N39K4jNgkLJl8ySKC6ZW5gbfqTIE=;
        b=Dgp70rXHX7fnmUeMFYCfX+qP4dQ0ouFW9JvgEAXf8RQjWuosjN4K2kcoDDx3X6EGCd
         gqfzfT1evQX/H5CFii9INhsHzWc/0QRxoWNvDEje7IgWDjZAqzWwG4SFM5nnDGXrCvGq
         oYg/+EWEPEqiUnTNTUA8nUAAYg8FfdFtj7PQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LbWK89MuCvj1Sl4N39K4jNgkLJl8ySKC6ZW5gbfqTIE=;
        b=FlmpDdybgb+5BRzSGGnyrL1WY4km5CSUYOESqXm26S5V2ZN8K18zUv7R1wCitZ3+wI
         OUVjKTb2l3gfhVSEXJsiny/HQxGP6h+LnNIbdFBWnNQISOhh6+AgEmIkuS9H2b9llZmi
         P9HG7yexYCQiwDzfjepNTrlpKScaeBc1usSmAAt5yz7Bv2XLACp5I+8jpZOsD3FOs4VM
         m1oAwK+V7iMTkpmlALuMpjtAAf9Y1efqrbTxGxpRufFYWWkEoR0PgSFRcV17RIEcn48X
         cmdG48N5azoveZE8kiu7Jn728iL4RMCa3oUqrRWmMTrM28rrPSf0Smu0YMrU8vk990ry
         CaVQ==
X-Gm-Message-State: AOAM530rnSLwfVS7jVZiPWXwGXnC7G+SLKPXDeoYwqsxWvam9eLivhnO
        Xhs/GcQZqG6xZyMygPpAjnOm+g==
X-Google-Smtp-Source: ABdhPJzfKYAOTTy2Indkj4vuMYGO+9jnZ8oJ5woe6pxlS8gYmHIPPkUqYdSfRMXeUnQd3cx/XtTqWw==
X-Received: by 2002:a17:902:b58f:: with SMTP id a15mr3308489pls.106.1592332671017;
        Tue, 16 Jun 2020 11:37:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a83sm17453213pfa.146.2020.06.16.11.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 11:37:50 -0700 (PDT)
Date:   Tue, 16 Jun 2020 11:37:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Hehuazhen <hehuazhen@huawei.com>, X86 ML <x86@kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 6/8] x86: Provide API for local kernel TLB flushing
Message-ID: <202006161136.524AA1C@keescook>
References: <20200616074934.1600036-1-keescook@chromium.org>
 <20200616074934.1600036-7-keescook@chromium.org>
 <CALCETrVSnLAkWN_b7rNY1mbF16qXavbXYtv9fVZA-Q4ZVnTXhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVSnLAkWN_b7rNY1mbF16qXavbXYtv9fVZA-Q4ZVnTXhQ@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jun 16, 2020 at 09:59:29AM -0700, Andy Lutomirski wrote:
> On Tue, Jun 16, 2020 at 12:49 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > The seccomp constant action bitmap filter evaluation routine depends
> > on being able to quickly clear the PTE "accessed" bit for a temporary
> > allocation. Provide access to the existing CPU-local kernel memory TLB
> > flushing routines.
> 
> Can you write a better justification?  Also, unless I'm just

Er, dunno? That's the entire reason this series needs it.

> incompetent this morning, I can't find anyone calling this in the
> series.

It's in patch 4, seccomp_update_bitmap():
https://lore.kernel.org/lkml/20200616074934.1600036-5-keescook@chromium.org/

-- 
Kees Cook
