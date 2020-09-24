Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD48B2779F4
	for <lists+linux-api@lfdr.de>; Thu, 24 Sep 2020 22:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIXUIe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 24 Sep 2020 16:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgIXUId (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 Sep 2020 16:08:33 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B72C0613CE
        for <linux-api@vger.kernel.org>; Thu, 24 Sep 2020 13:00:37 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 197so362382pge.8
        for <linux-api@vger.kernel.org>; Thu, 24 Sep 2020 13:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+MD2QubiwKdZDJzjnc2wAOK3dZyKxhcYOawuWHop+Wo=;
        b=avbGCQqM983qSOxtkvStgCWx9sRpEeKEGDHd9YWkndoou2/aH5siCielYiOMrMzduL
         Fe2noZykDUuGZ4LQR9NHfzh+YZq63h5jKJDfKza+jfdwvAziUO2yCVU35rzmrXXSDvW8
         Up/SO6HKiwkFMBN2H+97Gna9dqtcH5g3Y0HbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+MD2QubiwKdZDJzjnc2wAOK3dZyKxhcYOawuWHop+Wo=;
        b=lo1+tmZF0uEMK1WSZ6pZ01JX8PJGJ3M4nnKsQI1xIFZBLHRXQd5PaHrkAlxvjh6qh8
         5Zp8noUP8XE3+6GY7ZeJRf27m8gZwzKF2I9kUIp0SFAf7qoVJfMsw05NiNV0L3g5h57n
         Sj+nLeXm0xeG+6qq3LKYru9aDxl4bLcjfcmGWRIddAG+ca1Qn2o+116wGF1PIqM/4K7J
         ciq9UIED95lbeHTGS5mitSqdjoA7IV713g7hBeoqikpLPbnyl51wTU8np9Y7KBNAPpEC
         C/IQOagAEfBCSEExDP0EBZqTwBsOZto0SNjjQLKeMDqa3nunsC3k2SV2Mxg5ZWTTKhhE
         rkLg==
X-Gm-Message-State: AOAM532dmlYZggdIVGxnmbAOjMueCXDeO1q445ZRUgZjpnDDRWau5wbT
        dSJybL0i9MOMJXI3Fb9gkE9jNg==
X-Google-Smtp-Source: ABdhPJw+cepPZiirv+WRgNOWJCnEG6K3L6esLxka7Bt1UZlgbovFX+43wYSgm0HkhFGg9/Z7NbQHsw==
X-Received: by 2002:a63:1464:: with SMTP id 36mr606764pgu.160.1600977636906;
        Thu, 24 Sep 2020 13:00:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c9sm295293pfn.78.2020.09.24.13.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 13:00:35 -0700 (PDT)
Date:   Thu, 24 Sep 2020 13:00:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     YiFei Zhu <yifeifz2@illinois.edu>, Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>, bpf@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/6] seccomp: Implement constant action bitmaps
Message-ID: <202009241253.7D238A4@keescook>
References: <20200923232923.3142503-1-keescook@chromium.org>
 <20200924185702.GA9225@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924185702.GA9225@redhat.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 24, 2020 at 02:57:02PM -0400, Andrea Arcangeli wrote:
> Hello,
> 
> I'm posting this only for the record, feel free to ignore.
> 
> On Wed, Sep 23, 2020 at 04:29:17PM -0700, Kees Cook wrote:
> > rfc: https://lore.kernel.org/lkml/20200616074934.1600036-1-keescook@chromium.org/
> > alternative: https://lore.kernel.org/containers/cover.1600661418.git.yifeifz2@illinois.edu/
> > v1:
> > - rebase to for-next/seccomp
> > - finish X86_X32 support for both pinning and bitmaps
> 
> It's pretty clear the O(1) seccomp filter bitmap was first was
> proposed by your RFC in June (albeit it was located in the wrong place
> and is still in the wrong place in v1).
> 
> > - replace TLB magic with Jann's emulator
>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     
> That's a pretty fundamental change in v1 compared to your the
> non-competing TLB magic technique you used in the RFC last June.
> 
> The bitmap isn't the clever part of the patch, the bitmap can be
> reviewed in seconds, the difficult part to implement and to review is
> how you fill the bitmap and in that respect there's absolutely nothing
> in common in between the "rfc:" and the "alternative" link.
> 
> In June your bitmap-filling engine was this:
> 
> https://lore.kernel.org/lkml/20200616074934.1600036-5-keescook@chromium.org/
> 
> Then on Sep 21 YiFei Zhu posted his new innovative BPF emulation
> innovation that obsoleted your TLB magic of June:
> 
> https://lists.linuxfoundation.org/pipermail/containers/2020-September/042153.html
> 
> And on Sep 23 instead of collaborating and helping YiFei Zhu to
> improve his BPF emulator, you posted the same technique that looks
> remarkably similar without giving YiFei Zhu any attribution and you
> instead attribute the whole idea to Jann Horn:
> 
> https://lkml.kernel.org/r/20200923232923.3142503-5-keescook@chromium.org

?? Because it IS literally Jann's code:
https://lore.kernel.org/lkml/CAG48ez1p=dR_2ikKq=xVxkoGg0fYpTBpkhJSv1w-6BG=76PAvw@mail.gmail.com/
As the first reply to 20200616074934.1600036-5-keescook@chromium.org. In
June. Which I agreed was the way to go. In June.

And When YiFei Zhu sent their series, I saw they were headed in
a direction that looked functionally similar, but significantly
over-engineered, and done without building on the June RFC and its
discussion. So I raised the priority of putting Jann's code in to the
RFC, so I could send out an update demonstrating both how small I would
like the emulator to be, and how to handle things like x32.

How, exactly, am I not collaborating? I was literally trying to
thread-merge and avoid (more) extra work on YiFei Zhu's end.

-- 
Kees Cook
