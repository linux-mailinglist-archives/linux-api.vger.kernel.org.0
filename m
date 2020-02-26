Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE1DC16FA4A
	for <lists+linux-api@lfdr.de>; Wed, 26 Feb 2020 10:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbgBZJLR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 26 Feb 2020 04:11:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34365 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726425AbgBZJLR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 26 Feb 2020 04:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582708275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oEqkrC4VLq8DaEUXXUlw4qM+t78tq2tEXmDFeRSdK/U=;
        b=LYX8khLquEaMYAmpi8dZX3a+4Tcgs9mZJYjMH41sxOF7boBZdvJzapJhBKV1BVnE/L8F8/
        ZS7/GiU4Ss5VGv1pjHMadZKd2jnrK+Fq1Qchy0tT/2t0s5RfI3MFC8/J3fBwDJT1feTUyj
        ZrDunVqgNfN4YYsXgwirggJqlOGEjGQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-LTGjcQN5MLG0mh-qbbj0Kg-1; Wed, 26 Feb 2020 04:11:13 -0500
X-MC-Unique: LTGjcQN5MLG0mh-qbbj0Kg-1
Received: by mail-qt1-f198.google.com with SMTP id z25so3593644qto.8
        for <linux-api@vger.kernel.org>; Wed, 26 Feb 2020 01:11:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oEqkrC4VLq8DaEUXXUlw4qM+t78tq2tEXmDFeRSdK/U=;
        b=DEO1S344sMbmC7wlVWQbHEaboK5lwl2o1hDdkLw99eJdrZZPTh3h+b7P4PYynD0Dgi
         kRxURlaMV7VQ4O8UD3fAgm8CdAdrf3p9vxeIlC/RlNk9L9jWVRUsYCY8d48tEyykVvNC
         dXYOeKMBTXEyqPxD/Nla/2/QwuZMV7LtHNrlx8UrYoVx/NJ9IiL7hUH6xsAIexQUYKBr
         SajDJGSRIsBcyIeWyn0Q2hHksHBu1xUpaZWF5EeG1zLsq738bSu0czxeIw3fyoCcl/5u
         mlhknWZ0fPCUn62bedz3GGg4Ir2g364ItrH3UF47UOVaMBbu4QxavCd4K1m/WP5y2xSf
         vjvA==
X-Gm-Message-State: APjAAAVRvzZ8jdq6W7l3wARZ2xqAqpIlt4aKgDoEtgXKAHBKT1wV59nW
        EzKGu3OQt+2tP/9nNev0TH25PydcEIT+kOfEPYohWLt+9/mNnqo2TB2voTPa/f+ubDm3YgRxwtT
        hV1nsH07cdoBkfDTHBO2Dv0dXBMs3jJbs++Ls
X-Received: by 2002:a37:40d2:: with SMTP id n201mr4423911qka.211.1582708273451;
        Wed, 26 Feb 2020 01:11:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqxXjPA2Pp28AoAuqRyzeCA+TX5xe5BSYiQaT9UAKY0Cw8GAaR+YwHF7q/xXePrlEyxxI8KoSd+4S3BP8Ddn7Zw=
X-Received: by 2002:a37:40d2:: with SMTP id n201mr4423885qka.211.1582708273224;
 Wed, 26 Feb 2020 01:11:13 -0800 (PST)
MIME-Version: 1.0
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <1582316494.3376.45.camel@HansenPartnership.com> <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
 <1582556135.3384.4.camel@HansenPartnership.com> <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com> <1582644535.3361.8.camel@HansenPartnership.com>
In-Reply-To: <1582644535.3361.8.camel@HansenPartnership.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Wed, 26 Feb 2020 10:11:02 +0100
Message-ID: <CAOssrKfaxnHswrKejedFzmYTbYivJ++cPes4c91+BJDfgH4xJA@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Feb 25, 2020 at 4:29 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:

> The other thing a file descriptor does that sysfs doesn't is that it
> solves the information leak: if I'm in a mount namespace that has no
> access to certain mounts, I can't fspick them and thus I can't see the
> information.  By default, with sysfs I can.

That's true, but procfs/sysfs has to deal with various namespacing
issues anyway.  If this is just about hiding a number of entries, then
I don't think that's going to be a big deal.

The syscall API is efficient: single syscall per query instead of
several, no parsing necessary.

However, it is difficult to extend, because the ABI must be updated,
possibly libc and util-linux also, so that scripts can also consume
the new parameter.  With the sysfs approach only the kernel needs to
be updated, and possibly only the filesystem code, not even the VFS.

So I think the question comes down to:  do we need a highly efficient
way to query the superblock parameters all at once, or not?

Thanks,
Miklos

