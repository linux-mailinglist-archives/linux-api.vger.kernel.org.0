Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAFB1A6FE9
	for <lists+linux-api@lfdr.de>; Tue, 14 Apr 2020 02:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390348AbgDNAEo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Apr 2020 20:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390344AbgDNAEo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Apr 2020 20:04:44 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA196C0A3BDC;
        Mon, 13 Apr 2020 17:04:43 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id b13so6793971oti.3;
        Mon, 13 Apr 2020 17:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+4+rycwR8GzUJQp1X1LzbsFhbfXsBfzL6VtDkjicxak=;
        b=PDduSssba/36SmLLxi8QB4NoMeRn5QRTXCf7mFJTyZDC/QGOR2/p1vPbQJWIVJ5ajy
         TagJCMUelxZ/hb1TdPFZ4LA9nI7oQrCO/SfIWd+Q0zkMlIMwkSLAAAQV34HyP8PhS4O0
         8kyrOjNXnOppSzBk+bHH9mFW0T36xe1YntXMDsvyBPVzh+ay3pSWnLfgOHNDxRkfpgGk
         XqkrdQQNSDksd3/tY3TptpQi60Cx+mDkJZvYHTByIF9u1jPnFoid6BEVJW5phS+vPHVG
         5hKWg8Sw8BZZbyMAccx52BVyk7a0GxDq5cNNlGLE/Svjzail9yaJA1mdKPoR4EKK5PnK
         +Wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4+rycwR8GzUJQp1X1LzbsFhbfXsBfzL6VtDkjicxak=;
        b=Vg1z5V5W5OSFlX4OELtHwiB6GkNS6VWtTgwZXx3/rOPZbJ2QkzxqeJaciwLT+3IPQr
         TCiogghqUhySDGk9T7zqh9XcIqQBzF/VoO7gG2N1UjVcbE4M7U5yGOC+GWNO/oh4xKYU
         Spv0CHDh3VSgWT55uO0U/mD7lFukM6vSbFhoMkGh/hpMSatFAXJpTdfhy0sbwjta0RkS
         2b9yXGJFRwgjCEn8qR0dFMCAJvp5rMlCyTwclB3/ragJUBK28aFXbf0lHbSJlxMOTyGR
         xaaBiSD/njUuNY+Psb+4tMDSqwR866+LKvAqaXKxoXGNKs1d1+ZEu4yH8kuKLdW3vqLO
         6hLA==
X-Gm-Message-State: AGi0PuZhBQJpXwvmrQclcJe0VXg9BeFYSvp1Tstd/CE8wGttVYto+YbL
        THwsuX7q8K9ErpvbYtqnV/uNFIMiwKu7yEDHzqo=
X-Google-Smtp-Source: APiQypJOphKMyEudYUDpPvY1hqUNXvYfKKSoRuzdgrn3EUWtoedSaoR6KC92ECz98KoDyWIKX23lAv6/C6kKBSI7Gh0=
X-Received: by 2002:a9d:629a:: with SMTP id x26mr15111457otk.201.1586822682835;
 Mon, 13 Apr 2020 17:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <96bedbaf-49ea-f24b-b7b1-fb9a57fb6c7d@gmail.com>
 <20200411154031.642557-1-avagin@gmail.com> <CAKgNAki6uBHVTBdJvj7hzbho9Z94MWRV7ab8npduogQohRndBQ@mail.gmail.com>
 <20200413154746.39275d0981f69e57a7ecab3e@linux-foundation.org>
In-Reply-To: <20200413154746.39275d0981f69e57a7ecab3e@linux-foundation.org>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Mon, 13 Apr 2020 17:04:31 -0700
Message-ID: <CANaxB-xu0qcANMYMpkcfM23rdUgQxFn7v1fsa_XnzVqNF5+TpQ@mail.gmail.com>
Subject: Re: [PATCH v2] timens: show clock symbolic names in /proc/pid/timens_offsets
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 13, 2020 at 3:47 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sun, 12 Apr 2020 07:51:47 +0200 "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com> wrote:
>
> > Hi Andrei,
> >
> > On Sat, 11 Apr 2020 at 17:40, Andrei Vagin <avagin@gmail.com> wrote:
> > >
> > > Michael Kerrisk suggested to replace numeric clock IDs on symbolic
> > > names.
> > >
> > > Now the content of these files looks like this:
> > > $ cat /proc/774/timens_offsets
> > > monotonic      864000         0
> > > boottime      1728000         0
> >
> > Thanks.
> >
> > Assuming no-one has objections to the patch, please do mark for stable@.
> >
>
> `grep -r timens_offsets Documentation' comes up blank.  Is
> /proc/pid/timens_offsets documented anywhere?  If not, it should be!
> And this patch should update that documentation.
>
> I assume the time namespace feature itself is documented under clone(2)?

Thanks to Michael, we have the man page for time namespaces:
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man7/time_namespaces.7

And it will be updated according with this change.

Thanks,
Andrei
