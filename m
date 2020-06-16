Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762371FBC2C
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2020 18:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgFPQ4b (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Jun 2020 12:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbgFPQ4b (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Jun 2020 12:56:31 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DE2C061573
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 09:56:30 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l10so21493409wrr.10
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 09:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hwa2L1ImB15dIKmz7yLgrRrD9ZoRLynU8SCNI5jmVrA=;
        b=pBngrVW0fXgxGsUIB6iI6b9pR1mda14Neyp1D17D1rL+Hqqb3DpCGo4eohRlSyVnzp
         uvF3VYCjFeCCj0VsPcT6xwM8ISHlqv4N5ntmdzKgH4vComcnzC9on7c3xslUejjFZWGM
         hXigSpz86luPhPTAC1e4heu2+L7XscKr5Q3H30PhoXE+OzrYjT1a5miTd3j9fMF9b3iy
         IfDUsBdSDAtFknCr4P442lz/V/lJ7q39XCwc5W9Er4R5wuYuKbb2U0YDZkPJJ+BElZ1L
         11ngbe3M814XPzBZu6XvpnCwnqVyASlReBROo1HnYGUcuy3HkB4Ia68i5OwT7Jz11zxs
         F+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hwa2L1ImB15dIKmz7yLgrRrD9ZoRLynU8SCNI5jmVrA=;
        b=P+9VM+hFYxZid7LPWM0OjKncOiZb4b9urZZu/upEL4ZZuDkpnhcPw01x4ely0fVYLH
         dCxgfsRcBrE7XP5Z9r1Nizi1+F1FfJXsjRgTuajoDjSFjwrlReyhSD19TCNRKM9BsMwc
         gskXF+Oe36Wbv4dyOc0U22QHFoXwgZKf5JFMDN0js0UOAjTEAt1tiYNTGY+g6iZwiaqq
         GZ2iB3m/MF9BQqs21qIhQ7C4RfDFveiBVj0N0k8DGEOU82stHxrOA98jrPZiZumLEgyE
         3oDkjN54BAzwWB6a+/EYFpJwJXWFWlWtwSYfgBNVU50eEbcBiVEnanh93zfZo4X9C94i
         U4NQ==
X-Gm-Message-State: AOAM533A70/FVXOG2gnrMkmf+X67iW9/3WwgJcCZEU5dwaJzjVPHUpm3
        3RaiPepwRCUWCw8LxK22eqjo04KbgEAKv8L2yU0/SQ==
X-Google-Smtp-Source: ABdhPJwlsWcL5tuSvSwcQCGpYRnQYLKsq+2Pt1JDO4/kJYBxWuUrjKMfTrAQtvwN0YDp9Y7hqi4ccSQZ4XHm6yl3W90=
X-Received: by 2002:adf:e387:: with SMTP id e7mr3978360wrm.70.1592326589637;
 Tue, 16 Jun 2020 09:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200616074934.1600036-1-keescook@chromium.org> <20200616074934.1600036-4-keescook@chromium.org>
In-Reply-To: <20200616074934.1600036-4-keescook@chromium.org>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 16 Jun 2020 09:56:18 -0700
Message-ID: <CALCETrUs2Xso=Yztmcrx_7bmXYoPLpcHeNpQSgcbSbvM_Jkw5w@mail.gmail.com>
Subject: Re: [PATCH 3/8] seccomp: Introduce SECCOMP_PIN_ARCHITECTURE
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Will Drewry <wad@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Hehuazhen <hehuazhen@huawei.com>, X86 ML <x86@kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jun 16, 2020 at 12:49 AM Kees Cook <keescook@chromium.org> wrote:
>
> For systems that provide multiple syscall maps based on architectures
> (e.g. AUDIT_ARCH_X86_64 and AUDIT_ARCH_I386 via CONFIG_COMPAT), allow
> a fast way to pin the process to a specific syscall mapping, instead of
> needing to generate all filters with an architecture check as the first
> filter action.

Can you allow specification of the reject action?  I can see people
wanting TRAP instead, for example.
