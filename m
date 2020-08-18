Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D21A248F8E
	for <lists+linux-api@lfdr.de>; Tue, 18 Aug 2020 22:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgHRUSs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 18 Aug 2020 16:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgHRUSm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 18 Aug 2020 16:18:42 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42F5C061343
        for <linux-api@vger.kernel.org>; Tue, 18 Aug 2020 13:18:41 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id m20so16292946eds.2
        for <linux-api@vger.kernel.org>; Tue, 18 Aug 2020 13:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QeMExisTCX54PfEU0UFsxsWYaAtAPl2dvOoQQ7l6gvs=;
        b=SELtgIId7tpSP3rmyBh4NRgeVCONpRS3Kwr7JecG6Xg6+vzYRIisCUg3FJv+Cr6T6n
         r4cGwCap2uiavvQL3GQY2HPmVJFtyyif7TGfGMQQV2oMQDdM+f6uaXHdF++Gpi5mVMhF
         widzUPi29Qjx42/Abjmra+ObbS6HtZ+ev4gqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QeMExisTCX54PfEU0UFsxsWYaAtAPl2dvOoQQ7l6gvs=;
        b=dtz8jr8+o/DXYil2al9rzLrapz4/L8YOCtNHW/AJry2FbhqjbX6RDImC/MoLd2JCEP
         Q+/NpwMB3yAN/Pfh4AyDExrH3vRruqUkbKVFoG+H/t0If81Gb83Qxw5lKOh6jxOAhlvM
         CnDqN0eSMinjhYf0l+63WLYL4rAHV/i5JvvfuTRSVi2Rxbw4+l/972gGoCvksV8zeuDJ
         iiAX5mePWbd/d4iPfR/M1UQ5KQNOsw/mfh2JuuM5l10CLmDmdK++Ch0KSbeCuhtZFQ1o
         EN86nTvRKIgvD0XcJhOzv5A4gCmB395893GetwusOfKPPwCwMrexoR3ysmOfWDMYqrxY
         Un5w==
X-Gm-Message-State: AOAM5328NyBK/YhebEyy7dbn5nHHxPPkoI/VT1gLIIqfi2XY7fSzvQsA
        YjiouH+jnVnQ8Ks0tPv1QrzsnySfsFvyHlPDBihmUw==
X-Google-Smtp-Source: ABdhPJwQ2obJGVbMSKVirBR81H6xRXbWQqC1R7MEO/Fz7AW23R0Arh8JQvECxjqKxtFxUrpY3WjBonHXIE3ypgOllSU=
X-Received: by 2002:aa7:d5d0:: with SMTP id d16mr20989643eds.212.1597781920338;
 Tue, 18 Aug 2020 13:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk> <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
 <066f9aaf-ee97-46db-022f-5d007f9e6edb@redhat.com> <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
 <94f907f0-996e-0456-db8a-7823e2ef3d3f@redhat.com> <CAHk-=wig0ZqWxgWtD9F1xZzE7jEmgLmXRWABhss0+er3ZRtb9g@mail.gmail.com>
 <CAHk-=wh4qaj6iFTrbHy8TPfmM3fj+msYC5X_KE0rCdStJKH2NA@mail.gmail.com>
 <CAJfpegsr8URJHoFunnGShB-=jqypvtrmLV-BcWajkHux2H4x2w@mail.gmail.com> <CAHk-=wh5YifP7hzKSbwJj94+DZ2czjrZsczy6GBimiogZws=rg@mail.gmail.com>
In-Reply-To: <CAHk-=wh5YifP7hzKSbwJj94+DZ2czjrZsczy6GBimiogZws=rg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 18 Aug 2020 22:18:29 +0200
Message-ID: <CAJfpegt9yEHX3C-sF9UyOXJcRa1cfDnf450OEJ47Xk=FmyEs8A@mail.gmail.com>
Subject: Re: file metadata via fs API
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Aug 18, 2020 at 8:51 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> I think people who have problems parsing plain ASCII text are just
> wrong. It's not that expensive. The thing that makes /proc/mounts
> expensive is not the individual lines - it's that there are a lot of
> them.

I agree completely with the above.

So why mix a binary structure into it?  Would it not make more sense
to make it text only?

I.e. NAME=VALUE pairs separated by newlines and quoting non-printable chars.

Thanks,
Miklos
