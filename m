Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0A218361A
	for <lists+linux-api@lfdr.de>; Thu, 12 Mar 2020 17:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgCLQZN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 12 Mar 2020 12:25:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46504 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbgCLQZN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Mar 2020 12:25:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id d23so7093065ljg.13
        for <linux-api@vger.kernel.org>; Thu, 12 Mar 2020 09:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yWmhDJUXIQr81tj3eSt5MgpUhrk7gN9oxNOVOserS9E=;
        b=SLSsz7RVVX6b52ACz/JyPLLkZkcdatfCUWkrNphSGRxiTdH3i/0ZPWuxLZejrvrNCB
         aFQ0QGNvMrCZqvQ81uTwGrZDythrUJ4hlHcbAsrlg/62jd40y8byXiREO1aPKzcKDQnY
         TxyLyZdVZ/bL1I3pgBX8P/qMMqbm0kUimV1sA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yWmhDJUXIQr81tj3eSt5MgpUhrk7gN9oxNOVOserS9E=;
        b=T62xLtTnlKt/Y9H8yeJF5VXybDyMCYdwu93lm6ILheWrGt7ER2j90lm67DSq9AZ2g3
         FuCqbkIWnUXrvpKkCcpCPsEkDQtb1o2wcrpCXC9WDp2PedNM+XFzjr793unkIH3XRkVt
         +boSKdVKzeM+U2pX04pG8LMI9jfDWXRRSKT6PoCykqExFXXx04mgigOz6EGcR+cVc/n3
         CvmpFcrSjNNxzg9H5VjoSZkP8NpRCEQydMn0V1nok/lZGP+1gdhp/mnC+/4rRhht4n06
         KOj4W3TBAC+6fTQcN9xkRbVFlY8yPO35E9+ZqXe02tM1TLrr3JHQJWOpBNMFaRX7ztx9
         S0pw==
X-Gm-Message-State: ANhLgQ1PwvPVmc5Wa637WDV7QlDwqUn1JL0i/gM7SHkS2JbIi1kWsbBv
        /l/uklMnT5x6T0bJ3fL1Jqp8DVKdpZc=
X-Google-Smtp-Source: ADFU+vvRhocTZp9qOyBZbwAupJJgeDOnXMng6rdMQuLQ1B3WlOIfnzYfbuClcZd/y5LsTUWikNBtwA==
X-Received: by 2002:a05:651c:1026:: with SMTP id w6mr5441399ljm.168.1584030309290;
        Thu, 12 Mar 2020 09:25:09 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id i23sm12413899ljg.102.2020.03.12.09.25.05
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 09:25:06 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id c20so5381539lfb.0
        for <linux-api@vger.kernel.org>; Thu, 12 Mar 2020 09:25:05 -0700 (PDT)
X-Received: by 2002:a19:6144:: with SMTP id m4mr5637868lfk.192.1584030305566;
 Thu, 12 Mar 2020 09:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
 <20200310005549.adrn3yf4mbljc5f6@yavin> <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
 <580352.1583825105@warthog.procyon.org.uk> <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
 <3d209e29-e73d-23a6-5c6f-0267b1e669b6@samba.org>
In-Reply-To: <3d209e29-e73d-23a6-5c6f-0267b1e669b6@samba.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Mar 2020 09:24:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
Message-ID: <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
To:     Stefan Metzmacher <metze@samba.org>
Cc:     David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, jlayton@redhat.com,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Mar 12, 2020 at 2:08 AM Stefan Metzmacher <metze@samba.org> wrote:
>
> The whole discussion was triggered by the introduction of a completely
> new fsinfo() call:
>
> Would you propose to have 'at_flags' and 'resolve_flags' passed in here?

Yes, I think that would be the way to go.

> > If we need linkat2() and friends, so be it. Do we?
>
> Yes, I'm going to propose something like this, as it would make the life
> much easier for Samba to have the new features available on all path
> based syscalls.

Will samba actually use them? I think we've had extensions before that
weren't worth the non-portability pain?

But yes, if we have a major package like samba use it, then by all
means let's add linkat2(). How many things are we talking about? We
have a number of system calls that do *not* take flags, but do do
pathname walking. I'm thinking things like "mkdirat()"?)

> In addition I'll propose to have a way to specify the source of
> removeat and unlinkat also by fd in addition to the the source parent fd
> and relative path, the reason are also to detect races of path
> recycling.

Would that be basically just an AT_EMPTY_PATH kind of thing? IOW,
you'd be able to remove a file by doing

   fd = open(path.., O_PATH);
   unlinkat(fd, "", AT_EMPTY_PATH);

Hmm. We have _not_ allowed filesystem changes without that last
component lookup. Of course, with our dentry model, we *can* do it,
but this smells fairly fundamental to me.

It might avoid some of the extra system calls (ie you could use
openat2() to do the path walking part, and then
unlinkat(AT_EMPTY_PATH) to remove it, and have a "fstat()" etc in
between the verify that it's the right type of file or whatever - and
you'd not need an unlinkat2() with resolve flags).

I think Al needs to ok this kind of change. Maybe you've already
discussed it with him and I just missed it.

            Linus
