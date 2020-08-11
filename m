Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82F9241D27
	for <lists+linux-api@lfdr.de>; Tue, 11 Aug 2020 17:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgHKPas (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 11 Aug 2020 11:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbgHKPap (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 11 Aug 2020 11:30:45 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C62C061788
        for <linux-api@vger.kernel.org>; Tue, 11 Aug 2020 08:30:45 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id bo3so13520340ejb.11
        for <linux-api@vger.kernel.org>; Tue, 11 Aug 2020 08:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+Iq2qCHUHVaNAKHuF0ZSvBIxw9aZEr5eRrwEH0pyDM=;
        b=UHuiqJr7X2atxIGSHLT+svSK5gdNsubwckkEdoLhXVa0P5T2fMneByo6aZKzG8LldX
         T1q+WwMY0FUEt+jhdI91DgqUpJ4E3NQyPft4lnwP2z3OP679ywggUOEnwc9ZpPQSZeqm
         UJZcOolg7KSv4Nk5wS9SsRafbH+gx/jq+8o2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+Iq2qCHUHVaNAKHuF0ZSvBIxw9aZEr5eRrwEH0pyDM=;
        b=Q3hwJSwR39jEO/aAQd+iBbf8VBNNDDKR+WJqtHePriLT02Ez+S+2PiMkHd/0X1ED3o
         R8iJuh1Tma4Ot4RIz87RO+TvYtqX68E4ASIrItNJ3AE6ZORxhaj/q3TYHxkPPYJXJDBk
         W1qC6fMnD0WVmwTqb9pWuF3wPlUk6VOWAWZ+X1SLRubSmGpF0qzaPRZGFUoHJJpbmVI6
         FO0gBQS57bnWZCYsVlWz7OB8kvRRFGdqdpqJjziBcyRO+AP780B583sdbeukirfVsXGs
         qcpiMltV4DWRlo9jyN376P9qFyBeOx/A39mb7HiBYPjc+nRBUPYX/neEQgu4PJsbAvm1
         JYWg==
X-Gm-Message-State: AOAM531DYE7p/zDIg98UbWNW95jE79YrcghD0CJMSvAvrhpqeJJK3tgP
        PiMYYKOcXaOUtBtjJASEaTdJDW8VjGZ7oPV6KwO7Lw==
X-Google-Smtp-Source: ABdhPJzBzum8mnm+vTGkWQzIaTCUoEszBkoemTUzdbDb+99lWLtwfHPa77uVvxYBE8u6HRWpehJ7Yt8BQd5fvoZKDLs=
X-Received: by 2002:a17:907:94ca:: with SMTP id dn10mr26676759ejc.110.1597159843363;
 Tue, 11 Aug 2020 08:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
In-Reply-To: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 11 Aug 2020 17:30:32 +0200
Message-ID: <CAJfpegtWai+5Tzxi1_G+R2wEZz0q66uaOFndNE0YEQSDjq0f_A@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
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

On Tue, Aug 11, 2020 at 5:20 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> [ I missed the beginning of this discussion, so maybe this was already
> suggested ]
>
> On Tue, Aug 11, 2020 at 6:54 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > >
> > > E.g.
> > >   openat(AT_FDCWD, "foo/bar//mnt/info", O_RDONLY | O_ALT);
> >
> > Proof of concept patch and test program below.
>
> I don't think this works for the reasons Al says, but a slight
> modification might.
>
> IOW, if you do something more along the lines of
>
>        fd = open(""foo/bar", O_PATH);
>        metadatafd = openat(fd, "metadataname", O_ALT);
>
> it might be workable.

That would have been my backup suggestion, in case the unified
namespace doesn't work out.

I wouldn't think the normal lookup rules really get in the way if we
explicitly enable alternative path lookup with a flag.  The rules just
need to be documented.

What's the disadvantage of doing it with a single lookup WITH an enabling flag?

It's definitely not going to break anything, so no backward
compatibility issues whatsoever.

Thanks,
Miklos
