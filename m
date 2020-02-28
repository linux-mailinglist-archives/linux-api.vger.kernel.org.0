Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8E2173BB4
	for <lists+linux-api@lfdr.de>; Fri, 28 Feb 2020 16:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgB1PkV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 28 Feb 2020 10:40:21 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37415 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgB1PkV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 28 Feb 2020 10:40:21 -0500
Received: by mail-io1-f67.google.com with SMTP id c17so3859272ioc.4
        for <linux-api@vger.kernel.org>; Fri, 28 Feb 2020 07:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9LqrzC6b4MYZRRh7fElw2sFSCD8yqepAp1R1qGOOE9o=;
        b=J8Yk12NMM3aPoUGzMtUEGaWQFyt3fGjSMbPBBqAHvUe0SiUviOzH6VRNTh7x/BJ7Nk
         fo5M6inLsbXFrgRv1vvzEFHoaLLfvF0hcPU0nGmaPzvQ0XYHYF3wvsXRgaRhkpjx0NjV
         kUMeGbbANhNsXkeTJ9LhowDRAkP/N2ybtUnaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9LqrzC6b4MYZRRh7fElw2sFSCD8yqepAp1R1qGOOE9o=;
        b=FGGdt1Yf49c4Cz00cPdyw+13xQ3+l3qUgQEyuZ+vCCMbBEOxLov/XEgpIjn7agd4aW
         QzFw27yHU8pv/SIuGco8V8n7TJc2X+ApJPnbX+qJqi2GoIzlEZPQ2O6rsvOKTy/7Ueuz
         Fv/HzdfHqBYWwBqwrYTaRKSoCexRwLi9NUgwGPZvdypt7cYsySGEWPxiLziINONLzLsy
         awlaPRiNSNg5LxXl6zdD2xqkCpO6zfdfqShMp0oYN/5tNUSa+ull1B5vanO7NEUrWVQg
         vm+8fXlon8Q3Dy2n6FGXWAXpHA+M8hKeODGg4EpLVvRC3ZORUgKktxKbGckUDTrN2f+f
         +Khg==
X-Gm-Message-State: APjAAAVG82fWYQJghKjyG9T8qunhh2jpPCSroN6obxN38ndpZEt5ZQto
        fnvl55YSU9P4R5LtOAqn5gYyRI54RN8poutmMlGzYw==
X-Google-Smtp-Source: APXvYqxWaKGs/GMkcpGpUL7E+8RUggAdz5iFOr+Psoqlg5UOSbDYmueoqkK9GE5rgDFb+W9horX9kqWoe/ME2cmp0yI=
X-Received: by 2002:a02:6a10:: with SMTP id l16mr3820784jac.77.1582904420636;
 Fri, 28 Feb 2020 07:40:20 -0800 (PST)
MIME-Version: 1.0
References: <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
 <1582556135.3384.4.camel@HansenPartnership.com> <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com> <1582644535.3361.8.camel@HansenPartnership.com>
 <CAOssrKfaxnHswrKejedFzmYTbYivJ++cPes4c91+BJDfgH4xJA@mail.gmail.com>
 <1c8db4e2b707f958316941d8edd2073ee7e7b22c.camel@themaw.net>
 <CAJfpegtRoXnPm5_sMYPL2L6FCZU52Tn8wk7NcW-dm4_2x=dD3Q@mail.gmail.com>
 <3e656465c427487e4ea14151b77d391d52cd6bad.camel@themaw.net>
 <CAJfpegu5xLcR=QbAOnUrL49QTem6X6ok7nPU+kLFnNHdPXSh1A@mail.gmail.com>
 <20200227151421.3u74ijhqt6ekbiss@ws.net.home> <ba2b44cc1382c62be3ac896a5476c8e1dc7c0230.camel@themaw.net>
 <CAJfpeguXPmw+PfZJFOscGLm0oe7dUQY4CYXazx9=x020Fbe86A@mail.gmail.com> <1582902521.3338.20.camel@HansenPartnership.com>
In-Reply-To: <1582902521.3338.20.camel@HansenPartnership.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 28 Feb 2020 16:40:09 +0100
Message-ID: <CAJfpegtZ0EYhQYeUmqYNd+Y+K88g4P6BKahhtf7VkuXZoe_UYQ@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Ian Kent <raven@themaw.net>, Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        David Howells <dhowells@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Feb 28, 2020 at 4:09 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:

> Containers are file based entities, so file descriptors are their most
> natural thing and they have full ACL protection within the container
> (can't open the file, can't then get the fd).  The other reason
> container people like file descriptors (all the Xat system calls that
> have been introduced) is that if we do actually need to break the
> boundaries or privileges of the container, we can do so by getting the
> orchestration system to pass in a fd the interior of the container
> wouldn't have access to.

Yeah, agreed about the simplicity of fd based access.   Then again a
filesystem access would allow immediate access to all scripts,
languages, etc.  That, I think is a huge bonus compared to the
ioctl-like mess that the current proposal is, which would require
library, utility, language binding updates on all changes.  Ugh.

One way to resolve that is to have the mount information
magic-symlinked from /proc/PID/fdmount/FD directly to the mountinfo
dir, which would then have a link into the sbinfo dir.  With other
access denied to all except sysadmin.

Would that work?

Thanks,
Miklos
