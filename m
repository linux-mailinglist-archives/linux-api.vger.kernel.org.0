Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5DB27790E
	for <lists+linux-api@lfdr.de>; Thu, 24 Sep 2020 21:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgIXTTB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 24 Sep 2020 15:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgIXTTB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 Sep 2020 15:19:01 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC63C0613CE
        for <linux-api@vger.kernel.org>; Thu, 24 Sep 2020 12:19:00 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o8so281691ejb.10
        for <linux-api@vger.kernel.org>; Thu, 24 Sep 2020 12:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rL+0r4nsYsaTnfsp4nKpvqpdZr9u7FgIPOgyMKNt8zc=;
        b=nW6H9Ez9qPwsgMVuKmXTOIP47WKziOB7h4ORZWYHlPlZmcmBaz4bHW4IU2YbZsB5hb
         PKuFmofW4Zkf/3SgserbbqW7aN+s9iDgZbxr9QF0a+XDOyQauEYVVSL/KnakazhwL9D4
         UwrK4zx1t+sRU7ddaxgI/KYI1iAsm8WFKpkl5/8qG0kYIZDGGh7V/oUZv2AqOwFcMrap
         DSM8JWFJFnMD99cr4rEr96PRqnbogR9L4C448SM/gzvmeyrVEi1RWLhCxTScPIvkxccL
         bhyh0HeLsDXVkXxuvggdeni2CgIY8uiKUYP88tL+eo2IucDIcb5mZtmgFAHFmYwp06Dk
         cHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rL+0r4nsYsaTnfsp4nKpvqpdZr9u7FgIPOgyMKNt8zc=;
        b=K82wdpaOsqTXKmZJ/msWQeoKELIOHIE9IAJ569o/NPUIaAvjCWqSNjkc4eThCFDfH6
         bnmq5hpAb8Kx3ji9lcJsM8U+j7CV4eMnwt5nu2Bab9g2wloKtKgXZVIymuEG7tH8dksp
         AMa1qniIfTKqdeHiJC82FU1brItmuJfqa1uyoLhFLRRM+7hGcbH7Oc3SpLKk3ZdKptoN
         TYafdiov7cYbEyU1y06W6Dr93ajFsA4D6Y9XSm6TFL2QVLwtzi5NmjA3WhnHa/1VHpoS
         6ouhCTX8L63yUICSqIDzvLuvXOsPj+s57Zci9TzEv5dtuw49FSOyQO8IzlNec2Xb4U7N
         UxoA==
X-Gm-Message-State: AOAM532qsLR8KqQaY9fk2joiQ5y1TAs1+qgIaS+Wpkp09HLpU69XbMDi
        vllh3sQEvDOd83/CXd5j946eAsgcE+cFmoIDJbP1Fg==
X-Google-Smtp-Source: ABdhPJwH4eJsS5OWHswwTu13j7X710JhXzRLOlQI2ycEssSzTXiSAu4QWPI8Qvq2bTeAc49+G5jFwYQxPfgwyoykqVY=
X-Received: by 2002:a17:907:94cf:: with SMTP id dn15mr176599ejc.114.1600975139153;
 Thu, 24 Sep 2020 12:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200923232923.3142503-1-keescook@chromium.org> <20200924185702.GA9225@redhat.com>
In-Reply-To: <20200924185702.GA9225@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 24 Sep 2020 21:18:32 +0200
Message-ID: <CAG48ez3s9u+5_Bd94CP97aqBBKzno1o2obpJPSdMnsHHkOd0qg@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] seccomp: Implement constant action bitmaps
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
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
        Tianyin Xu <tyxu@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 24, 2020 at 8:57 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
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

You're missing that I did suggest the BPF emulation approach (with
code very similar to Kees' current code) back in June:
https://lore.kernel.org/lkml/CAG48ez1p=dR_2ikKq=xVxkoGg0fYpTBpkhJSv1w-6BG=76PAvw@mail.gmail.com/
