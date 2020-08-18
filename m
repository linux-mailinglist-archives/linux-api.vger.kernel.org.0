Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C9D248546
	for <lists+linux-api@lfdr.de>; Tue, 18 Aug 2020 14:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgHRMux (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 18 Aug 2020 08:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgHRMur (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 18 Aug 2020 08:50:47 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B760C061343
        for <linux-api@vger.kernel.org>; Tue, 18 Aug 2020 05:50:47 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id t15so15103068edq.13
        for <linux-api@vger.kernel.org>; Tue, 18 Aug 2020 05:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fFLadAGytIbd6Cde9KqrXGMzmbxXEZAqgtRrBn6qG1k=;
        b=kwpEsN1R8kGzBgmiohXGBZgKhiEohfySxA4S1MY16t8M7GjlXhS8WB6B+ckdr+Ugzu
         NyGaVnYxne0bipWKHzdc7aHgrK7BCFA5GPEZ4KlzlIVwgbsHkZbCaCsbUfEym5+PO6MQ
         8EEjkbG/zZtLFIzG+9In1Pyo0bXAM7GI10ja4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fFLadAGytIbd6Cde9KqrXGMzmbxXEZAqgtRrBn6qG1k=;
        b=nTKvNSC5d5Ll0pvWxj9+jUZDzeoEpOn3jzoK99xEE7zZfUS20/7I9gd9N9z/TUoN6c
         hxcyYws6ncXKeLeG74X/AkU8PyKslxUw+gwXSOHKAH+tReazTsOt2bIZfDYMv5KqleBa
         KboRV//oA2n1BBUFyvKqa1/5N0cE85fLE0NI17L452xNOST0761+T4AqazZwlchx2TLR
         9zXfzztJ8T2ACpigFwaSPiN0+Z00Qzv7Kpp1AQIMCJ5rhe9Ba6A8FKpVwXsYEybEIX/h
         JkQ7hxUbym8cfKruwZvrnnuwrG35KL8x5/xFBHtDx6VyiNFviGLasFgxvP+ctJTycD3o
         XhfQ==
X-Gm-Message-State: AOAM531gK7QSDRD96OGPPpkxhpFn8xXCNlpcXqfGlkf3ZaCCsdk/sffC
        Ubov6YtQ7RoBPLAFKx0pWEWWRsQDbIc9NFDNQlEp5A==
X-Google-Smtp-Source: ABdhPJxXjvpMrRuOGDAZZiMkm9L4E1Gzc1z9smi3A79LHbSHxaELKwrkyMmeNUkO/4bFpdYJUvYB0HAAUfI7kyaNEms=
X-Received: by 2002:a05:6402:13d4:: with SMTP id a20mr20108726edx.161.1597755044073;
 Tue, 18 Aug 2020 05:50:44 -0700 (PDT)
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
In-Reply-To: <CAHk-=wh4qaj6iFTrbHy8TPfmM3fj+msYC5X_KE0rCdStJKH2NA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 18 Aug 2020 14:50:32 +0200
Message-ID: <CAJfpegsr8URJHoFunnGShB-=jqypvtrmLV-BcWajkHux2H4x2w@mail.gmail.com>
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

On Tue, Aug 18, 2020 at 12:44 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> So please. Can we just make a simple extended statfs() and be done
> with it, instead of this hugely complex thing that does five different
> things with the same interface and makes it really odd as a result?

How do you propose handling variable size attributes, like the list of
fs options?

Otherwise I'm fine with a statx-like interface for querying fs/mount attributes.

Thanks,
Miklos
